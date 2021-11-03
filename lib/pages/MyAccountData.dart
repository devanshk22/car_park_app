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
  bool nameEnabled = false;
  bool emailEnabled = false;
  bool phoneEnabled = false;
  bool nameSaveEnabled = false;
  bool emailSaveEnabled = false;
  bool phoneSaveEnabled = false;
  late String nameText;
  late String emailText;
  late String phoneText;
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            nameText = text;
                          },
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          decoration: textInputDecoration.copyWith(
                            enabled: nameEnabled,
                            hintText: current_user!.fullName,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: Icon(Icons.border_color),
                        onPressed: () {
                          setState(() {
                            nameEnabled = !nameEnabled;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            if (nameEnabled) {
                              current_user.setFullName(nameText);
                              DatabaseCtrl().updateUserInfo(current_user);
                              nameEnabled = !nameEnabled;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            emailText = text;
                          },
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          decoration: textInputDecoration.copyWith(
                            enabled: emailEnabled,
                            hintText: current_user.email,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: Icon(Icons.border_color),
                        onPressed: () {
                          setState(() {
                            emailEnabled = !emailEnabled;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            if (emailEnabled) {
                              current_user.setEmail(emailText);
                              DatabaseCtrl().updateUserInfo(current_user);
                              emailEnabled = !emailEnabled;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Phone",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            phoneText = text;
                          },
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          decoration: textInputDecoration.copyWith(
                            enabled: phoneEnabled,
                            hintText: current_user.phone,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: Icon(Icons.border_color),
                        onPressed: () {
                          setState(() {
                            phoneEnabled = !phoneEnabled;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            if (phoneEnabled) {
                              current_user.setPhone(phoneText);
                              DatabaseCtrl().updateUserInfo(current_user);
                              phoneEnabled = !phoneEnabled;
                            }
                          });
                        },
                      ),
                    ],
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
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Colors.grey[850],
                    ),
                    onPressed: () {},
                    child: const Text('Change Password',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
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
