import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tikr/button.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../Images.dart';
import '../../widget/CustomNotification.dart';
import '../Search page/popUp.dart';

//publicPool data,
void createPoolpopUp(context, pool_name, pool_code, pooltype) {
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
              child: Column(children: [
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
                        child: SvgPicture.asset(Images.cross)),
                    SizedBox(
                      width: 0.25 * w,
                    ),
                    Spacer(),
                    ZoomTapAnimation(
                        onTap: () async {
                          HapticFeedback.lightImpact();
                          copyToClipboard(pool_code);
                          await Clipboard.setData(
                              ClipboardData(text: pool_code));
                          CustomMessageDisplay customMessageDisplay =
                              CustomMessageDisplay(context);
                          customMessageDisplay
                              .showMessage("Successfully copied pool code 👍🏻");
                        },
                        child: SvgPicture.asset(Images.copy)),
                  ],
                ),
                SizedBox(
                  height: 0.02 * h,
                ),
                Image.asset(
                  pooltype == "Public"
                      ? "assests/four.png"
                      : "assests/three.png",
                  width: 0.2 * w,
                  //  height: 0.1 * height,
                ),
                SizedBox(
                  height: 0.01 * h,
                ),
                Text(
                  'Successfully Created!',
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
                  'Share the pool code with your mates &\nchallenge them!',
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
                      Share.share("Hey, I invite you to join " +
                          pool_name +
                          " pool! Use the following pool code to join! \n " +
                          pool_code);
                    },
                    child: Button(title: "Share")),
                SizedBox(
                  height: 0.03 * h,
                ),
              ]),
            ),
          ),
        );
      });
}
