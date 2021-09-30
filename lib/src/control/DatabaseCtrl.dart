import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity.dart';

class DatabaseCtrl{
  static const String _carparkInfoID = "139a3035-e624-4f56-b63f-89ae28d4ae4c";

  final CollectionReference carparkInfoCollection = FirebaseFirestore.instance
      .collection('hdb-carpark-information')
      .withConverter(
        fromFirestore: (snapshot, _) => snapshot.data(),//Carpark.fromJson(snapshot.data() as Map),
        toFirestore: (object, _) => (object as CarparkDataHandler).toJson()
      );

  DatabaseCtrl();

  getCarpark(String carparkNo) async => await carparkInfoCollection.doc(carparkNo).get().then((snapshot) => snapshot.data());

  updateCarparkInfo() async{
    // Get number of rows
    String ckanQuery = _ckanQuery();
    http.Response response = await http.get(Uri.parse(ckanQuery));
    int totalNo = json.decode(response.body)['result']["total"];

    ckanQuery = _ckanQuery(limit: totalNo);
    response = await http.get(Uri.parse(ckanQuery));
    List data = json.decode(response.body)['result']["records"];

    // Update database
    for (var i=0; i<data.length; i++){
      // Format data
      CarparkDataHandler carpark = CarparkDataHandler.fromJson(data[i]);

      // if document exists in collection, update document
      // else, add document
      await carparkInfoCollection.doc(carpark.id).set(carpark);
    }
  }

  String _ckanQuery({String resourceID = _carparkInfoID, int? limit, int? offset}){
    String query = 'https://data.gov.sg/api/action/datastore_search?resource_id=$resourceID';
    if (limit != null) query += "&limit=${limit.toString()}";
    if (offset != null) query += "&offset=${offset.toString()}";
    return query;
  }
}