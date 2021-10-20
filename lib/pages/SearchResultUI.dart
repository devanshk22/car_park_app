import 'package:car_park_app/control/CarparkCtrl.dart';
import 'package:car_park_app/entities/all.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/widgets/HomeCard.dart';

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
      body: FutureBuilder(
        future: getCarpark(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    // TODO: generate list view with CarparkCtrl
                    padding: EdgeInsets.fromLTRB(
                        screenGap, cardGap, screenGap, cardGap),
                    child: HomeCard(
                      carpark: snapshot.data[index],
                      kmAway: 0.4,
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

Future<List<Carpark>> getCarpark() async {
  await Firebase.initializeApp();
  CarparkCtrl homeList = CarparkCtrl();
  var output = await homeList.getNearbyAvailableCarparks();
  return output;
}
