import 'package:car_park_app/entities/all.dart';
import 'package:car_park_app/pages/myBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';

class InfoCard extends StatefulWidget {
  final Carpark carpark;
  double lat;
  double lng;

  InfoCard({
    required this.carpark,
    required this.lat,
    required this.lng,
  });

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenWidth(context) - 2 * screenGap,
      height: getScreenHeight(context),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: getScreenWidth(context) - 2 * screenGap,
              height: 0.7 * getScreenHeight(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color.fromRGBO(48, 48, 48, 1),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 15,
            child: Text(
              '${(widget.carpark).address}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
          Positioned(
            top: 52,
            left: 15,
            child: Text(
              '${widget.carpark.location!.distance(lat: widget.lat, lng: widget.lng)} km away',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.amber,
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
          Positioned(
            top: 72,
            left: 15,
            child: Text(
              (widget.carpark).availableLots != 0
                  ? '${(widget.carpark).availableLots} Slots Available'
                  : 'No Slots Available',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
          Positioned(
            top: 107,
            left: 15,
            child: Text(
              widget.carpark.carparkNo == 'ACB' ||
                      widget.carpark.carparkNo == 'BBB' ||
                      widget.carpark.carparkNo == 'BRB1' ||
                      widget.carpark.carparkNo == 'CY' ||
                      widget.carpark.carparkNo == 'DUXM' ||
                      widget.carpark.carparkNo == 'HLM' ||
                      widget.carpark.carparkNo == 'KAB' ||
                      widget.carpark.carparkNo == 'KAM' ||
                      widget.carpark.carparkNo == 'KAS' ||
                      widget.carpark.carparkNo == 'PRM' ||
                      widget.carpark.carparkNo == 'SLS' ||
                      widget.carpark.carparkNo == 'SR1' ||
                      widget.carpark.carparkNo == 'SR2' ||
                      widget.carpark.carparkNo == 'TPM' ||
                      widget.carpark.carparkNo == 'UCS' ||
                      widget.carpark.carparkNo == 'WCB'
                  ? '''
\$1.20 per half-hour (7:00 - 17:00, Monday to Saturday)
\$0.60 per half-hour (Other hours)
                '''
                  : '0.60 per half-hour',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.orange[700],
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1.6),
            ),
          ),
          Positioned(
            top: 162,
            left: 15,
            child: Text(
              '''
Car Park Number: ${widget.carpark.carparkNo}
Car Park Type: ${widget.carpark.carparkType}
Parking System: ${widget.carpark.parkingSystem}
Short-term Parking: ${widget.carpark.shortTermParking}
Free Parking: ${widget.carpark.freeParking}
Night Parking: ${widget.carpark.nightParking}
Car Park Basement: ${widget.carpark.carparkBasement}
              ''',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1.6),
            ),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              width: getScreenWidth(context) - 2 * screenGap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: getScreenWidth(context) - 100,
                    height: 60,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myBottomNavigationBar()),
                        );
                      },
                      label: Text('View Map',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      icon: Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.pink),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
