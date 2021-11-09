import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = " ";
  String password = " ";
  String confirmPassword = " ";
  String phone = " ";
  String name = " ";
  String error = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Register'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Full Name',
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: Colors.pink, fontSize: 16.0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.pink,
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? "Please enter a name" : null,
                  onChanged: (value) {
                    setState(() => name = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Email',
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.pink, fontSize: 16.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.pink,
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? "Please enter an Email" : null,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Password',
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.pink, fontSize: 16.0),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.pink,
                    ),
                  ),
                  validator: (val) => val!.length < 6
                      ? "Please enter a password with 6 or more characters"
                      : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.pink, fontSize: 16.0),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.pink,
                    ),
                  ),
                  validator: (val) => val != password
                      ? "Confirm password does not match"
                      : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() => confirmPassword = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Phone Number',
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.pink, fontSize: 16.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.pink,
                    ),
                  ),
                  validator: (val) => val!.length != 8
                      ? "Please enter a phone number with 8 digits"
                      : null,
                  onChanged: (value) {
                    setState(() => phone = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.registerAccount(
                          email, password, phone, name);
                      if (result == null) {
                        setState(() => error = 'Please supply a valid email.');
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
