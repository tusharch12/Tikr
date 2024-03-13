import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tikr/button.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../widget/CustomNotification.dart';
import '../Images.dart';
import '../Modals/orders/orders_modal.dart';
import '../Page/Search page/popUp.dart';

//publicPool data,
void popUp(context, body) {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  showModalBottomSheet(
      isDismissible: true,
      backgroundColor: Color(0XFF1E2033),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bc).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0.04 * w),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 30, 32, 51),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            // height: 43.1.h,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Image.asset(Images.conatiner),
                    Row(
                      children: [
                        ZoomTapAnimation(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("assests/cross.svg")),
                        SizedBox(
                          width: 0.25 * w,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    body["player_type"] == "POOL"
                        ? SvgPicture.asset(
                            body["play_direction"] == "RED"
                                ? Images.popUPredicon
                                : Images.popUpGreenicon,
                            height: 0.081 * h,
                            width: 0.081 * w,
                          )
                        //   Image.asset(
                        //   body["pool_type"] == "PUBLIC"
                        //       ? Images.botg
                        //       : Images.botr,
                        //   // :'assests/poolpopIcon.png',
                        //   width: 0.2 * w,
                        //   //  height: 0.1 * height,
                        // )
                        : Image.asset(
                            body["counter_direction"] == "GREEN"
                                ? Images.botg
                                : Images.botr,
                            // :'assests/poolpopIcon.png',
                            width: 0.2 * w,
                            //  height: 0.1 * height,
                          ),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Text(
                      body["message_main"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.05 * w,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 220, 221, 223)),
                    ),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Text(
                      body["message_explain"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 0.036 * w,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 220, 221, 223)),
                    ),
                    SizedBox(
                      height: 0.04 * h,
                    ),
                    ZoomTapAnimation(
                        onTap: () async {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                        },
                        child: Button(
                          title: "Continue playing",
                        )),
                    SizedBox(
                      height: 0.03 * h,
                    ),
                  ]),
            ),
          ),
        );
      });
}
