import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class Button extends StatelessWidget {
  final String title;
  Button({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxWidth: 0.9 * width,
        minHeight: 0.07 * height,
      ),
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
          child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 0.04 * width,
          fontFamily: 'Poppins',
        ),
      )),
    );
  }
}
