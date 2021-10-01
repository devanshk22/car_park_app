import 'booking.dart';
import 'carpark.dart';

class User {
  late String fullName;
  late String email;
  late String phone;
  late String password;
  late bool isVerified;
  late List<Booking> bookingList;
  late List<Carpark> favourites;

  User(String email, String fullName, String phone, String password) {
    this.email = email;
    this.fullName = fullName;
    this.phone = phone;
    this.password = password;
  }

  String getEmail() {
    return this.email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getFullName() {
    return this.fullName;
  }

  void setFullName(String fullName) {
    this.fullName = fullName;
  }

  String getPassword() {
    return this.password;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getPhone() {
    return this.phone;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }

  bool getIsVerified() {
    return this.isVerified;
  }

  void setIsVerified(bool isVerified) {
    this.isVerified = isVerified;
  }
}
