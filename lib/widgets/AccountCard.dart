import 'package:car_park_app/pages/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/shared/constants.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'dart:ui';
import 'package:car_park_app/pages/RegistrationUI.dart';

class AccountCard extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNumber;

  AccountCard(
      {required this.fullName, required this.email, required this.phoneNumber});

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String fullName = " ";
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
                    labelText: 'Full Name',
                    hintText: fullName,
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
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Phone Number',
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Change password',
                    labelText: 'Change password',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Logout',
                    labelText: 'Logout',
                    labelStyle: TextStyle(color: Colors.pink, fontSize: 10.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 12.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
