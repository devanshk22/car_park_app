import 'package:car_park_app/control/CarparkCtrl.dart';
import 'package:car_park_app/entities/carpark.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/widgets/HomeCard.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Log Out"))
        ],
        automaticallyImplyLeading: false,
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
                      isBooked: true,
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
