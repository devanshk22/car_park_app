import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/all.dart';

class DatabaseCtrl{
  static const String _carparkInfoID = "139a3035-e624-4f56-b63f-89ae28d4ae4c";

  final CollectionReference carparkInfoCollection = FirebaseFirestore.instance
      .collection('hdb-carpark-information')
      .withConverter(
        fromFirestore: (snapshot, _) => Carpark.fromJson(snapshot.id, snapshot.data() as Map),
        toFirestore: (object, _) => (object as CarparkDataHandler).toJson()
      );

  DatabaseCtrl();

  Future<Object?> _getDocument(CollectionReference collection, String id) async => await collection.doc(id).get().then((snapshot) => snapshot.data());

  Future<Carpark> getCarpark(String carparkNo) async => await _getDocument(carparkInfoCollection, carparkNo) as Carpark;

  Future<Map> _ckanQuery({String resourceID = _carparkInfoID, int? limit, int? offset}) async{
    // form CKAN query URL
    String query = 'https://data.gov.sg/api/action/datastore_search?resource_id=$resourceID';
    if (limit != null) query += "&limit=${limit.toString()}";
    if (offset != null) query += "&offset=${offset.toString()}";

    // Query data
    http.Response response = await http.get(Uri.parse(query));
    return json.decode(response.body)['result'];
  }

  Future<void> updateCarparkInfo() async{
    // Get number of rows
    Map result = await _ckanQuery();
    List totalNo = result["total"];

    // get data
    result = await _ckanQuery();
    List data = result["records"];

    // Update database
    for (var i=0; i<data.length; i++){
      // Format data
      CarparkDataHandler carpark = CarparkDataHandler.fromJson(data[i]);

      // if document exists in collection, update document
      // else, add document
      await carparkInfoCollection.doc(carpark.id).set(carpark);
    }
  }
}