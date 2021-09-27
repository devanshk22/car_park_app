import 'package:cloud_firestore/cloud_firestore.dart';

void main(){

}

class DatabaseHandler{
  late FirebaseFirestore firestore;
  late CollectionReference carparkInfo;

  DatabaseHandler(){
    this.firestore = FirebaseFirestore.instance;
    this.carparkInfo = this.firestore.collection('hdb-carpark-information');

  }


}