import 'package:flutter/material.dart';

class ForgotPasswordUI extends StatefulWidget {
  const ForgotPasswordUI({Key? key}) : super(key: key);

  @override
  _ForgotPasswordUIState createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Forgot Password'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(),
    );
  }
}
