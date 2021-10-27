import 'package:car_park_app/pages/FavouritesUI.dart';
import 'package:car_park_app/utilities/favouritesMgr.dart';
import 'package:car_park_app/utilities/locationMgr.dart';
import 'package:car_park_app/widgets/HomeNavCard.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/widgets/CarparkCard.dart';

import 'MapUI.dart';

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
        future: Future.wait([getNearbyCarpark(), getPosition()]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(
                  //       screenGap, 2 * cardGap, screenGap, 0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Expanded(
                  //         flex: 10,
                  //         child: HomeNavCard(
                  //             icon: Icon(
                  //               Icons.map,
                  //               color: Colors.orange[700],
                  //             ),
                  //             text: 'Open Map',
                  //             page: MapUI()),
                  //       ),
                  //       Spacer(
                  //         flex: 1,
                  //       ),
                  //       Expanded(
                  //         flex: 10,
                  //         child: HomeNavCard(
                  //             icon: Icon(
                  //               Icons.favorite_border,
                  //               color: Colors.orange[700],
                  //             ),
                  //             text: 'My Favourites',
                  //             page: FavouritesUI()),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(
                        1.5 * screenGap, 2 * cardGap, 1.5 * screenGap, cardGap),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Nearby Car Parks',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton.icon(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Refresh',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.lightBlue),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data[0].length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: checkFavourite(snapshot.data[0][index]),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.done)
                              return Container(
                                padding: EdgeInsets.fromLTRB(
                                    screenGap, cardGap, screenGap, cardGap),
                                child: CarparkCard(
                                  carpark: snapshot.data[0][index],
                                  lat: snapshot.data[1].latitude,
                                  lng: snapshot.data[1].longitude,
                                  isFavourite: snapshot2.data,
                                ),
                              );
                            else
                              return SizedBox.shrink();
                          },
                        );
                      }),
                ],
              ),
            );
          else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
