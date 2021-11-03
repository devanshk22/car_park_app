import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:intl/intl.dart';
import '../constants/databaseConsts.dart';
import '../entities/all.dart';

void main() => runApp(MaterialApp(
        home: TextButton(
      child: Text("Run test"),
      onPressed: () => test(),
    )));

test() async {
  await Firebase.initializeApp();
  DatabaseCtrl test = DatabaseCtrl();

  var output = await test.getCarparkByAddress("Blk 215 Ang Mo Kio Street 22");
  print(output);
}

class DatabaseCtrl {
  static const String _carparkInfoID = "139a3035-e624-4f56-b63f-89ae28d4ae4c";

  late CollectionReference _carparkInfoCollection;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection(userConst.collectionName);

  late Geoflutterfire _geo;

  DatabaseCtrl() {
    _carparkInfoCollection = FirebaseFirestore.instance
        .collection(carparkConst.collectionName)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                Carpark.fromJson(snapshot.id, snapshot.data() as Map),
            toFirestore: (object, _) =>
                (object as CarparkDataHandler).toJson());

    _geo = Geoflutterfire();
  }

  //Get user account data
  Stream<QuerySnapshot> get userData {
    return _userCollection.snapshots();
  }

  Future<Map> _ckanQuery(
      {String resourceID = _carparkInfoID, int? limit, int? offset}) async {
    // form CKAN query URL
    String query =
        'https://data.gov.sg/api/action/datastore_search?resource_id=$resourceID';
    if (limit != null) query += "&limit=${limit.toString()}";
    if (offset != null) query += "&offset=${offset.toString()}";

    // Query data
    http.Response response = await http.get(Uri.parse(query));
    return json.decode(response.body)['result'];
  }

  Future<Map> _gridToLatLong(String x, String y) async {
    String query =
        'https://developers.onemap.sg/commonapi/convert/3414to4326?X=$x&Y=$y';
    http.Response response = await http.get(Uri.parse(query));
    return json.decode(response.body);
  }

  Future<Object?> _getDocument(
          CollectionReference collection, String id) async =>
      await collection.doc(id).get().then((snapshot) => snapshot.data());

  Future<Carpark> getCarpark(String carparkNo) async =>
      await _getDocument(_carparkInfoCollection, carparkNo) as Carpark;

  Future<Carpark> getCarparkByAddress(String address) async {
    // Retireve carpark
    List<QueryDocumentSnapshot> docSnapshots = await _carparkInfoCollection
        .where("address", isEqualTo: address)
        .get()
        .then((snapshot) => snapshot.docs);
    Carpark carpark = docSnapshots[0].data() as Carpark;

    // Retrieve available carpark info
    Map<String, int> availableCarparkInfo = await getAvailableCarparkInfo();
    carpark.availableLots = availableCarparkInfo.containsKey(carpark.carparkNo)
        ? availableCarparkInfo[carpark.carparkNo]
        : 0;
    return carpark;
  }

  Future<List<Carpark>> getAllCarparks() async {
    List<QueryDocumentSnapshot> carparkDocs =
        await _carparkInfoCollection.get().then((snapshot) => snapshot.docs);
    List<Carpark> carparks = [];
    for (int i = 0; i < carparkDocs.length; i++)
      carparks.add(carparkDocs[i].data() as Carpark);
    return carparks;
  }

  Future<List<String>> getAllCarparkAddresses() async {
    CollectionReference collRef =
        FirebaseFirestore.instance.collection(carparkConst.collectionName);
    List<QueryDocumentSnapshot> docSnapshots =
        await collRef.get().then((snapshot) => snapshot.docs);
    List<String> addresses = [];
    for (QueryDocumentSnapshot snapshot in docSnapshots)
      addresses.add((snapshot.data() as Map)[carparkConst.address]);
    return addresses;
  }

  Future<List<Carpark>> getNearbyCarparks(
      [double? latitude, double? longitude, double? radius]) async {
    if ((latitude == null) || (longitude == null)) {
      latitude = 1.307778;
      longitude = 103.930278;
    }
    if (radius == null) radius = 1.0;
    GeoFirePoint center = _geo.point(latitude: latitude, longitude: longitude);
    CollectionReference collection =
        FirebaseFirestore.instance.collection(carparkConst.collectionName);
    Stream stream = _geo
        .collection(collectionRef: collection)
        .within(center: center, radius: radius, field: "location");
    await for (List<DocumentSnapshot> snapshots in stream) {
      List<Carpark> carparks = [];
      Carpark carpark;
      for (DocumentSnapshot snapshot in snapshots) {
        carpark = Carpark.fromJson(snapshot.id, snapshot.data() as Map);
        carparks.add(carpark);
      }
      return carparks;
    }
    return [];
  }

  Future<Map<String, int>> getAvailableCarparkInfo([DateTime? dateTime]) async {
    String query = "https://api.data.gov.sg/v1/transport/carpark-availability";
    if (dateTime != null)
      query +=
          "?date_time=${DateFormat("yyyy-MM-ddTHH%3Amm%3Ass").format(dateTime)}";
    http.Response response = await http.get(Uri.parse(query));
    List carparks = json.decode(response.body)["items"][0]["carpark_data"];
    Map<String, int> carparkInfo = {};
    String carparkNo;
    int availableLots;
    for (Map carpark in carparks) {
      carparkNo = carpark["carpark_number"];
      availableLots = int.parse(carpark["carpark_info"][0]["lots_available"]);
      carparkInfo[carparkNo] = availableLots;
    }
    return carparkInfo;
  }

  Future<void> updateCarparkInfo() async {
    // Get number of rows
    Map result = await _ckanQuery(limit: 3000);
    // get data
    List data = result["records"];

    // Update database
    Map latLong;
    GeoFirePoint location;
    Map dataRow;
    for (var i = 0; i < data.length; i++) {
      dataRow = data[i];

      // Format data
      Map latLong = await _gridToLatLong(
          dataRow[carparkInfoConst.xCoord], dataRow[carparkInfoConst.yCoord]);
      location = _geo.point(
          latitude: latLong["latitude"], longitude: latLong["longitude"]);
      dataRow[carparkConst.location] = location;
      CarparkDataHandler carpark = CarparkDataHandler.fromJson(dataRow);

      // if document exists in collection, update document
      // else, add document
      await _carparkInfoCollection.doc(carpark.id).set(carpark);

      print("updated carpark ${(i + 1).toString()}");
    }

    print("update completed");
  }

  Future<UserAccount> getUser(String uid) async {
    // Get user information
    Map userMapData = await _getDocument(_userCollection, uid) as Map;

    DocumentReference userDocRef = _userCollection.doc(uid);

    // Get bookings
    QuerySnapshot querySnapshot = await userDocRef
        .collection(bookingConst.collectionName)
        .orderBy(bookingConst.startTime, descending: true)
        .get();
    List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;

    // Get favourites
    List favouriteRefs = userMapData[userConst.favourites];
    // Convert document references to carpark objects
    List<Carpark> favourites = [
      for (int i = 0; i < favouriteRefs.length; i++)
        await getCarpark(favouriteRefs[i].id)
    ];
    userMapData[userConst.favourites] = favourites;

    return UserAccount.fromJson(uid, userMapData);
  }

  Future<void> addUser(UserAccount user) async {
    print(user.toJson());
    await _userCollection.doc(user.id).set(user.toJson());
  }

  Future<void> _updateUserFields(String userEmail, Map data) async =>
      _userCollection.doc(userEmail).update(data as Map<String, Object?>);

  Future<void> updateUserInfo(UserAccount user) async =>
      _updateUserFields(user.id, user.userInfoToJson());

  Future<void> updateFavourites(UserAccount user) async =>
      _updateUserFields(user.id, user.favouritesToJson());

  Future<void> removeFavourites(UserAccount user) async {
    await _userCollection.doc(user.id).set(
        {userConst.favourites: FieldValue.delete()}, SetOptions(merge: true));
    await _userCollection.doc(user.id).set(user.toJson());
  }

  // this function updates everything except bookings
  Future<void> updateUser(UserAccount user) async =>
      await _userCollection.doc(user.id).update(user.toJson());

  Future<void> removeUser(String email) async =>
      await _userCollection.doc(email).delete();
}
