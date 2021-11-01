import 'package:car_park_app/entities/all.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/databaseConsts.dart';

enum BookingStatus { UPCOMING, ACTIVE, PAST, CANCELLED }

extension BookingStatusExt on BookingStatus{
  static BookingStatus fromString(String str) => BookingStatus.values.firstWhere((e) => e.toString() == str);
}

class Booking {
  String? id;
  late Carpark carPark;
  late DateTime bookingStart;
  late DateTime bookingEnd;
  late BookingStatus status;

  Booking(Carpark carPark, DateTime bookingStart, DateTime bookingEnd, [BookingStatus? status]) {
    this.carPark = carPark;
    this.bookingStart = bookingStart;
    this.bookingEnd = bookingEnd;
    if (status != null) this.status = status;
    else if (bookingStart.isAfter(DateTime.now())) {
      setBookingStatus(BookingStatus.UPCOMING);
    } else if (bookingStart.isBefore(DateTime.now()) &&
        bookingEnd.isAfter(DateTime.now())) {
      setBookingStatus(BookingStatus.ACTIVE);
    } else if (bookingEnd.isBefore(DateTime.now())) {
      setBookingStatus(BookingStatus.PAST);
    }
  }

  Booking.fromJson(String id, Map json): this(
      json[bookingConst.carparkObj] as Carpark,
      json[bookingConst.startTime].toDate() as DateTime,
      json[bookingConst.endTime].toDate() as DateTime,
      BookingStatusExt.fromString(json[bookingConst.status])
  );

  Map<String, Object?> toJson() => {
    bookingConst.carparkRef: FirebaseFirestore.instance.collection(carparkConst.collectionName).doc(carPark.id),
    bookingConst.startTime: Timestamp.fromDate(bookingStart),
    bookingConst.endTime: Timestamp.fromDate(bookingEnd),
    bookingConst.status: status.toString(),
  };

  String toString() => [
    "Booking Object",
    "--------------",
    "Car Park ID: ${carPark.carparkNo}",
    "Booking Start Time: $bookingStart",
    "Booking End Time: $bookingEnd",
    "Status: $status"
  ].join("\n");

  void setBookingStatus(BookingStatus bs) {
    this.status = bs;
  }

  BookingStatus getBookingStatus() {
    return this.status;
  }

  void changeBooking(DateTime start, DateTime end) {
    this.bookingStart = start;
    this.bookingEnd = end;
  }
}
