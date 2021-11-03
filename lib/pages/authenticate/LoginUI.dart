import 'package:car_park_app/pages/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/shared/constants.dart';

class LoginUI extends StatefulWidget {
  final Function toggleView;
  LoginUI({required this.toggleView});
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  //text field state
  String email = " ";
  String password = " ";
  String error = " ";
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
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
          child: Column(
            children: <Widget>[
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
                obscureText: true,
                validator: (val) => val!.length < 6
                    ? "Please enter a password with 6 or more characters"
                    : null,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                ),
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _auth.signIn(email, password);
                    if (result == null) {
                      setState(() => error =
                          'Invalid Credentials. Please try signing in again.');
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
