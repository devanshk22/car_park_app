import 'package:car_park_app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/widgets/HomeCard.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.fromLTRB(screenGap, screenGap, screenGap, cardGap),
              child: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Center(
              // TODO: cycle through all carpark to generate carpark list
              child: HomeCard(
                carparkName: 'BLK 232 BRAS BASAH BASEMENT CAR PARK',
                slotsAvailable: 1,
                kmAway: 0.4,
                isBooked: true,
                isFavourite: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
