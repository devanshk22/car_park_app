import 'package:car_park_app/utilities/favouritesMgr.dart';
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
                            'Nearby Favourites',
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
                                ConnectionState
                                    .done) if (snapshot2.data == true)
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
