import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../page/signIn.dart';

Widget SignUpButton(w, h) {
  return ZoomTapAnimation(
    onTap: () {
      Get.offAll(signin1());
    },
    child: Center(
      child: Container(
        // height: 0.05*h,
        alignment: Alignment.center,
        constraints: BoxConstraints(
          maxWidth: 0.37 * w,
          maxHeight: 0.04 * h,
        ),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 100, 180, 103),
              Color.fromARGB(255, 34, 63, 51)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(92, 243, 244, 251),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            width: 1,
          ),
        ),
        child: Center(
            child: Text(
          "Login to continue ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 0.032 * w,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        )),
      ),
    ),
  );
}

Widget loader(context, w, h) {
  return Center(
      child: Container(
    padding: EdgeInsets.fromLTRB(0.03 * w, 0, 0.03 * w, 0),
    child: Center(
        child: SpinKitThreeBounce(
      size: 40,
      color: Colors.white,
    )),
  ));
}
