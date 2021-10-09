import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/widgets/HomeCard.dart';

class SearchResultUI extends StatefulWidget {
  const SearchResultUI({Key? key}) : super(key: key);

  @override
  _SearchResultUIState createState() => _SearchResultUIState();
}

class _SearchResultUIState extends State<SearchResultUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Search Result'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
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
