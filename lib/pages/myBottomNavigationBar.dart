import 'package:car_park_app/entities/all.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/pages/InfoUI.dart';
import 'package:car_park_app/pages/FavouritesUI.dart';
import 'package:car_park_app/pages/ForgotPasswordUI.dart';
import 'package:car_park_app/pages/HistoryUI.dart';
import 'package:car_park_app/pages/HomeUI.dart';
import 'package:car_park_app/pages/authenticate/LoginUI.dart';
import 'package:car_park_app/pages/MapUI.dart';
import 'package:car_park_app/pages/MyAccountUI.dart';
import 'package:car_park_app/pages/RegistrationUI.dart';
import 'package:car_park_app/pages/SearchResultUI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class myBottomNavigationBar extends StatefulWidget {
  @override
  _myBottomNavigationBarState createState() => _myBottomNavigationBarState();
}

class _myBottomNavigationBarState extends State<myBottomNavigationBar> {
  int _selectedIndex = 0;
  final List<Widget> children = [
    HomeUI(),
    MapUI(),
    SearchResultUI(),
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
        backgroundColor: Colors.grey[850],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
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
