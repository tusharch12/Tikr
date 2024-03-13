import 'package:flutter/material.dart';

class ResponsiveTextStyle {
  static TextStyle get(BuildContext context) {
    return TextStyle(
      color: Color(0XFFDCDDE9),
      fontSize: MediaQuery.of(context).size.width * 0.045,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle poolPlayer(BuildContext context) {
    return TextStyle(
      color: Color(0XFFDCDDE9),
      fontSize: MediaQuery.of(context).size.width * 0.045,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle headline1(BuildContext context) {
    return TextStyle(
      color: Color(0XFFDCDDE9),
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle profile(BuildContext context) {
    return TextStyle(
        color: Color.fromARGB(255, 220, 221, 233),
        fontSize: MediaQuery.of(context).size.width * 0.04,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400);
  }

  static TextStyle ticketSize(BuildContext context) {
    return TextStyle(
        color: Color.fromARGB(255, 220, 221, 233),
        fontSize: MediaQuery.of(context).size.width * 0.04,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold);
  }

  static TextStyle pool(BuildContext context) {
    return TextStyle(
        color: Color.fromARGB(255, 220, 221, 233),
        fontSize: MediaQuery.of(context).size.width * 0.038,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400);
  }

  static TextStyle regular(BuildContext context) {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
        fontSize: MediaQuery.of(context).size.width * 0.032,
        color: Color(0XFFDCDDE9));
  }

  static TextStyle header(BuildContext context) {
    return TextStyle(
      color: Color.fromARGB(255, 220, 221, 233),
      fontSize: MediaQuery.of(context).size.width * 0.043,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    );
  }
}
