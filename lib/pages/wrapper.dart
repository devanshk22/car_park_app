import 'package:car_park_app/entities/all.dart';
import 'package:car_park_app/pages/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_park_app/pages/myBottomNavigationBar.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAccount?>(context);

    // return either Map or Authenticate Widget.
    if (user == null) {
      return Authenticate();
    } else {
      return myBottomNavigationBar();
    }
  }
}
