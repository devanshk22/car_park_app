import 'package:flutter/material.dart';
import 'package:car_park_app/constants/databaseConsts.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/shared/constants.dart';
import 'package:car_park_app/pages/InfoUI.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/RegistrationUI.dart';
import 'package:car_park_app/models/userAccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_park_app/pages/authenticate/register.dart';

import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAccountUI extends StatefulWidget {
  const MyAccountUI({Key? key}) : super(key: key);

  @override
  _MyAccountUIState createState() => _MyAccountUIState();
}

class _MyAccountUIState extends State<MyAccountUI> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: new AppBar(
        title: new Text('My Account'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              new Text(
                "Profile",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  labelText: 'Full name',
                  hintText: 'Full Name',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                  suffixIcon: Icon(
                    Icons.border_color,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              new Text(
                "Details",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                  suffixIcon: Icon(
                    Icons.border_color,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Phone Number',
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                  suffixIcon: Icon(
                    Icons.border_color,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              new Text(
                "Settings",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 10),
                  backgroundColor: Colors.grey[850],
                ),
                onPressed: changePassword,
                child: const Text('Change Password',
                    style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 10),
                  backgroundColor: Colors.grey[850],
                ),
                onPressed: logout,
                child:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void iconButtonPressed() {}

  void changePassword() {}

  void logout() {}
}
