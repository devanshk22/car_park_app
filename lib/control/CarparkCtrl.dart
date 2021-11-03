import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:car_park_app/entities/all.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
        home: TextButton(
      child: Text("Test function"),
      onPressed: () => test(),
    )));

test() async {
  await Firebase.initializeApp();
  CarparkCtrl test = CarparkCtrl();
  var output = await test.getNearbyAvailableCarparks();
  for (var e in output) {
    print(e);
    print(e.availableLots);
  }
}

class CarparkCtrl {
  late DatabaseCtrl _databaseCtrl;

  CarparkCtrl() {
    _databaseCtrl = DatabaseCtrl();
  }

  Future<List<Carpark>> getNearbyAvailableCarparks(
      {double? latitude,
      double? longitude,
      double? radius,
      DateTime? dateTime}) async {
    // Get nearby carparks
    List<Carpark> nearbyCarparks =
        await _databaseCtrl.getNearbyCarparks(latitude, longitude, radius);

    // Get available carpark info
    Map<String, int> availableCarparkInfo =
        await _databaseCtrl.getAvailableCarparkInfo(dateTime);

    // Get carparks that are both nearby and available
    List<Carpark> nearbyAvailableCarparks = [];
    for (Carpark carpark in nearbyCarparks) {
      if (availableCarparkInfo.containsKey(carpark.carparkNo)) {
        carpark.availableLots = availableCarparkInfo[carpark.carparkNo];
        nearbyAvailableCarparks.add(carpark);
      }
    }

    return nearbyAvailableCarparks;
  }
}
