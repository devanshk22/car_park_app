import 'package:flutter/material.dart';

class FavouritesUI extends StatefulWidget {
  const FavouritesUI({Key? key}) : super(key: key);

  @override
  _FavouritesUIState createState() => _FavouritesUIState();
}

class _FavouritesUIState extends State<FavouritesUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Favourites'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(),
    );
  }
}
