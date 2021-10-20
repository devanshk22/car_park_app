import 'package:car_park_app/control/CarparkCtrl.dart';
import 'package:car_park_app/entities/all.dart';
import 'package:car_park_app/widgets/CarparkCard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/services/auth.dart';

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
      body: FutureBuilder(
        future: getCarpark(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(
                        screenGap, cardGap, screenGap, cardGap),
                    child: CarparkCard(
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
  CarparkCtrl favouritesList = CarparkCtrl();
  var output = await favouritesList.getNearbyAvailableCarparks();
  return output;
}
