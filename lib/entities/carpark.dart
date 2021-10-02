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

  Carpark({
    required this.carparkNo,
    required this.address,
    required this.carparkType,
    required this.parkingSystem,
    required this.shortTermParking,
    required this.freeParking,
    required this.nightParking,
    required this.carparkBasement
  });

  Carpark.fromJson(String documentID, Map json):
        this(
          carparkNo: documentID,
          address: json[carparkConst.address] as String,
          carparkType: json[carparkConst.carparkType] as String,
          parkingSystem: json[carparkConst.parkingSystem] as String,
          shortTermParking: json[carparkConst.shortTermParking] as String,
          freeParking: json[carparkConst.freeParking] as String,
          nightParking: json[carparkConst.nightParking] as String,
          carparkBasement: json[carparkConst.carparkBasement] as String
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
    "Carpark Basement: $carparkBasement"
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
  double xCoord;
  double yCoord;
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
    required this.xCoord,
    required this.yCoord,
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
          carparkBasement: carparkBasement
      );

  CarparkDataHandler.fromJson(Map json):
        this(
          carparkNo: json[carparkInfoApiConst.carparkNo],
          address: (json[carparkInfoApiConst.address] as String).capitalizeEachWord(),
          carparkType: (json[carparkInfoApiConst.carparkType] as String).capitalizeEachWord(),
          parkingSystem: (json[carparkInfoApiConst.parkingSystem] as String).capitalizeEachWord(),
          shortTermParking: (json[carparkInfoApiConst.shortTermParking] as String).capitalizeEachWord(),
          freeParking: (json[carparkInfoApiConst.freeParking] as String).capitalizeEachWord(),
          nightParking: (json[carparkInfoApiConst.nightParking] as String).capitalizeEachWord(),
          carparkBasement: (json[carparkInfoApiConst.carparkBasement] as String).formatYesNo(),
          xCoord: double.parse(json[carparkInfoApiConst.xCoord]),
          yCoord: double.parse(json[carparkInfoApiConst.yCoord]),
          carparkDecks: int.parse(json[carparkInfoApiConst.carparkDecks]),
          gantryHeight: double.parse(json[carparkInfoApiConst.gantryHeight])
      );

  Map<String, Object?> toJson() => {
    carparkConst.address: address,
    carparkConst.carparkType: carparkType,
    carparkConst.parkingSystem: parkingSystem,
    carparkConst.shortTermParking: shortTermParking,
    carparkConst.freeParking: freeParking,
    carparkConst.nightParking: nightParking,
    carparkConst.carparkBasement: carparkBasement,
    carparkConst.xCoord: xCoord,
    carparkConst.yCoord: yCoord,
    carparkConst.carparkDecks: carparkDecks,
    carparkConst.gantryHeight: gantryHeight
  };
}