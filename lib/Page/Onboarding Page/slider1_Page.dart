import "package:flutter/material.dart";

import "../../Images.dart";

class sliderpage1 extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  sliderpage1({
    required this.title,
    required this.description,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        color: Color.fromARGB(255, 17, 19, 31),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0.12 * height),
                  Image.asset(
                    image,
                    width: 0.17 * width,
                    height: 0.1 * height,
                  ),
                  SizedBox(height: 0.05 * height),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 220, 221, 233),
                      fontSize: 0.055 * width,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 0.05 * height),
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                      fontSize: 0.04 * width,
                      color: Color.fromARGB(255, 122, 124, 143),
                    ),
                  ),
                ])));
  }
}
