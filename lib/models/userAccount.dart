import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/booking.dart';
import '../entities/carpark.dart';
import '../constants/databaseConsts.dart';

class UserAccount {
  final String uid;
  String? fullName;
  String? email;
  String? password;
  String? phone;
  List<Booking> bookings = [];
  List<Carpark> favourites = [];

  UserAccount({
    required this.uid,
    // required this.fullName,
    // required this.email,
    // required this.password,
    // required this.phone
  });

  // UserAccount.fromJson(String id, Map json) {
  //   email = id;
  //   fullName = json[userConst.fullName] as String;
  //   phone = json[userConst.phone] as String;
  //   bookings = json[userConst.bookings] as List<Booking>;
  //   favourites = json[userConst.favourites] as List<Carpark>;
  // }

  Map<String, Object?> userInfoToJson() =>
      {userConst.fullName: fullName, userConst.phone: phone};

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
        "User $email",
        "-" * (5 + email!.length),
        "Full Name: $fullName",
        "Phone Number: $phone"
      ].join("\n");

  String favouritesToString() => [
        "FAVOURITES",
        "----------",
        for (int i = 0; i < favourites.length; i++) favourites[i].toString()
      ].join("\n");

  String bookingsToString() => [
        "BOOKINGS",
        "--------",
        for (int i = 0; i < bookings.length; i++) bookings[i].toString()
      ].join("\n");

  String toString() =>
      [userInfoToString(), favouritesToString(), bookingsToString()].join("\n");

  String get id => email!;

  String getEmail() {
    return this.email!;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getFullName() {
    return this.fullName!;
  }

  void setFullName(String fullName) {
    this.fullName = fullName;
  }

  String getPhone() {
    return this.phone!;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }
}
