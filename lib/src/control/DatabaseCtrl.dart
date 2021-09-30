import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity.dart';

class DatabaseCtrl{
  final String _carparkInfoUrl = 'https://data.gov.sg/api/action/datastore_search?resource_id=139a3035-e624-4f56-b63f-89ae28d4ae4c';

  final CollectionReference carparkInfoCollection = FirebaseFirestore.instance
      .collection('hdb-carpark-information')
      .withConverter(
        fromFirestore: (snapshot, _) => CarparkDataHandler.fromJson(snapshot.data() as Map),
        toFirestore: (object, _) => (object as CarparkDataHandler).toJson()
      );

  DatabaseCtrl();

  getCarpark(String carparkNo) => carparkInfoCollection.doc(carparkNo).get().then((carpark) => carpark);

  updateCarparkInfo() async{
    // Query data
    String ckanQuery = _carparkInfoUrl;
    http.Response response = await http.get(Uri.parse(ckanQuery));
    Map result = json.decode(response.body)['result'];

    // If dataset size exceeds the default query limit (100), query again
    int limit = result['total'];
    if (limit > 100){
      ckanQuery = '$_carparkInfoUrl&limit=$limit';
      http.Response response = await http.get(Uri.parse(ckanQuery));
      result = json.decode(response.body)['result'];
    }

    // Update database
    List data = result['records']; // Extract data from result
    for (var i=0; i<data.length; i++){
      // Format data
      CarparkDataHandler carpark = CarparkDataHandler.fromJson(data[i]);

      // if document exists in collection, update document
      // else, add document
      carparkInfoCollection.doc(carpark.id).set(carpark);
    }
  }
}