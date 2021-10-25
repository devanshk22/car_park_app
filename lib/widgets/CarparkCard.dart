import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:car_park_app/entities/carpark.dart';
import 'package:car_park_app/models/userAccount.dart';
import 'package:car_park_app/pages/InfoUI.dart';
import 'package:car_park_app/utilities/favouritesMgr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';

class CarparkCard extends StatefulWidget {
  final Carpark carpark;
  double lat;
  double lng;
  bool isFavourite;

  CarparkCard({
    required this.carpark,
    required this.lat,
    required this.lng,
    required this.isFavourite,
  });

  @override
  _CarparkCardState createState() => _CarparkCardState();
}

class _CarparkCardState extends State<CarparkCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenWidth(context) - 2 * screenGap,
      height: 90,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfoUI(carpark: widget.carpark)),
                );
              },
              child: Container(
                width: getScreenWidth(context) - 2 * screenGap,
                height: 90,
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
          ),
          Positioned(
            top: 15,
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
            top: 37,
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
            bottom: 15,
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
              top: 15,
              right: 15,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (widget.isFavourite == true) {
                      removeCarparkFavourite(widget.carpark);
                      widget.isFavourite = !widget.isFavourite;
                    } else {
                      setCarparkFavourite(widget.carpark);
                      widget.isFavourite = !widget.isFavourite;
                    }
                  });
                },
                child: Icon(
                  widget.isFavourite == true
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.pink,
                ),
              )),
        ],
      ),
    );
  }
}
