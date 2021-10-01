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
      initialRoute: '/',
      routes: {
        '/': (context) => LoginUI(),
        '/booking': (context) => BookingUI(),
        '/favourites': (context) => FavouritesUI(),
        '/forgotpassword': (context) => ForgotPasswordUI(),
        '/history': (context) => HistoryUI(),
        '/home': (context) => HomeUI(),
        '/map': (context) => MapUI(),
        '/myaccount': (context) => MyAccountUI(),
        '/registration': (context) => RegistrationUI(),
        '/searchresult': (context) => SearchResultUI(),
      },
    );
  }
}
