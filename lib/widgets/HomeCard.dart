import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';

class HomeCard extends StatefulWidget {
  final String carparkName;
  int slotsAvailable;
  double kmAway;
  bool isBooked;
  bool isFavourite;

  HomeCard(
      {required this.carparkName,
      required this.kmAway,
      required this.slotsAvailable,
      required this.isBooked,
      required this.isFavourite});

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenWidth(context) - 2 * screenGap,
      height: 90,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: getScreenWidth(context) - 2 * screenGap,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color.fromRGBO(48, 48, 48, 1),
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: Text(
              '${widget.carparkName}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
          Positioned(
            top: 37,
            left: 15,
            child: Text(
              '${widget.kmAway} km away',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.amber,
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Text(
              widget.isBooked == true
                  ? 'Booked'
                  : widget.slotsAvailable > 0
                      ? '${widget.slotsAvailable} Slots Available'
                      : 'No Slots Available',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Icon(
              widget.isFavourite == true
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }
}
