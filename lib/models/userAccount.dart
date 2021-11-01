import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/carpark.dart';
import '../constants/databaseConsts.dart';
import 'package:car_park_app/control/DatabaseCtrl.dart';

class UserAccount {
  late String uid;
  late String fullName = "";
  late String email = "";
  late String phone = "";
  late String password = "";
  late List<Carpark> favourites = [];
  DatabaseCtrl databaseCtrl = new DatabaseCtrl();

  UserAccount(
      {required this.uid, String? email, String? fullName, String? phone}) {
    if (email != null) this.email = email;
    if (fullName != null) this.fullName = fullName;
    if (phone != null) this.phone = phone;
  }

  UserAccount.fromJson(String uid, Map json) {
    this.uid = uid;
    email = json[userConst.email] as String;
    fullName = json[userConst.fullName] as String;
    phone = json[userConst.phone] as String;
    favourites = json[userConst.favourites] as List<Carpark>;
  }

  Map<String, Object?> userInfoToJson() => {
        userConst.email: email,
        userConst.fullName: fullName,
        userConst.phone: phone
      };

  Map<String, Object?> favouritesToJson() {
    // Convert favourites from list of carparks to list of document references
    List<DocumentReference> favouriteRefs = [
      for (int i = 0; i < favourites.length; i++)
        FirebaseFirestore.instance
            .collection(carparkConst.collectionName)
            .doc(favourites[i].id)
    ];
    return {userConst.favourites: favouriteRefs};
  }

  Map<String, Object?> toJson() {
    Map<String, Object?> json = userInfoToJson();
    json.addAll(favouritesToJson());
    return json;
  }

  String userInfoToString() => [
        "User $uid",
        "-" * (5 + uid.length),
        "Email: $email",
        "Full Name: $fullName",
        "Phone Number: $phone"
      ].join("\n");

  String favouritesToString() => [
        "FAVOURITES",
        "----------",
        for (int i = 0; i < favourites.length; i++) favourites[i].toString()
      ].join("\n");

  String toString() => [userInfoToString(), favouritesToString()].join("\n");

  String get id => uid;

  String getEmail() {
    return this.email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getFullName() {
    return this.fullName;
  }

  void setFullName(String fullName) {
    this.fullName = fullName;
  }

  String getPhone() {
    return this.phone;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }

  List<Carpark> getUserFavourites() {
    return this.favourites;
  }

  void setFavourite(String carpark_num) async {
    DatabaseCtrl db = this.databaseCtrl;
    Carpark toAdd = await db.getCarpark(carpark_num);
    this.favourites.add(toAdd);
    db.updateFavourites(this);
  }

  void removeFavourite(String carpark_num) async {
    DatabaseCtrl db = this.databaseCtrl;
    try {
      for (var i = 0; i < favourites.length; i++)
        if (favourites[i].carparkNo == carpark_num) favourites.removeAt(i);
      db.removeFavourites(this);
    } catch (e) {
      print(e);
    }
  }
}
