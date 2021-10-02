// The collection and field names of the database

class carparkConst{
  static const String collectionName = carparkInfoApiConst.collectionName;
  static const String address = "address";
  static const String carparkBasement = "carparkBasement";
  static const String carparkDecks = "carparkDecks";
  static const String carparkType = "carparkType";
  static const String freeParking = "freeParking";
  static const String gantryHeight = "gantryHeight";
  static const String nightParking = "nightParking";
  static const String parkingSystem = "parkingSystem";
  static const String shortTermParking = "shortTermParking";
  static const String xCoord = "xCoord";
  static const String yCoord = "yCoord";
}

class userConst{
  static const String collectionName = "users";
  static const String favourites = "favourites";
  static const String fullName = "fullName";
  static const String phone = "phone";
  static const String bookings = bookingConst.collectionName;
}

class bookingConst{
  static const String collectionName = "bookings";
  static const String startTime = "bookingStart";
  static const String endTime = "bookingEnd";
  static const String status = "bookingStatus";
  static const String carparkRef = "carparkID";
  static const String carparkObj = "carpark";
}

class carparkInfoApiConst{
  static const String collectionName = "hdb-carpark-information";
  static const String carparkNo = "car_park_no";
  static const String address = "address";
  static const String carparkBasement = "car_park_basement";
  static const String carparkDecks = "car_park_decks";
  static const String carparkType = "car_park_type";
  static const String freeParking = "free_parking";
  static const String gantryHeight = "gantry_height";
  static const String nightParking = "night_parking";
  static const String parkingSystem = "type_of_parking_system";
  static const String shortTermParking = "short_term_parking";
  static const String xCoord = "x_coord";
  static const String yCoord = "y_coord";
}
