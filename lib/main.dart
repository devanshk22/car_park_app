import 'package:car_park_app/entities/all.dart';
import 'package:car_park_app/pages/change_password.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/pages/SearchResultUI.dart';
import 'package:car_park_app/pages/myBottomNavigationBar.dart';
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
          '/bottomnavbar': (context) => myBottomNavigationBar(),
          '/nearby': (context) => myBottomNavigationBar(),
          '/info': (context) => myBottomNavigationBar(),
          '/history': (context) => myBottomNavigationBar(),
          '/favourites': (context) => myBottomNavigationBar(),
          '/myaccount': (context) => myBottomNavigationBar(),
          '/map': (context) => myBottomNavigationBar(),
          '/searchresult': (context) => SearchResultUI(),
          '/wrapper': (context) => Wrapper(),
          '/changepassword': (context) => ChangePassword(),
        },
      ),
      catchError: (User, UserAccount) => null,
    );
  }
}
