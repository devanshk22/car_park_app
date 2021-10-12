import 'dart:async';
import 'dart:convert';

import 'package:car_park_app/entities/all.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import '../control/DatabaseCtrl.dart';

class MapUI extends StatefulWidget {
  const MapUI({Key? key}) : super(key: key);
  @override
  _MapUIState createState() => _MapUIState();
}

class _MapUIState extends State<MapUI> {
  late LatLng userPosition;

  List<Marker> markers = [];

  Location _location = Location();
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(1.3521, 103.8198),
      zoom: 15
  );

  GoogleMapController? _googleMapController;

  //checks the user's current location
  void _onMapCreated(GoogleMapController _controller)
  {
    _googleMapController = _controller;
    _location.onLocationChanged.listen((l){
      _googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
      ),
      );
    });
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }


  Future findPlaces() async{
    //query database
    await Firebase.initializeApp();
    DatabaseCtrl ctrl = DatabaseCtrl();
    List<Carpark> carparklist = await ctrl.getAllCarparks();
    showMarkers(carparklist);
  }

   showMarkers(carparklist) {
    for (int i = 0; i < carparklist.length; i++)
      markers.add(Marker(
        markerId: MarkerId(carparklist[i].address),
        position: LatLng(carparklist[i].location!.latitude,
            carparklist[i].location!.longitude),
        infoWindow:
          InfoWindow(title: "address", snippet: "address")));
    setState((){
      markers = markers;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Map'),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
          actions: [
            IconButton(
              icon: Icon(Icons.map),
              onPressed: () => findPlaces(),
            )
          ]
        ),

        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: _onMapCreated,
              myLocationButtonEnabled: true,
              markers: Set<Marker>.of(markers),
            );
          },
        ),


        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          onPressed: () => _googleMapController!.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition),
          ),
          child: const Icon(Icons.center_focus_strong),
        )
      );
    }
}





