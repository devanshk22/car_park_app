import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseCtrl{
  final String carparkInfoName = 'hdb-carpark-information';
  final String carparkInfoUrl = 'https://data.gov.sg/api/action/datastore_search?resource_id=139a3035-e624-4f56-b63f-89ae28d4ae4c';

  DatabaseCtrl();

  updateCarparkInfo() async{
    // Query data
    String ckanQuery = carparkInfoUrl;
    http.Response response = await http.get(Uri.parse(ckanQuery));
    Map result = json.decode(response.body)['result'];

    // If dataset size exceeds the default query limit (100), query again
    int limit = result['total'];
    if (limit > 100){
      ckanQuery = '$carparkInfoUrl&limit=$limit';
      http.Response response = await http.get(Uri.parse(ckanQuery));
      result = json.decode(response.body)['result'];
    }

    // Update database
    List data = result['records']; // Extract data from result
    CollectionReference carparkInfoCollection = FirebaseFirestore.instance.collection(carparkInfoName);
    for (var i=0; i<data.length; i++){
      // Format data
      Map carparkData = data[i];
      String carparkNo = carparkData.remove('car_park_no');
      carparkData.remove('_id'); // strip id field from data

      // if document exists in collection, update document
      // else, add document
      carparkInfoCollection.doc(carparkNo).set(carparkData);
    }
  }
}