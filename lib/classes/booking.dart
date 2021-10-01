enum BookingStatus { UPCOMING, ACTIVE, PAST, CANCELLED }

class Booking {
  late String carParkId;
  late DateTime bookingStart;
  late DateTime bookingEnd;
  late BookingStatus status;

  Booking(String carParkId, DateTime bookingStart, DateTime bookingEnd) {
    this.carParkId = carParkId;
    this.bookingStart = bookingStart;
    this.bookingEnd = bookingEnd;
    if (bookingStart.isAfter(DateTime.now())) {
      setBookingStatus(BookingStatus.UPCOMING);
    } else if (bookingStart.isBefore(DateTime.now()) &&
        bookingEnd.isAfter(DateTime.now())) {
      setBookingStatus(BookingStatus.ACTIVE);
    } else if (bookingEnd.isBefore(DateTime.now())) {
      setBookingStatus(BookingStatus.PAST);
    }
  }

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
