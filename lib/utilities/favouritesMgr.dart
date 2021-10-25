import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:car_park_app/entities/all.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<bool> checkFavourite(Carpark carpark) async {
  String uid = auth.currentUser!.uid;
  DatabaseCtrl db = DatabaseCtrl();
  UserAccount userAccount = await db.getUser(uid);
  for (var e in userAccount.getUserFavourites()) {
    if (e.carparkNo == carpark.carparkNo) return true;
  }
  return false;
}

void setCarparkFavourite(Carpark carpark) async {
  String uid = auth.currentUser!.uid;
  DatabaseCtrl db = DatabaseCtrl();
  UserAccount userAccount = await db.getUser(uid);
  userAccount.setFavourite(carpark.carparkNo);
}

void removeCarparkFavourite(Carpark carpark) async {
  String uid = auth.currentUser!.uid;
  DatabaseCtrl db = DatabaseCtrl();
  UserAccount userAccount = await db.getUser(uid);
  userAccount.removeFavourite(carpark.carparkNo);
}
