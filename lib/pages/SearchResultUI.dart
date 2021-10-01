import 'package:flutter/material.dart';

class SearchResultUI extends StatefulWidget {
  const SearchResultUI({Key? key}) : super(key: key);

  @override
  _SearchResultUIState createState() => _SearchResultUIState();
}

class _SearchResultUIState extends State<SearchResultUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Search Result'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(),
    );
  }
}
