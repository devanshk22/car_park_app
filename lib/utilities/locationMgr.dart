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

Future<List<Carpark>> getNearbyCarparks10km() async {
  await Firebase.initializeApp();
  CarparkCtrl list = CarparkCtrl();
  Position pos = await getPosition();
  var output = await list.getNearbyAvailableCarparks(
      latitude: pos.latitude, longitude: pos.longitude, radius: 2);
  return output;
}

Future<List<Carpark>> getNearbyCarparks100km() async {
  await Firebase.initializeApp();
  CarparkCtrl list = CarparkCtrl();
  Position pos = await getPosition();
  var output = await list.getNearbyAvailableCarparks(
      latitude: pos.latitude, longitude: pos.longitude, radius: 3);
  return output;
}
