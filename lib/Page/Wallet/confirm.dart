import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tikr/Page/Setting%20Page/contactus.dart';
import 'package:tikr/button.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../Home.dart';

class confirm extends StatelessWidget {
  confirm({Key? key, required this.token}) : super(key: key);
  String token;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 17, 19, 31),
      body: SafeArea(
          minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 0.041 * h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0.046 * w,
                      child: ZoomTapAnimation(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            'assests/Arrow.svg',
                            height: 0.041 * h,
                            width: 0.041 * w,
                          )),
                    ),
                    Center(
                        child: Text(
                      "Withdraw Request",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 220, 221, 233),
                        fontSize: 0.043 * w,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 0.04 * h,
                      ),
                      Text("Successfully submitted the request!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 220, 221, 233),
                              fontSize: 0.055 * w,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold)),
                      Spacer(),
                      ZoomTapAnimation(
                          onTap: () {
                            Get.offAll(() => My(
                                  token: token
                                ));
                          },
                          child: Button(title: "Done")),
                      SizedBox(height: 0.03 * h),
                    ],
                  ),
                ),
              ))
            ],
          )),
    );
  }
}
