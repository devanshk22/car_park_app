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
          address: json["address"] as String,
          carparkType: json["carparkType"] as String,
          parkingSystem: json["parkingSystem"] as String,
          shortTermParking: json["shortTermParking"] as String,
          freeParking: json["freeParking"] as String,
          nightParking: json["nightParking"] as String,
          carparkBasement: json["carparkBasement"] as String
      );

  Map<String, Object?> toJson() => {
    "address": address,
    "carparkType": carparkType,
    "parkingSystem": parkingSystem,
    "shortTermParking": shortTermParking,
    "freeParking": freeParking,
    "nightParking": nightParking,
    "carparkBasement": carparkBasement
  };

  String toString() {
    String details = [
      "Address: $address",
      "Carpark Type: $carparkType",
      "Parking System: $parkingSystem",
      "Short-Term Parking: $shortTermParking",
      "Free Parking: $freeParking",
      "Night Parking: $nightParking",
      "Carpark Basement: $carparkBasement"
    ].join("\n\t");
    return ["Carpark $carparkNo", details].join("\n");
  }

  String get id => carparkNo;
}