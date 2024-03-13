import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";
import "package:gradient_borders/box_borders/gradient_box_border.dart";
import "package:simple_gradient_text/simple_gradient_text.dart";
import "package:tikr/widget/textstyle.dart";
import "package:zoom_tap_animation/zoom_tap_animation.dart";
import "../../Modals/homePage/homePageStockList_modal.dart";
import "../g1new.dart";

Widget listCard(
  BuildContext context,
  homePageStockList_modal data,
  String token,
  state,
) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return ZoomTapAnimation(
    onTap: () {
      HapticFeedback.lightImpact();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => g11(
                dn: data.display_name,
                data: data.yahoo_tkr_name,
                token: token,
                state: state,
              )));
    },
    child: Column(
      children: [
        Container(
          // padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * width, 0),
          height: 0.08 * height,
          width: 0.9 * width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 0.026 * width,
              ),
              SvgPicture.asset(
                'assests/papa.svg',
                height: 0.05 * height,
              ),
              // SvgPicture.asset("assests/homee.svg"),
              SizedBox(
                width: 0.02 * width,
              ),
              Text(data.display_name, style: ResponsiveTextStyle.get(context)),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 0.01 * height,
                  // ),
                  // Spacer(),
                  GradientText(
                    "\u{20B9} " + data.last_price,
                    style: TextStyle(
                      fontSize: 0.04 * width,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                    colors: [
                      Color(0XFFE33342),
                      Color(0XFFB61267),
                    ],
                  ),
                  Text(
                    "${data.active_player} active players",
                    style: ResponsiveTextStyle.regular(context),
                  ),
                  // SizedBox(
                  //   height: 0.01 * height,
                  // ),
                  // Spacer()
                ],
              ),
              SizedBox(
                width: 0.02 * width,
              )
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: GradientBoxBorder(
                  width: 1,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 94, 95, 112),
                      Color.fromARGB(0, 0, 0, 0),
                      // Color.fromARGB(255, 30, 32, 51)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  )),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 30, 32, 51),
                  Color.fromARGB(0, 30, 32, 51),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
        ),
        SizedBox(
          height: 0.015 * height,
        ),
      ],
    ),
  );
}
