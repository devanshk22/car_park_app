import 'package:flutter/material.dart';

class BookingUI extends StatefulWidget {
  const BookingUI({Key? key}) : super(key: key);

  @override
  _BookingUIState createState() => _BookingUIState();
}

class _BookingUIState extends State<BookingUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Booking'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(),
    );
  }
}
