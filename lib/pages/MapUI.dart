import 'dart:async';

import 'package:car_park_app/entities/all.dart';
import 'package:geolocator/geolocator.dart';
import 'package:car_park_app/pages/CarparkInformationScreenUI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../control/DatabaseCtrl.dart';


class MapUI extends StatefulWidget {
  const MapUI({Key? key}) : super(key: key);
  @override
  _MapUIState createState() => _MapUIState();
}

class _MapUIState extends State<MapUI> {
  List<Marker> markers = [];

  Location _location = new Location();

  static const _initialCameraPosition =
    CameraPosition(target: LatLng(1.3521, 103.8198), zoom: 15);

  GoogleMapController? _googleMapController;

  //checks the user's current location
  void _onMapCreated(GoogleMapController _controller) {
    _googleMapController = _controller;
    _location.onLocationChanged.listen((l) {
      _googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
    findPlaces();
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Map'),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
        ),

        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: _onMapCreated,
              myLocationButtonEnabled: false,
              markers: Set<Marker>.of(markers),
            );
          },
        ),
    );
  }

  Future findPlaces() async {
    //query database
    await Firebase.initializeApp();
    DatabaseCtrl ctrl = DatabaseCtrl();
    List<Carpark> carparklist = await ctrl.getAllCarparks();
    showMarkers(carparklist);
  }

  showMarkers(carparklist) async {
    Position _currentLocation = await Geolocator.getCurrentPosition();

    for (int i = 0; i < carparklist.length; i++) {
      double _distanceBetween = (Geolocator.distanceBetween(_currentLocation.latitude, _currentLocation.longitude, carparklist[i].location.latitude, carparklist[i].location.longitude)) / 1000;

          markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(carparklist[i].location!.latitude,
              carparklist[i].location!.longitude),
          infoWindow:
          InfoWindow(title: carparklist[i].address,
            ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                new CarparkInformationScreenUI(onecarpark: carparklist[i], distanceBetween: _distanceBetween),
              ),
            );
          }));
      setState(() {
        markers = markers;
      });

    }
  }
}





