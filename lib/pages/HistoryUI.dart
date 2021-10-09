import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/widgets/HistoryCard.dart';

class HistoryUI extends StatefulWidget {
  const HistoryUI({Key? key}) : super(key: key);

  @override
  _HistoryUIState createState() => _HistoryUIState();
}

class _HistoryUIState extends State<HistoryUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        // TODO: generate list view with CarparkCtrl
        padding: EdgeInsets.fromLTRB(screenGap, cardGap, screenGap, cardGap),
        child: HistoryCard(
          carparkName: 'BLK 269/269A/269B CHENG YAN COURT CAR PARK',
          date: 'Yesterday',
          bookingTimeStart: '09:00',
          bookingTimeEnd: '11:00',
        ),
      ),
    );
  }
}
