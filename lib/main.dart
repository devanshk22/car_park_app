import 'package:flutter/material.dart';
import 'package:car_park_app/pages/BookingUI.dart';
import 'package:car_park_app/pages/FavouritesUI.dart';
import 'package:car_park_app/pages/ForgotPasswordUI.dart';
import 'package:car_park_app/pages/HistoryUI.dart';
import 'package:car_park_app/pages/HomeUI.dart';
import 'package:car_park_app/pages/LoginUI.dart';
import 'package:car_park_app/pages/MapUI.dart';
import 'package:car_park_app/pages/MyAccountUI.dart';
import 'package:car_park_app/pages/RegistrationUI.dart';
import 'package:car_park_app/pages/SearchResultUI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Park App',
      home: myBottomNavigationBar(),
    );
  }
}

class myBottomNavigationBar extends StatefulWidget {
  @override
  _myBottomNavigationBarState createState() => _myBottomNavigationBarState();
}

class _myBottomNavigationBarState extends State<myBottomNavigationBar> {
  int _selectedIndex = 0;
  final List<Widget> children = [
    HomeUI(),
    BookingUI(),
    HistoryUI(),
    FavouritesUI(),
    MyAccountUI(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_filled),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_outlined),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
