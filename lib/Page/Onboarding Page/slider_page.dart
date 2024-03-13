import "package:flutter/material.dart";

import "../../Images.dart";

class sliderpage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  sliderpage({
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
              Images.s1,
              width: 0.17 * width,
              height: 0.1 * height,
            ),
            SizedBox(height: 0.05 * height),
            // RichText(
            //   text: TextSpan(
            //       style: TextStyle(
            //         fontFamily: 'Poppins',
            //         color: Color.fromARGB(255, 122, 124, 143),
            //         fontSize: 0.055 * width,
            //         fontWeight: FontWeight.w300,
            //       ),
            //       children: [
            //         TextSpan(
            //           text: 'We are a stock market based ',
            //         ),
            //         TextSpan(
            //           text: 'skilled gaming ',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         TextSpan(
            //           text: 'platform to predict candle colours!',
            //         ),
            //       ]),
            // ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                //  Color.fromARGB(255, 122, 124, 143),
                fontSize: 0.055 * width,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   title1,
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'Poppins',
            //     fontSize: 0.055 * width,
            //     color: Color.fromARGB(255, 220, 221, 233),
            //   ),
            // ),
            SizedBox(
              height: 0.1 * height,
            ),
            Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'Poppins',
                fontSize: 0.04 * width,
                color: Color.fromARGB(255, 122, 124, 143),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
