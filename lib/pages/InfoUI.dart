import 'package:car_park_app/entities/carpark.dart';
import 'package:car_park_app/utilities/favouritesMgr.dart';
import 'package:car_park_app/utilities/locationMgr.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';
import 'package:car_park_app/pages/services/auth.dart';
import 'package:car_park_app/widgets/InfoCard.dart';

class InfoUI extends StatefulWidget {
  Carpark carpark;

  InfoUI({required this.carpark});

  @override
  _InfoUIState createState() => _InfoUIState();
}

class _InfoUIState extends State<InfoUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Car Park Information'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: FutureBuilder(
          future: getPosition(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.fromLTRB(1.5 * screenGap, 2 * cardGap,
                          1.5 * screenGap, cardGap),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'About this Car Park',
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.lightBlue),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          screenGap, cardGap, screenGap, 60),
                      child: InfoCard(
                        carpark: widget.carpark,
                        lat: snapshot.data.latitude,
                        lng: snapshot.data.longitude,
                      ),
                    ),
                  ),
                ],
              );
            else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
