import "package:flutter/material.dart";

import "../../Images.dart";

class sliderpage2 extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  sliderpage2({
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
                  Images.s4,
                  width: 0.3 * width,
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
                SizedBox(
                  height: 0.07 * height,
                ),
                Row(
                  children: [
                    Container(
                      height: 0.05 * height,
                      width: 0.1 * width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 19, 19, 50),
                          shape: BoxShape.circle),
                      child: Image.asset(Images.Group1,
                          width: 0.06 * width, height: 0.1 * height),
                    ),
                    SizedBox(width: 0.009 * width),
                    Text(
                      "Step 01 - ",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 0.04 * width,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "Add Cash",
                      style: TextStyle(
                        fontSize: 0.04 * width,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 0.03 * height),
                Row(
                  children: [
                    Container(
                      height: 0.05 * height,
                      width: 0.1 * width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 19, 19, 50),
                          shape: BoxShape.circle),
                      child: Image.asset(Images.Group2,
                          width: 0.06 * width, height: 0.1 * height),
                    ),
                    SizedBox(
                      width: 0.009 * width,
                    ),
                    Text(
                      "Step 02 - ",
                      style: TextStyle(
                        fontSize: 0.04 * width,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "Join a Pool",
                      style: TextStyle(
                        fontSize: 0.04 * width,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 0.03 * height),
                Row(
                  children: [
                    Container(
                      height: 0.05 * height,
                      width: 0.1 * width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 19, 19, 50),
                          shape: BoxShape.circle),
                      child: Image.asset(Images.Group3,
                          width: 0.06 * width, height: 0.1 * height),
                    ),
                    SizedBox(width: 0.009 * width),
                    Text(
                      "Step 03 -",
                      style: TextStyle(
                        fontSize: 0.04 * width,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "Predict Colour",
                      style: TextStyle(
                        fontSize: 0.04 * width,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 0.03 * height),
                Row(
                  children: [
                    Container(
                      height: 0.05 * height,
                      width: 0.1 * width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 19, 19, 50),
                          shape: BoxShape.circle),
                      child: Image.asset(Images.Group4,
                          width: 0.06 * width, height: 0.1 * height),
                    ),
                    SizedBox(width: 0.009 * width),
                    Text(
                      "Step 04 - ",
                      style: TextStyle(
                        fontSize: 0.04 * width,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "Earn Cash",
                      style: TextStyle(
                        fontSize: 0.04 * width,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    )
                  ],
                ),
              ]),
        ));
  }
}
