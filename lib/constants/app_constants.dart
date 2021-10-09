import 'package:flutter/material.dart';

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getScreenHeightExcludeSafeArea(BuildContext context) {
  final double height = MediaQuery.of(context).size.height;
  final EdgeInsets padding = MediaQuery.of(context).padding;
  return height - padding.top - padding.bottom;
}

const double screenGap = 20;
const double cardGap = 10;
