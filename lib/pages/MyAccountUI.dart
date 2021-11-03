import 'package:car_park_app/pages/MyAccountData.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:provider/provider.dart';

class MyAccountUI extends StatefulWidget {
  const MyAccountUI({Key? key}) : super(key: key);

  @override
  _MyAccountUIState createState() => _MyAccountUIState();
}

class _MyAccountUIState extends State<MyAccountUI> {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserAccount?>(context);
    // final name = user!.fullName;
    // final email = user.email;
    // final phonenum = user.phone;
    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: DatabaseCtrl().userData,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: new AppBar(
          title: new Text('My Account'),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
        ),
        body: MyAccountData(),
      ),
    );
  }

  void iconButtonPressed() {}

  void changePassword() {}
}
