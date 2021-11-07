import 'package:flutter/material.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/shared/constants.dart';
import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_park_app/models/userAccount.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String oldPassword = " ";
  String newPassword = " ";
  String confirmNewPassword = " ";
  String error = " ";
  bool passwordValidated = false;
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Change Password'),
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
                    hintText: 'Old Password',
                    labelText: 'Old Password',
                    labelStyle: TextStyle(color: Colors.pink, fontSize: 16.0),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.pink,
                    ),
                  ),
                  validator: (val) =>
                      passwordValidated ? "Incorrect Password" : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() async {
                      oldPassword = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'New Password',
                    labelText: 'New Password',
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
                    setState(() => newPassword = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Confirm New Password',
                    labelText: 'Confirm New Password',
                    labelStyle: TextStyle(color: Colors.pink, fontSize: 16.0),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.pink,
                    ),
                  ),
                  validator: (val) => val != newPassword
                      ? "New password does not match with confirmed password"
                      : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() => confirmNewPassword = value);
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
                    "Confirm New Password",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    bool validated = await validatePassword(oldPassword);
                    setState(() async {
                      passwordValidated = validated;
                    });

                    if (_formKey.currentState!.validate()) {
                      if (!passwordValidated) {
                        setState(() => error = 'Incorrect Password');
                      }
                      if (newPassword != confirmNewPassword) {
                        setState(() => error = 'Passwords do not match');
                      }
                      if (passwordValidated &&
                          newPassword == confirmNewPassword) {
                        print("Changing password");
                        user!.updatePassword(newPassword);
                        setState(
                            () => error = 'Password successfully changed!');
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
                    color: error == 'Password successfully changed!'
                        ? Colors.green
                        : Colors.red,
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

  Future<bool> validatePassword(String password) async {
    var firebaseUser = auth.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser!.email!, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
