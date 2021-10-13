import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:car_park_app/entities/all.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';


void main() => runApp(MaterialApp(
    home: TextButton(
      child: Text("Test function"),
      onPressed: () => test(),
    )
)
);

test () async {
  await Firebase.initializeApp();
  CarparkCtrl test = CarparkCtrl();
  var output = await test.getNearbyAvailableCarparks();
  for (var e in output){
    print(e);
    print(e.availableLots);
  }
}


class CarparkCtrl{

  late DatabaseCtrl databaseCtrl;

  CarparkCtrl(){
    databaseCtrl = DatabaseCtrl();
  }

  _getAvailableCarparkInfo([DateTime? dateTime]) async{
    String query = "https://api.data.gov.sg/v1/transport/carpark-availability";
    if (dateTime != null) query += "?date_time=${DateFormat("yyyy-MM-ddTHH%3Amm%3Ass").format(dateTime)}";
    http.Response response = await http.get(Uri.parse(query));
    List carparks = json.decode(response.body)["items"][0]["carpark_data"];
    Map<String, int> carparkInfo = {};
    String carparkNo;
    int availableLots;
    for (Map carpark in carparks){
      carparkNo = carpark["carpark_number"];
      availableLots = int.parse(carpark["carpark_info"][0]["lots_available"]);
      carparkInfo[carparkNo] = availableLots;
    }
    return carparkInfo;
  }

  Future<List<Carpark>> getNearbyAvailableCarparks({double? latitude, double? longitude, double? radius, DateTime? dateTime}) async{
    // Get nearby carparks
    List<Carpark> nearbyCarparks = await databaseCtrl.getNearbyCarparks(latitude, longitude, radius);

    // Get available carpark info
    Map<String, int> availableCarparkInfo = await _getAvailableCarparkInfo(dateTime);

    // Get carparks that are both nearby and available
    List<Carpark> nearbyAvailableCarparks = [];
    for (Carpark carpark in nearbyCarparks){
      if (availableCarparkInfo.containsKey(carpark.carparkNo)){
        carpark.availableLots = availableCarparkInfo[carpark.carparkNo];
        nearbyAvailableCarparks.add(carpark);
      }
    }

    return nearbyAvailableCarparks;
  }
}