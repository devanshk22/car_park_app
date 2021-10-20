import 'package:car_park_app/entities/carpark.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/widgets/InfoCard.dart';

class InfoUI extends StatefulWidget {
  Carpark carpark;

  InfoUI({required this.carpark});

  @override
  _InfoUIState createState() => _InfoUIState();
}

class _InfoUIState extends State<InfoUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Car Park Information'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        // TODO: generate list view with CarparkCtrl
        padding: EdgeInsets.fromLTRB(screenGap, 60, screenGap, 60),
        child: InfoCard(
          carpark: widget.carpark,
          kmAway: 0.4,
        ),
      ),
    );
  }
}
