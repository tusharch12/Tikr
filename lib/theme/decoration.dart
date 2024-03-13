import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

BoxDecoration decoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: 
      const GradientBoxBorder(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 92, 95, 122),
            Color.fromARGB(0, 0, 0, 0),
          ])),
      gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 37, 41, 41),
            Color.fromARGB(0, 30, 32, 51)
          ]));
}

BoxDecoration decoration_border() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.white, width: 2),
      // const GradientBoxBorder(
      //     gradient: LinearGradient(
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomCenter,
      //         colors: [
      //       Color.fromARGB(255, 92, 95, 122),
      //       Color.fromARGB(0, 0, 0, 0),
      //     ])),
      gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 37, 41, 41),
            Color.fromARGB(0, 30, 32, 51)
          ]));
}
