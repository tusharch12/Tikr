import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../Modals/Pools/PublicPool_modal.dart';
import 'dialog.dart';

Widget listPP(publicPool data, h, w, context, token) {
  return SingleChildScrollView(
      child: Column(children: [
    Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
        // height: 0.1 * h,
        width: 0.9 * w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: const GradientBoxBorder(
                width: 1,
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 92, 95, 122),
                    Color.fromARGB(0, 0, 0, 0),
                    // Color.fromARGB(255, 30, 32, 51)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                )),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 23, 52, 68),
                Color.fromARGB(255, 30, 32, 51),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 0.026 * w,
            ),
            ClipOval(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SvgPicture.asset(
                Images.public,
                height: 0.05 * h,
              ),
            ),
            SizedBox(
              width: 0.026 * w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data.pool_name, style: ResponsiveTextStyle.get(context)),
                GradientText(
                  "\u{20B9} " + data.total_winnings,
                  style: TextStyle(
                    fontSize: 0.032 * w,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                  colors: [
                    Color.fromARGB(255, 100, 180, 103),
                    Color.fromARGB(255, 152, 218, 190),
                  ],
                ),

                Text(
                    data.no_players == "1"
                        ? "${data.no_players} Player"
                        : "${data.no_players} Players",
                    // "${data.no_players} player ",
                    style: ResponsiveTextStyle.regular(context)),
                // Spacer()
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ZoomTapAnimation(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    showDialog(
                        context: context,
                        builder: (BuildContext buildContext) {
                          return poolPlayers(token:token ,pool_name: data.pool_name,pool_code:data.pool_code);
                        });
                    // PopUp(context, data, token);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      maxWidth: 0.23 * w,
                      minHeight: 0.027 * h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 142, 88, 255),
                          Color.fromARGB(255, 100, 18, 255)
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
                    ),
                    child: Text(
                      "Join Now",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 0.03 * w,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 0.03 * w,
            )
          ],
        )),
    SizedBox(
      height: 0.015 * h,
    ),
  ]));
}
