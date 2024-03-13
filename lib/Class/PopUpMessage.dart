import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
class popMessage extends StatefulWidget {
  const popMessage({super.key});

  @override
  State<popMessage> createState() => _popMessageState();
}

class _popMessageState extends State<popMessage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 81.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 7.5.w,
              ),
               ZoomTapAnimation(
                onTap: () {
                  PopUp(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  height: 4.3.h,
                  width: 41.1.w,
                  child: Center(
                    child: Text(
                      'Up Green',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
             ZoomTapAnimation(
                onTap: () {
                  PopUp(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  height: 4.3.h,
                  width: 41.1.w,
                  child: Center(
                    child: Text(
                      'Down Red',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  void PopUp(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                border: GradientBoxBorder(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 222, 203, 195),
                  Color.fromARGB(0, 222, 203, 195)
                ])),
                color: Color.fromARGB(255, 30, 32, 51),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            height: 43.1.h,
            child: Column(children: [
              SizedBox(
                height: 5,
              ),
              Image.asset('assests/Rectangle.png'),
              SizedBox(
                height: 4.5.h,
              ),
              Image.asset(
                'assests/thumb.png',
              ),
              Text(
                'Trade placed successfully!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 220, 221, 223)),
              ),
              SizedBox(
                height: 2.3.h,
              ),
              Text(
                'Your winnings will be out in 5 mins.',
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 220, 221, 223)),
              ),
              Text(
                'All the best!',
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 220, 221, 223)),
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Container(
                child: Center(
                    child: Text('Play Again',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.white))),
                height: 5.4.h,
                width: 90.6.w,
                decoration: BoxDecoration(
                    border: GradientBoxBorder(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 222, 203, 195),
                      Color.fromARGB(0, 222, 203, 195),
                    ])),
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 227, 51, 66),
                          Color.fromARGB(255, 182, 18, 103),
                        ])),
              ),
              SizedBox(
                height: 1.6.h,
              ),
              ZoomTapAnimation(
                  onTap: () {},
                  child: Text('Back Home',
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 36, 201, 171))))
            ]),
          );
        });
  }
}
