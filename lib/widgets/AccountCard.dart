import 'package:car_park_app/constants/databaseConsts.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/shared/constants.dart';
import 'package:car_park_app/pages/InfoUI.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/RegistrationUI.dart';
import 'package:car_park_app/models/userAccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_park_app/pages/authenticate/register.dart';

import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:car_park_app/pages/InfoUI.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountCard extends StatefulWidget {
  var fullName;
  var email;
  var phoneNumber;
  AccountCard({required this.fullName, this.email, required this.phoneNumber});

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile'),
        actions: <Widget>[],
        elevation: 0.0,
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Full name',
                    hintText: 'Full Name',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 10.0),
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
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
