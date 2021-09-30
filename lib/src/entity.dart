extension StringExt on String{
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

abstract class Entity{
  Entity.fromJson(Map json);
  Map toJson();
  String toString();
}

class Carpark implements Entity{
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

  Carpark.fromJson(Map json):
    this(
      carparkNo: json["carparkNo"] as String,
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

enum BookingStatus{
  active,
  checkedIn,
  cancelled
}

extension BookingStatusExt on BookingStatus{
  static BookingStatus fromString(String str) => BookingStatus.values.firstWhere((e) => e.toString() == str);
}

class Booking implements Entity{
  String? id;
  DateTime startTime;
  DateTime endTime;
  BookingStatus bookingStatus;
  Carpark carpark;

  Booking({
    this.id,
    required this.startTime,
    required this.endTime,
    this.bookingStatus = BookingStatus.active,
    required this.carpark,
  });

  Booking.fromJson(Map json):
      this(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        bookingStatus: BookingStatusExt.fromString(json["bookingStatus"]),
        carpark: Carpark.fromJson(json["carpark"] as Map<String, Object?>)
      );

  Map<String, Object?> toJson() => {
    "id": id,
    "startTime": startTime,
    "endTime": endTime,
    "bookingStatus": bookingStatus.toString(),
    "carparkNo": carpark.carparkNo
  };
}

class UserAccount{
  String fullName;
  String email;
  String phoneNo;
  bool isVerified;
  Booking activeBooking;
  List<Booking> bookingHistory;
  List<Carpark> favourites;

  UserAccount({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.isVerified,
    required this.activeBooking,
    required this.bookingHistory,
    required this.favourites
  });

  UserAccount.fromJson(
      Map json
      ):
      this(
        fullName: json["fullName"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        isVerified: json["isVerified"],
        activeBooking: Booking.fromJson(json["activeBooking"]),
        bookingHistory: [for (int i=0; i<json["bookingHistory"].length; i++) Booking.fromJson(json["bookingHistory"][i])],
        favourites: [for (int i=0; i<json["favourites"].length; i++) Carpark.fromJson(json["favourites"][i])],
      );

  Map toJson() => {
    "fullName": fullName,
    "phoneNo": phoneNo,
    "isVerified": isVerified,
    "activeBooking" : activeBooking.id,
    "bookingHistory": [for (int i=0; i<bookingHistory.length; i++) bookingHistory[i].id],
    "favourites": [for (int i=0; i<favourites.length; i++) favourites[i].id]
  };

  String get id => email;
}