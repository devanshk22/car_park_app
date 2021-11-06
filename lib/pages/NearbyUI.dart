import 'package:car_park_app/utilities/favouritesMgr.dart';
import 'package:car_park_app/utilities/locationMgr.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/widgets/CarparkCard.dart';
import 'package:permission_handler/permission_handler.dart';

class NearbyUI extends StatefulWidget {
  const NearbyUI({Key? key}) : super(key: key);

  @override
  _NearbyUIState createState() => _NearbyUIState();
}

class _NearbyUIState extends State<NearbyUI> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Nearby Car Parks"),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: FutureBuilder(
        future: Future.wait([getNearbyCarparks10km(), getPosition()]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Spacer(
                      flex: 2,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Please open app settings and allow location permission to use the app',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 180,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: getScreenWidth(context) - 100,
                        height: 60,
                        child: TextButton.icon(
                          onPressed: () async {
                            await openAppSettings();
                            setState(() {});
                          },
                          label: Text('Open Settings',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          icon: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.pink),
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done)
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
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
