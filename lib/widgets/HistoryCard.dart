import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';

class HistoryCard extends StatefulWidget {
  final String carparkName;
  String bookingTimeStart;
  String bookingTimeEnd;
  String date;

  HistoryCard({
    required this.carparkName,
    required this.date,
    required this.bookingTimeStart,
    required this.bookingTimeEnd,
  });

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
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
              '${widget.date}',
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
              '${widget.bookingTimeStart} - ${widget.bookingTimeEnd}',
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
        ],
      ),
    );
  }
}
