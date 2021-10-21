import 'package:car_park_app/utilities/locationMgr.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/widgets/CarparkCard.dart';

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
        title: Text('Search'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: FutureBuilder(
        future: Future.wait([getNearbyCarpark(), getPosition()]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
                itemCount: snapshot.data[0].length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(
                        screenGap, cardGap, screenGap, cardGap),
                    child: CarparkCard(
                      carpark: snapshot.data[0][index],
                      lat: snapshot.data[1].latitude,
                      lng: snapshot.data[1].longitude,
                      isFavourite: true,
                    ),
                  );
                });
          else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
