import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:tikr/class/simpleChartData.dart';
class pCandle extends StatefulWidget {
  pCandle({
    required this.dn,
    required this.token,
    required this.time_int,
    super.key,
  });
  String dn;
  String token;
  int time_int;
  @override
  State<pCandle> createState() => _pCandleState();
}

class _pCandleState extends State<pCandle> {
  int num1 = 1;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),

      padding: const EdgeInsets.all(0),
      color: const Color.fromARGB(255, 78, 79, 87),
      constraints: const BoxConstraints(maxWidth: 154),
      // splashRadius: 120,
      child: const boxRed(),
      position: PopupMenuPosition.under,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 0,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 50,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                          },
                          child: SvgPicture.asset('assests/game/minus.svg')),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 25,
                        child: Center(
                            child: Text(
                          '$num1',
                          style: const TextStyle(color: Colors.white),
                        )),
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 30, 32, 51),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                           
                          },
                          child: SvgPicture.asset('assests/game/plus.svg')),
                    ],
                  ),
                );
              },
            ),
          ),
          PopupMenuItem(
              height: 0,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Container(
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: const Center(
                            child: Text(
                              "Green",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: Color.fromARGB(255, 220, 221, 223)),
                            ),
                          ),
                          height: 25,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 36, 201, 171)),
                        )),
                    const SizedBox(
                      width: 13,
                    ),
                    GestureDetector(
                        onTap: () async {
                          var res = await ticket_purchaseL("red", widget.dn,num1, widget.token, widget.time_int,num1);

                          var res_body = jsonDecode(res);
                          // if (res_body["msg"] == "Balance insufficient") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              // behavior: SnackBarBehavior.fixed,
                              // dismissDirection: DismissDirection.horizontal,
                              backgroundColor: Colors.transparent,
                              content: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Color(0xFFC72C41),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 0.3 * h,
                                width: 0.1 * w,
                                child: Column(
                                  children: [
                                    Text(res_body["msg"]),
                                  ],
                                ),
                              )));
                        },
                        child: Container(
                          child: const Center(
                            child: Text(
                              "Red",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: Color.fromARGB(255, 220, 221, 223)),
                            ),
                          ),
                          height: 25,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 227, 51, 66)),
                        )),
                  ],
                ),
              ))
        ];
      },
    );
  }
}

// class box extends StatefulWidget {
//   const box({super.key});

//   @override
//   State<box> createState() => _boxState();
// }

// class _boxState extends State<box> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation _animation;

//   void initState() {
//     _controller =
//         AnimationController(vsync: this, duration: const Duration(seconds: 15))
//           ..forward()
//           ..reverse()
//           ..repeat();
//     _animation = bgColor.animate(_controller);
//   }

//   Animatable<Color> bgColor = RainbowColorTween(
//       [Colors.red, Color.fromARGB(255, 0, 255, 102), Colors.red]);

//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//         animation: _animation,
//         builder: ((context, child) {
//           return DottedBorder(
//               color: _animation.value,
//               strokeWidth: 1.5,
//               borderType: BorderType.RRect,
//               radius: const Radius.circular(01),
//               padding: const EdgeInsets.all(0),
//               child: ClipRRect(
//                   borderRadius: const BorderRadius.all(Radius.circular(0)),
//                   child: Container(
//                       height: 105,
//                       width: 23,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         // border: Border.all(color: Colors.red, width: 1.5),
//                       ))));
//         }));
//   }
// }

class boxRed extends StatefulWidget {
  const boxRed({super.key});

  @override
  State<boxRed> createState() => _boxRedState();
}

class _boxRedState extends State<boxRed> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 15))
          ..forward()
          ..reverse()
          ..repeat();
    _animation = bgColor.animate(_controller);
  }

  Animatable<Color> bgColor = RainbowColorTween([
    Color.fromARGB(255, 0, 255, 102),
    Colors.red,
    Color.fromARGB(255, 0, 255, 102),
  ]);

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _animation,
        builder: ((context, child) {
          return DottedBorder(
              color: _animation.value,
              strokeWidth: 1.5,
              borderType: BorderType.RRect,
              radius: const Radius.circular(01),
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  child: Container(
                      height: 0.23 * h,
                      width: 0.052 * w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Colors.red, width: 1.5),
                      ))));
        }));
  }
}
