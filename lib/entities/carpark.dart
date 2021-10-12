import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/databaseConsts.dart';

class Carpark{
  String carparkNo;
  String address;
  String carparkType;
  String parkingSystem;
  String shortTermParking;
  String freeParking;
  String nightParking;
  String carparkBasement;
  GeoPoint? location;

  Carpark({
    required this.carparkNo,
    required this.address,
    required this.carparkType,
    required this.parkingSystem,
    required this.shortTermParking,
    required this.freeParking,
    required this.nightParking,
    required this.carparkBasement,
    this.location
  });

  Carpark.fromJson(String documentID, Map json):
        this(
          carparkNo: documentID,
          address: json[carparkConst.address],
          carparkType: json[carparkConst.carparkType],
          parkingSystem: json[carparkConst.parkingSystem],
          shortTermParking: json[carparkConst.shortTermParking],
          freeParking: json[carparkConst.freeParking],
          nightParking: json[carparkConst.nightParking],
          carparkBasement: json[carparkConst.carparkBasement],
          location: json[carparkConst.location]
      );

  Map<String, Object?> toJson() => {
    carparkConst.address: address,
    carparkConst.carparkType: carparkType,
    carparkConst.parkingSystem: parkingSystem,
    carparkConst.shortTermParking: shortTermParking,
    carparkConst.freeParking: freeParking,
    carparkConst.nightParking: nightParking,
    carparkConst.carparkBasement: carparkBasement
  };

  String toString() => [
    "Carpark $carparkNo",
    "-" * (8 + carparkNo.length),
    "Address: $address",
    "Carpark Type: $carparkType",
    "Parking System: $parkingSystem",
    "Short-Term Parking: $shortTermParking",
    "Free Parking: $freeParking",
    "Night Parking: $nightParking",
    "Carpark Basement: $carparkBasement",
    "Latitude: ${location?.latitude}",
    "Longitude: ${location?.longitude}"
  ].join("\n");

  String get id => carparkNo;
}

extension on String{
  String capitalize() {
    if (this.length == 0) return this;

    String str = "${this[0].toUpperCase()}";
    if (this.length > 1) str += "${this.substring(1).toLowerCase()}";
    return str;
  }

  String capitalizeEachWord(){
    List<String> words = this.split(" ");
    for (int i=0; i<words.length; i++) words[i] = words[i].capitalize();
    return words.join(" ");
  }

  String formatYesNo(){
    switch(this){
      case "Y":
        return "Yes";
      case "N":
        return "No";
      default:
        return "-";
    }
  }
}

class CarparkDataHandler extends Carpark{
  int carparkDecks;
  double gantryHeight;

  CarparkDataHandler({
    required String carparkNo,
    required String address,
    required String carparkType,
    required String parkingSystem,
    required String shortTermParking,
    required String freeParking,
    required String nightParking,
    required String carparkBasement,
    required GeoPoint location,
    required this.carparkDecks,
    required this.gantryHeight
  }):
        super(
          carparkNo: carparkNo,
          address: address,
          carparkType: carparkType,
          parkingSystem: parkingSystem,
          shortTermParking: shortTermParking,
          freeParking: freeParking,
          nightParking: nightParking,
          carparkBasement: carparkBasement,
          location: location
      );

  CarparkDataHandler.fromJson(Map json):
        this(
          carparkNo: json[carparkInfoConst.carparkNo],
          address: (json[carparkInfoConst.address] as String).capitalizeEachWord(),
          carparkType: (json[carparkInfoConst.carparkType] as String).capitalizeEachWord(),
          parkingSystem: (json[carparkInfoConst.parkingSystem] as String).capitalizeEachWord(),
          shortTermParking: (json[carparkInfoConst.shortTermParking] as String).capitalizeEachWord(),
          freeParking: (json[carparkInfoConst.freeParking] as String).capitalizeEachWord(),
          nightParking: (json[carparkInfoConst.nightParking] as String).capitalizeEachWord(),
          carparkBasement: (json[carparkInfoConst.carparkBasement] as String).formatYesNo(),
          location: json[carparkConst.location],
          carparkDecks: int.parse(json[carparkInfoConst.carparkDecks]),
          gantryHeight: double.parse(json[carparkInfoConst.gantryHeight])
      );

  Map<String, Object?> toJson() => {
    carparkConst.address: address,
    carparkConst.carparkType: carparkType,
    carparkConst.parkingSystem: parkingSystem,
    carparkConst.shortTermParking: shortTermParking,
    carparkConst.freeParking: freeParking,
    carparkConst.nightParking: nightParking,
    carparkConst.carparkBasement: carparkBasement,
    carparkConst.location: location,
    carparkConst.carparkDecks: carparkDecks,
    carparkConst.gantryHeight: gantryHeight
  };
}