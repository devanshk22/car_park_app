import 'package:flutter/material.dart';
import 'package:car_park_app/shared/constants.dart';

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
