import 'package:car_park_app/entities/carpark.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/widgets/InfoCard.dart';

class InfoUI extends StatefulWidget {
  const InfoUI({Key? key}) : super(key: key);

  @override
  _InfoUIState createState() => _InfoUIState();
}

class _InfoUIState extends State<InfoUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Booking'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        // TODO: generate list view with CarparkCtrl
        padding: EdgeInsets.fromLTRB(screenGap, 45, screenGap, 45),
        child: InfoCard(
          carpark: Carpark(
              address: 'BLK 269/269A/269B CHENG YAN COURT CAR PARK',
              carparkNo: 'CY',
              carparkType: 'Electronic Carpark',
              parkingSystem: 'Electronic Parking',
              shortTermParking: '7:00 - 22:30',
              freeParking: 'NO',
              nightParking: 'YES',
              carparkBasement: 'NO'),
          slotsAvailable: 1,
          kmAway: 0.4,
        ),
      ),
    );
  }
}