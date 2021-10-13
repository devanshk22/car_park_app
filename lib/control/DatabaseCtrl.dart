import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import '../constants/databaseConsts.dart';
import '../entities/all.dart';

void main() => runApp(MaterialApp(
    home: TextButton(
      child: Text("Test function"),
      onPressed: () => test(),
    )
)
);

test () async {
  await Firebase.initializeApp();
  DatabaseCtrl test = DatabaseCtrl();
  var result = await test.getNearbyCarparks(1.307778, 103.930278, 1);
  print("back in test");
  print(result);
}


class DatabaseCtrl{
  static const String _carparkInfoID = "139a3035-e624-4f56-b63f-89ae28d4ae4c";

  late CollectionReference carparkInfoCollection;
  late CollectionReference userCollection;

  late Geoflutterfire geo;

  DatabaseCtrl(){
    carparkInfoCollection = FirebaseFirestore.instance
        .collection(carparkConst.collectionName)
        .withConverter(
          fromFirestore: (snapshot, _) => Carpark.fromJson(snapshot.id, snapshot.data() as Map),
          toFirestore: (object, _) => (object as CarparkDataHandler).toJson()
        );
    userCollection = FirebaseFirestore.instance.collection(userConst.collectionName);

    geo = Geoflutterfire();
  }

  Future<Map> _ckanQuery({String resourceID = _carparkInfoID, int? limit, int? offset}) async{
    // form CKAN query URL
    String query = 'https://data.gov.sg/api/action/datastore_search?resource_id=$resourceID';
    if (limit != null) query += "&limit=${limit.toString()}";
    if (offset != null) query += "&offset=${offset.toString()}";

    // Query data
    http.Response response = await http.get(Uri.parse(query));
    return json.decode(response.body)['result'];
  }

  Future<Map> _gridToLatLong(String x, String y) async{
    String query = 'https://developers.onemap.sg/commonapi/convert/3414to4326?X=$x&Y=$y';
    http.Response response = await http.get(Uri.parse(query));
    return json.decode(response.body);
  }

  Future<Object?> _getDocument(CollectionReference collection, String id) async => await collection.doc(id).get().then((snapshot) => snapshot.data());

  Future<Carpark> getCarpark(String carparkNo) async => await _getDocument(carparkInfoCollection, carparkNo) as Carpark;


 Future<List<Carpark>> getAllCarparks() async{
    List<QueryDocumentSnapshot> carparkDocs = await carparkInfoCollection.get().then((snapshot) => snapshot.docs);
    List<Carpark> carparks = [];
    for (int i=0; i<carparkDocs.length; i++) carparks.add(carparkDocs[i].data() as Carpark);
    return carparks;
  }
  
  Future<List<Carpark>> getNearbyCarparks([double? latitude, double? longitude, double? radius]) async{
    if ((latitude == null) || (longitude == null)){
      latitude = 1.307778;
      longitude=103.930278;
    }
    if (radius == null) radius = 1.0;
    GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);
    CollectionReference collection = FirebaseFirestore.instance.collection(carparkConst.collectionName);
    Stream stream = geo
        .collection(collectionRef: collection)
        .within(center: center, radius: radius, field: "location");
    await for (List<DocumentSnapshot> snapshots in stream){
      List<Carpark> carparks = [];
      Carpark carpark;
      for (DocumentSnapshot snapshot in snapshots){
        carpark = Carpark.fromJson(snapshot.id, snapshot.data() as Map);
        carparks.add(carpark);
      }
      return carparks;
    }
    return [];
  }


  Future<void> updateCarparkInfo() async{
    // Get number of rows
    Map result = await _ckanQuery(limit: 3000);
    // get data
    List data = result["records"];

    // Update database
    Map latLong;
    GeoFirePoint location;
    Map dataRow;
    for (var i=0; i<data.length; i++){
      dataRow = data[i];

      // Format data
      Map latLong = await _gridToLatLong(dataRow[carparkInfoConst.xCoord], dataRow[carparkInfoConst.yCoord]);
      location = geo.point(latitude: latLong["latitude"], longitude: latLong["longitude"]);
      dataRow[carparkConst.location] = location;
      CarparkDataHandler carpark = CarparkDataHandler.fromJson(dataRow);

      // if document exists in collection, update document
      // else, add document
      await carparkInfoCollection.doc(carpark.id).set(carpark);

      print("updated carpark ${(i+1).toString()}");
    }

    print("update completed");
  }

  Future<UserAccount> getUser(String uid) async{
    // Get user information
    Map userMapData = await _getDocument(userCollection, uid) as Map;

    DocumentReference userDocRef = userCollection.doc(uid);

    // Get bookings
    QuerySnapshot querySnapshot = await userDocRef
        .collection(bookingConst.collectionName)
        .orderBy(bookingConst.startTime, descending: true)
        .get();
    List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;

    List<Booking> bookingHistory = [];
    for (int i=0; i<documentSnapshots.length; i++){
      QueryDocumentSnapshot documentSnapshot = documentSnapshots[i];
      Booking booking = await _getBooking(documentSnapshot.id, documentSnapshot.data() as Map);
      bookingHistory.add(booking);
    }
    userMapData[userConst.bookings] = bookingHistory;

    // Get favourites
    List favouriteRefs = userMapData[userConst.favourites];
    // Convert document references to carpark objects
    List<Carpark> favourites = [for (int i=0; i<favouriteRefs.length; i++) await getCarpark(favouriteRefs[i].id)];
    userMapData[userConst.favourites] = favourites;

    return UserAccount.fromJson(uid, userMapData);
  }

  Future<void> addUser(UserAccount user) async => await userCollection.doc(user.id).set(user.toJson());

  Future<void> _updateUserFields(String userEmail, Map data) async => userCollection.doc(userEmail).update(data as Map<String, Object?>);

  Future<void> updateUserInfo(UserAccount user) async => _updateUserFields(user.id, user.userInfoToJson());

  Future<void> updateFavourites(UserAccount user) async => _updateUserFields(user.id, user.favouritesToJson());

  // this function updates everything except bookings
  Future<void> updateUser(UserAccount user) async => await userCollection.doc(user.id).update(user.toJson());

  Future<void> removeUser(String email) async => await userCollection.doc(email).delete();

  Future<Booking> _getBooking(String id, Map json) async{
    Carpark carpark = await getCarpark(json[bookingConst.carparkRef].id);
    json[bookingConst.carparkObj] = carpark;
    return Booking.fromJson(id, json);
  }

  Future<void> addBooking(String userEmail, Booking booking) async => await userCollection
      .doc(userEmail)
      .collection(bookingConst.collectionName)
      .add(booking.toJson());

  Future<void> addAllBooking(String userEmail, List<Booking> bookings) async {
    for (int i=0; i<bookings.length; i++) addBooking(userEmail, bookings[i]);
  }

  Future<void> updateBooking(String userEmail, Booking booking) async => await userCollection
      .doc(userEmail)
      .collection(bookingConst.collectionName)
      .doc(booking.id)
      .update(booking.toJson());

  Future<void> updateAllBooking(String userEmail, List<Booking> bookings) async{
    for(int i=0; i<bookings.length; i++) updateBooking(userEmail, bookings[i]);
  }

  Future<void> removeBooking(String userEmail, String bookingID) async => await userCollection
      .doc(userEmail)
      .collection(bookingConst.collectionName)
      .doc(bookingID)
      .delete();

  Future<void> removeAllBooking(String userEmail, List<String> bookingIDs) async{
    for (int i=0; i<bookingIDs.length; i++) removeBooking(userEmail, bookingIDs[i]);
  }
}