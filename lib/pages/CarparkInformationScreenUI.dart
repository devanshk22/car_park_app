import 'package:car_park_app/entities/carpark.dart';
import 'package:car_park_app/pages/MapUI.dart';
import 'package:flutter/material.dart';

class CarparkInformationScreenUI extends StatefulWidget {
  final Carpark onecarpark;
  final double distanceBetween;
  CarparkInformationScreenUI({required this.onecarpark, required this.distanceBetween});

  @override
  _CarparkInformationScreenUI createState(){
    return _CarparkInformationScreenUI(this.onecarpark, this.distanceBetween);
  }
}

class _CarparkInformationScreenUI extends State<CarparkInformationScreenUI>{
    TextEditingController textFieldController = TextEditingController();

    final Carpark onecarpark;
    final double distanceBetween;
    _CarparkInformationScreenUI(this.onecarpark, this.distanceBetween);

    @override
    Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text('Carpark Information'),
                        backgroundColor: Colors.black,),

        body: Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x44444444),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                              )
                          ),

                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(' ${onecarpark.address}',
                              style: TextStyle(
                                fontSize: 22,
                              fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          Container(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Text(' ${distanceBetween.toStringAsPrecision(2)}km away',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 17,
                                ),
                              ),
                          ),

                          Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: RichText(
                              text: TextSpan(
                                text: ' Carpark Type: ',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                children: <TextSpan> [
                                  TextSpan(
                                      text: ' ${onecarpark.carparkType}', style: TextStyle(fontSize: 16, color: Colors.white),),
                          ],),),),

                          Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: RichText(
                              text: TextSpan(
                                text: ' Carpark Basement: ',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                children: <TextSpan> [
                                  TextSpan(
                                    text: ' ${onecarpark.carparkBasement}', style: TextStyle(fontSize: 16, color: Colors.white),),
                                ],),),),

                          Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: RichText(
                              text: TextSpan(
                                text: ' Carpark System: ',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                children: <TextSpan> [
                                  TextSpan(
                                    text: ' ${onecarpark.parkingSystem}', style: TextStyle(fontSize: 16, color: Colors.white),),
                                ],),),),

                          Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: RichText(
                              text: TextSpan(
                                text: ' Free Parking Times: ',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                children: <TextSpan> [
                                  TextSpan(
                                    text: ' ${onecarpark.freeParking}', style: TextStyle(fontSize: 16, color: Colors.white),),
                                ],),),),

                          Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: RichText(
                              text: TextSpan(
                                text: ' Night Parking: ',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                children: <TextSpan> [
                                  TextSpan(
                                    text: ' ${onecarpark.nightParking}', style: TextStyle(fontSize: 16, color: Colors.white),),
                                ],),),),

                          Container(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: RichText(
                              text: TextSpan(
                                text: ' Short-term Parking: ',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                children: <TextSpan> [
                                  TextSpan(
                                    text: ' ${onecarpark.shortTermParking}', style: TextStyle(fontSize: 16, color: Colors.white),),
                                ],),),),

                          Center(
                            child: ElevatedButton(
                              child: const Text('View on Map'),
                              onPressed:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MapUI()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 25),
                                textStyle: const TextStyle(fontSize: 20,)),
                            ),),
                        ],),),
          ],),
          ),),),
      );
  }

void _sendDataBack(BuildContext context){
  String textToSendBack = textFieldController.text;
  Navigator.pop(context, textToSendBack);
}

}

