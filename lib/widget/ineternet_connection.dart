import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../Images.dart';

Widget buildLoading() {
  return Center(
      child: SpinKitThreeBounce(
    size: 40,
    color: Colors.white,
  ));
}

Widget buildNoInternet(BuildContext context) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 17, 19, 31),
    body: Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image.asset(
            Images.internet_connection,
            height: 0.1 * h,
            width: 0.25 * w,
          ),
        ),
        SizedBox(
          height: 0.01 * h,
        ),
        Center(
          child: Text('Internet Connection',
              style: TextStyle(
                  color: Color.fromARGB(255, 220, 221, 233),
                  fontSize: 0.04 * w,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300)),
        ),
        Text('Not Available',
            style: TextStyle(
                color: Color.fromARGB(255, 220, 221, 233),
                fontSize: 0.04 * w,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300)),
        SizedBox(
          height: 0.02 * h,
        ),
        Container(
            height: 0.05 * h,
            width: 0.4 * w,
            // color: Color.fromARGB(255, 17, 19, 31),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 227, 51, 66),
                  Color.fromARGB(255, 182, 18, 103)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30),
              border: GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 222, 203, 195),
                    Color.fromARGB(0, 222, 203, 195)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                width: 1,
              ),
            ),
            child: Center(
                child: Container(
              padding: EdgeInsets.fromLTRB(0, 7.9, 0, 7.9),
              constraints: BoxConstraints(
                  // maxWidth: 0.25 * w,
                  // minHeight: 0.002 * h,
                  ),
              child: Center(
                child: Text(
                  "Retry",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 0.038 * w,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(255, 255, 255, 1)),
                ),
              ),
            )))
      ],
    )),
  );
}
