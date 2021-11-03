import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:car_park_app/entities/all.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:car_park_app/models/userAccount.dart';

class MyAccountData extends StatefulWidget {
  const MyAccountData({Key? key}) : super(key: key);

  @override
  _MyAccountDataState createState() => _MyAccountDataState();
}

class _MyAccountDataState extends State<MyAccountData> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final Future<UserAccount> custom_user = DatabaseCtrl().getUser(uid!);

    final AuthService _auth = AuthService();

    return FutureBuilder(
      future: custom_user,
      builder: (BuildContext context, AsyncSnapshot<UserAccount> userAccount) {
        if (!userAccount.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          UserAccount? current_user = userAccount.data;
          return Container(
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
                      labelText: current_user!.fullName,
                      hintText: current_user.fullName,
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 16.0),
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
                      hintText: current_user.email,
                      labelText: current_user.email,
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 16.0),
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
                      hintText: current_user.phone,
                      labelText: current_user.phone,
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 16.0),
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
                    onPressed: () {},
                    child: const Text('Change Password',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 10),
                      backgroundColor: Colors.grey[850],
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: const Text('Logout',
                        style: TextStyle(color: Colors.red)),
                  ),
                ]),
              ),
            ),
          );
        }
      },
    );
  }
}
