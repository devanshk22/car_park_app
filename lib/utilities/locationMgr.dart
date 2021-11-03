import 'package:car_park_app/control/CarparkCtrl.dart';
import 'package:car_park_app/entities/carpark.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPosition() async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    await openAppSettings();
  }
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
}

Future<Position> getPosition() async {
  if (await Permission.location.status.isGranted)
    return await Geolocator.getCurrentPosition();
  else
    return Future.error('Cannot request Location');
}

Future<List<Carpark>> getNearbyCarpark() async {
  await Firebase.initializeApp();
  CarparkCtrl list = CarparkCtrl();
  Position pos = await getPosition();
  var output = await list.getNearbyAvailableCarparks(
      latitude: pos.latitude, longitude: pos.longitude, radius: 1);
  return output;
}
