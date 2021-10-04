import 'package:car_park_app/entities/all.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/pages/BookingUI.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserAccount?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        title: 'Car Park App',
        initialRoute: '/wrapper',
        routes: {
          //'/': (context) => LoginUI(),
          '/wrapper': (context) => Wrapper(),
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
      ),
      catchError: (User, UserAccount) => null,
    );
  }
}
