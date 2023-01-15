// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class GlobalVariables {
  // Global Images path
  static String anonymousImg = 'images/anonymous_user.png';
  static String ziadImg = 'images/ziad_img.jpeg';
  static String tarekImg = 'images/tarek_img.png';
  static String mostafaImg = 'images/mostafa_img.JPG';

  // Global Scaffold Key
  static GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey(); // Create a key
  // Global Colors
  static const post_border_color = Colors.grey;

  // Global Styles
  static const TextStyle header = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle smaller_header = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle bigger_text = TextStyle(
    fontSize: 18,
    // fontWeight: FontWeight.w500,
  );
  static const TextStyle redText = TextStyle(color: Colors.red);
}
