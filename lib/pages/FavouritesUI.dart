import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/widgets/FavouritesCard.dart';

class FavouritesUI extends StatefulWidget {
  const FavouritesUI({Key? key}) : super(key: key);

  @override
  _FavouritesUIState createState() => _FavouritesUIState();
}

class _FavouritesUIState extends State<FavouritesUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Favourites'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        // TODO: generate favourites list view with UserAccountCtrl
        padding: EdgeInsets.fromLTRB(screenGap, cardGap, screenGap, cardGap),
        child: FavouritesCard(
          carparkName: 'BLK 269/269A/269B CHENG YAN COURT CAR PARK',
          slotsAvailable: 1,
          isBooked: true,
          isFavourite: true,
        ),
      ),
    );
  }
}
