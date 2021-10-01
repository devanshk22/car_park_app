import 'carpark.dart';

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
          carparkNo: json["car_park_no"],
          address: (json["address"] as String).capitalizeEachWord(),
          carparkType: (json["car_park_type"] as String).capitalizeEachWord(),
          parkingSystem: (json["type_of_parking_system"] as String).capitalizeEachWord(),
          shortTermParking: (json["short_term_parking"] as String).capitalizeEachWord(),
          freeParking: (json["free_parking"] as String).capitalizeEachWord(),
          nightParking: (json["night_parking"] as String).capitalizeEachWord(),
          carparkBasement: (json["car_park_basement"] as String).formatYesNo(),
          xCoord: double.parse(json["x_coord"]),
          yCoord: double.parse(json["y_coord"]),
          carparkDecks: int.parse(json["car_park_decks"]),
          gantryHeight: double.parse(json["gantry_height"])
      );

  Map<String, Object?> toJson() => {
    "address": address,
    "carparkType": carparkType,
    "parkingSystem": parkingSystem,
    "shortTermParking": shortTermParking,
    "freeParking": freeParking,
    "nightParking": nightParking,
    "carparkBasement": carparkBasement,
    "xCoord": xCoord,
    "yCoord": yCoord,
    "carparkDecks": carparkDecks,
    "gantryHeight": gantryHeight
  };

  String get id => carparkNo;
}