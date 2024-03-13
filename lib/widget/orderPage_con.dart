import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../Modals/orders/orders_modal.dart';
import '../page/Order page/orderDetail_page.dart';
import '../textstyle.dart';

Widget Past_order(context, order data) {
  bool isWin = true;
  bool isbalanceUpdate = true;
  double time = double.parse(data.datetime);
  print(time);
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch((time * 1000).toInt());
  String formattedDate = DateFormat('HH:mm a , dd MMMM yyyy').format(dateTime);
  // String formattedTime = DateFormat('').format(dateTime);
  print(dateTime);
  if (data.balance_updated == "N") {
    isbalanceUpdate = false;
  }
  if (data.Play_direction == "RED") {
    isWin = false;
  }
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  return ZoomTapAnimation(
    onTap: () {
      HapticFeedback.lightImpact();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => orderDetail(data: data)));
    },
    child: FittedBox(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
            // height: 0.12 * h,
            width: 0.9 * w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: GradientBoxBorder(
                    width: 1,
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 92, 90, 122),
                        Color.fromARGB(0, 0, 0, 0),
                        // Color.fromARGB(255, 30, 32, 51)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                    )),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 45, 54, 46),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: 0.020 * h,
                      width: 0.19 * w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(10)),
                          color: isbalanceUpdate
                              ? data.winning_amount == 0
                                  ? //255, 227, 51, 66

                                  Colors.black
                                  : Colors.green
                              : Color.fromARGB(255, 142, 144, 0)),
                      child: Center(
                        child: isbalanceUpdate
                            ? Text(
                                data.winning_amount != 0 ? "You Won!" : "Lost!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 0.025 * w,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "Waiting",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 0.025 * w,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 0.018 * h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 0.03 * w,
                        ),
                        SvgPicture.asset(
                          'assests/orders.svg',
                          height: 0.055 * h,
                        ),
                        SizedBox(
                          width: 0.03 * w,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 0.02 * w,
                ),

                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.StockName,
                              style: ResponsiveTextStyle.get(context)),
                        ],
                      ),
                      GradientText(
                        isbalanceUpdate
                            ? "\u{20B9} ${data.winning_amount}"
                            : "-",
                        style: TextStyle(
                          fontSize: 0.036 * w,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                        colors: data.winning_amount == 0
                            ? [
                                Color.fromARGB(255, 226, 75, 75),
                                Color.fromARGB(255, 240, 110, 110),
                              ]
                            : [
                                Color.fromARGB(255, 100, 180, 103),
                                Color.fromARGB(255, 152, 218, 190),
                              ],
                      ),
                      Text(
                        data.pool_name,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0XFFDCDDE9),
                            fontSize: 0.035 * w,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Invested : ${data.amount} ",
                              style: ResponsiveTextStyle.regular(context)),
                          Text(formattedDate,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppins',
                                fontSize: 0.028 * w,
                                color: Color(0XFFDCDDE9),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 0.02 * w,
                ),
                Container(
                    height: 0.12 * h,
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: isWin
                          ? Color.fromARGB(255, 36, 201, 171) //255, 227, 51, 66
                          : Color.fromARGB(255, 227, 51, 66),
                    )),
                // SizedBox(
                //   width: 0.02 * w,
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 0.015 * h,
          ),
        ],
      ),
    ),
  );
}

Widget Past_order1(context, order data) {
  bool boo = true;
  bool isbalanceUpdate = true;
  double time = double.parse(data.play_time);
  print(time);
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch((time * 1000).toInt());
  String formattedDate = DateFormat('HH:mm a , dd MMMM yyyy').format(dateTime);
  // String formattedTime = DateFormat('').format(dateTime);
  print(dateTime);
  if (data.balance_updated == "N") {
    isbalanceUpdate = false;
  }
  if (data.Play_direction == "RED") {
    boo = false;
  }
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  return ZoomTapAnimation(
    onTap: () {
      HapticFeedback.lightImpact();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => orderDetail(data: data)));
    },
    child: FittedBox(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
            // height: 0.12 * h,
            width: 0.9 * w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: GradientBoxBorder(
                    width: 1,
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 92, 90, 122),
                        Color.fromARGB(0, 0, 0, 0),
                        // Color.fromARGB(255, 30, 32, 51)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                    )),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 45, 54, 46),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 0.03 * w,
                ),
                SvgPicture.asset(
                  'assests/orders.svg',
                  height: 0.05 * h,
                ),
                SizedBox(
                  width: 0.03 * w,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.StockName,
                              style: ResponsiveTextStyle.get(context)),
                          Container(
                            height: 0.04 * h,
                            width: 0.04 * w,
                            decoration: BoxDecoration(
                              color: boo ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      GradientText(
                        isbalanceUpdate
                            ? "\u{20B9} ${data.winning_amount}"
                            : "-",
                        style: TextStyle(
                          fontSize: 0.032 * w,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          Color.fromARGB(255, 100, 180, 103),
                          Color.fromARGB(255, 152, 218, 190),
                        ],
                      ),
                      Text(
                        data.pool_name,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0XFFDCDDE9),
                            fontSize: 0.03 * w,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Invested : ${data.amount} ",
                              style: ResponsiveTextStyle.regular(context)),
                          Text(formattedDate,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppins',
                                fontSize: 0.025 * w,
                                color: Color(0XFFDCDDE9),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 0.02 * w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.015 * h,
          ),
        ],
      ),
    ),
  );
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gradient_borders/box_borders/gradient_box_border.dart';
// import 'package:intl/intl.dart';
// import 'package:simple_gradient_text/simple_gradient_text.dart';
// import 'package:tikr/practise/Public_pool.dart';
// import 'package:tikr/practise/order_res.dart';

// Widget Past_order(context, orderResposne data) {
//   bool boo = true;
//   bool isbalanceUpdate = true;
//   double time = double.parse(data.play_time);
//   print(time);
//   DateTime dateTime =
//       DateTime.fromMillisecondsSinceEpoch((time * 1000).toInt());
//   String formattedDate = DateFormat('HH:mm a , dd MMMM yyyy').format(dateTime);
//   // String formattedTime = DateFormat('').format(dateTime);
//   print(dateTime);
//   if (data.balance_update == "Y") {
//     isbalanceUpdate = false;
//   }
//   if (data.Play_direction == "RED") {
//     boo = false;
//   }
//   double w = MediaQuery.of(context).size.width;
//   double h = MediaQuery.of(context).size.height;
//   return Container(
//     margin: EdgeInsets.only(top: 10),
//     padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
//     height: 0.14 * h,
//     width: 0.9 * w,
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: GradientBoxBorder(
//             width: 0.7,
//             gradient: LinearGradient(
//               colors: [
//                Color.fromARGB(255, 45, 54, 46),
//                 Color.fromARGB(0, 0, 0, 0),
//                 // Color.fromARGB(255, 30, 32, 51)
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomCenter,
//             )),
//         gradient: LinearGradient(
//           colors: [
//              Color.fromARGB(255, 45, 54, 46),
//            Color.fromARGB(0, 0, 0, 0),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         )),
//     child: Row(
// crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//        SizedBox(
//           width: 0.03 * w,
//         ),
//        SvgPicture.asset('assests/orders.svg'),
//         SizedBox(
//           width: 0.03 * w,
//         ), // Image.asset("assests/adiPic.png"),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//            Spacer(),
//             Text(
//               data.StockName,
//               style: TextStyle(
//                   fontFamily: 'Poppins',
//                   color: Color(0XFFDCDDE9),
//                   fontSize: 0.045* w,
//                   fontWeight: FontWeight.bold),
//             ),
//             GradientText(
//               isbalanceUpdate ? "\u{20B9} ${data.winning_amount}" : "-",
//               style: TextStyle(
//                  fontSize: 0.04* w,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w700,
//               ),
//               colors: [
//                 Color.fromARGB(255, 100, 180, 103),
//                 Color.fromARGB(255, 152, 218, 190),
//               ],
//             ),
//             Text(
//               data.pool_name,
//               style: TextStyle(
//                   fontFamily: 'Poppins',
//                   color: Color(0XFFDCDDE9),
//                   fontSize: 0.035 * w,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "Invested : ${data.amount} ",
//               style: TextStyle(
//                 fontWeight: FontWeight.w300,
//                 fontFamily: 'Poppins',
//                 fontSize: 0.035 * w,
//                 color: Color(0XFFDCDDE9),
//               ),
//             ),
//              Spacer(),
//           ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [

//             Container(
//               height: 0.05 * h,
//               width: 0.05 * w,
//               decoration: BoxDecoration(
//                   color: boo ? Colors.green : Colors.red,
//                   shape: BoxShape.circle),
//             ),
//             Spacer(),
//             Text(formattedDate,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w200,
//                   fontFamily: 'Poppins',
//                   fontSize: 0.025 * w,
//                   color: Color(0XFFDCDDE9),
//                 )),

//           ],
//         ),
//       Spacer(),
//       ],
//     ),
//   );
// }
