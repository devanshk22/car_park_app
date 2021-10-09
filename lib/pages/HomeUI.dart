import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/widgets/HomeCard.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Log Out"))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        // TODO: generate list view with CarparkCtrl
        padding: EdgeInsets.fromLTRB(screenGap, cardGap, screenGap, cardGap),
        child: HomeCard(
          carparkName: 'BLK 232 BRAS BASAH BASEMENT CAR PARK',
          slotsAvailable: 1,
          kmAway: 0.4,
          isBooked: true,
          isFavourite: true,
        ),
      ),
    );
  }
}
