import 'package:flutter/material.dart';
import 'package:car_park_app/constants/app_constants.dart';

class NavCard extends StatelessWidget {
  final Icon icon;
  final String text;
  final Widget page;
  const NavCard({required this.icon, required this.text, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
              child: Container(
                width: 0.52 * getScreenWidth(context) - 2 * screenGap,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Color.fromRGBO(48, 48, 48, 1),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Text(
              '$text',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: icon,
          ),
        ],
      ),
    );
  }
}
