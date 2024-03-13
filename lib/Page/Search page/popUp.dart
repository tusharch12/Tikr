import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/svg.dart";
import "package:gradient_borders/box_borders/gradient_box_border.dart";
import "package:tikr/button.dart";
import "package:zoom_tap_animation/zoom_tap_animation.dart";
import "../../Images.dart";
import "../../Modals/Pools/PublicPool_modal.dart";
import "../../widget/CustomNotification.dart";
import "../Pool page/Pool_Page.dart";

Future<void> copyToClipboard(String text) async {
  // Optional: Show a message that the text has been copied
  print('Text copied to clipboard: $text');
}

void PopUp(context, publicPool data, token) {
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
                          copyToClipboard(data.pool_code);
                          await Clipboard.setData(
                              ClipboardData(text: data.pool_code));

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
                  Images.user,
                  width: 0.2 * w,
                  //  height: 0.1 * height,
                ),
                Text(
                  'Join the pool?',
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
                  'You can join & play with any of the available public pools on the platform!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 0.04 * w,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 220, 221, 223)),
                ),
                SizedBox(
                  height: 0.04 * h,
                ),
                ZoomTapAnimation(
                    onTap: () async {
                      HapticFeedback.lightImpact();

                      var res = await Join_pool(data.pool_code, token);

                      var res_body = jsonDecode(res.body);

                      Future.delayed(Duration(milliseconds: 700), () {
                        Navigator.pop(context);

                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage(res_body["msg"]);
                      });
                    },
                    child: Button(title: 'Let’s go!')),
                SizedBox(
                  height: 0.03 * h,
                ),
              ]),
            ),
          ),
        );
      });
}
