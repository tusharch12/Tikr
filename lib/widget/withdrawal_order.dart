// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gradient_borders/box_borders/gradient_box_border.dart';
// import 'package:intl/intl.dart';
// import 'package:simple_gradient_text/simple_gradient_text.dart';
// import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// import '../Modals/orders/orders_modal.dart';
// import '../page/Order page/orderDetail_page.dart';
// import '../textstyle.dart';

// Widget withdrawal_page(context) {
//   double w = MediaQuery.of(context).size.width;
//   double h = MediaQuery.of(context).size.height;
//   return FittedBox(
//     child: Column(
//       children: [
//         Container(
//           padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
//           // height: 0.12 * h,
//           width: 0.9 * w,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: GradientBoxBorder(
//                   width: 1,
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 92, 90, 122),
//                       Color.fromARGB(0, 0, 0, 0),
//                       // Color.fromARGB(255, 30, 32, 51)
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomCenter,
//                   )),
//               gradient: LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 64, 53, 45),
//                   Color.fromARGB(0, 30, 32, 51),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               )),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 0.03 * w,
//               ),
//               SvgPicture.asset(
//                 'assests/withdrawal.svg',
//                 height: 0.05 * h,
//               ),
//               SizedBox(
//                 width: 0.03 * w,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
                  
//                         Text(data.StockName,
//                             style: ResponsiveTextStyle.get(context)),
//                         // SizedBox(width: 0.05*w,),
//                         Container(
//                           height: 0.04 * h,
//                           width: 0.04 * w,
//                           decoration: BoxDecoration(
//                               color: boo ? Colors.green : Colors.red,
//                               shape: BoxShape.circle),
//                         ),
//                   GradientText(
//                     isbalanceUpdate ? "\u{20B9} ${data.winning_amount}" : "-",
//                     style: TextStyle(
//                       fontSize: 0.032 * w,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.bold,
//                     ),
//                     colors: [
//                       Color.fromARGB(255, 100, 180, 103),
//                       Color.fromARGB(255, 152, 218, 190),
//                     ],
//                   ),
//                   Text(
//                     data.pool_name,
//                     style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Color(0XFFDCDDE9),
//                         fontSize: 0.03 * w,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Container(
//                     width: 0.69 * w,
//                     height: 0.03 * h,
//                     // color: Colors.amber,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Invested : ${data.amount} ",
//                             style: ResponsiveTextStyle.regular(context)),
//                         Text(formattedDate,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w300,
//                               fontFamily: 'Poppins',
//                               fontSize: 0.025 * w,
//                               color: Color(0XFFDCDDE9),
//                             ))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 0.015 * h,
//         ),
//       ],
//     ),
//   );
// }
