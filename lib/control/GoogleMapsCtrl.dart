import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _centerOfSG = CameraPosition(
    target: LatLong(1.307778, 103.930278),
    zoom: 11.5
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(

      )
    );
  }
}
