import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swipeable_button_flutter/swipebutton.dart';
import 'package:tikr/Page/Potrait%20Chart/swipeBut.dart';
import 'package:tikr/widget/Images.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../Services/sound_effect.dart';
import '../../Services/ticket_purchase.dart';
import '../../widget/CustomNotification.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../widget/popUp.dart';

void popUp1(
    context, body, date, CanCol, dn, _num, time_interval, token, state) {
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
                    // body["player_type"] == "POOL"
                    //     ?
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: CanCol == 'red'
                            ? Colors.red
                            : Color.fromARGB(255, 36, 201, 171),
                      ),
                      height: 0.05 * h,
                      width: 0.44 * w,
                      child: Center(
                        child: Text(
                          CanCol == 'red' ? 'Red' : 'Green',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 0.04 * w,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Text(
                      "Trade ₹ " +
                          _num.toString() +
                          " on ACC for " +
                          date.formattedDate,
                      // "body[message_main]",
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
                      "We hope the best for your analysis!",
                      // " body[message_explain]",
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

                    CustomSwipeButton(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      buttonTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 0.04 * w,
                        fontFamily: 'Poppins',
                      ),
                      swipePercentageNeeded: 0.40,
                      swipeButtonColor: Color.fromARGB(255, 217, 217, 217),
                      iconColor: Colors.white,
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 227, 51, 66),
                          Color.fromARGB(255, 182, 18, 103)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
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
                      height: 0.07 * h,
                      text: "Swipe to continue",
                      onSwipeCallback: () async {
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Loading . . .");
                        var res = await ticket_purchase(
                            CanCol, dn, _num, time_interval, token, state);

                        print(res["statusCode"]);
                        print(res["body"]["data"]["player_type"]);
                        var name = ((res["statusCode"] == 201 &&
                                res["body"]["data"]["player_type"] ==
                                    "PUBLIC" ||
                            res["body"]["data"]["player_type"] == "PRIVATE"));
                        print(name);
                        if (res["statusCode"] == 201 &&
                            res["body"]["data"]["player_type"] == "BOT") {
                          sound_effect().onPurchase_play();
                          Get.back();
                          // popUp(context, res["body"]["data"]);
                        } else if (res["statusCode"] == 201 &&
                                (res["body"]["data"]["pool_type"] == "PUBLIC" ||
                                    res["body"]["data"]["pool_type"] ==
                                        "PRIVATE")
                          
                            ) {
                          sound_effect().onPurchase_play();
                          // popUp(context, res["body"]["data"]);
                          ;
                        } else {
                          Future.delayed(Duration(milliseconds: 700), () {
                            // Navigator.pop(context);
                            CustomMessageDisplay customMessageDisplay =
                                CustomMessageDisplay(context);
                            customMessageDisplay.showMessage(res["msg"]);
                            Get.back();
                          });
                        }
                      },
                    ),

                    SizedBox(
                      height: 0.03 * h,
                    ),
                  ]),
            ),
          ),
        );
      });
}
