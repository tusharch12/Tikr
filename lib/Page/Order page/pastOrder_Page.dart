// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:tikr/widget/orderPage_con.dart';
// import 'package:http/http.dart' as http;
// import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// import '../../Modals/orders/orders_modal.dart';

// Future PastOrderCall(token, date) async {
//   final String getProfileBalanceURL =
//       "http://34.204.28.184:8000/get_past_trades";
//   var client = http.Client();
//   // String token =
//   //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY4MDQzNzE5OX0.Lof3zjEFXPKEJ7_55qVJmtBcnJ4COYVTJy3Vcaro8F0";
//   var map = Map<String, dynamic>();
//   // print(pool_name);
//   // print(pool_name[0] + pool_name[1]);
//   map["req_date"] = date;
//   var res = await client.post(Uri.parse(getProfileBalanceURL),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//       body: map);
//   print("Search");
//   print(res.body);
//   return res.body;
// }

// class PastOrderPage extends StatefulWidget {
//   PastOrderPage(
//       {super.key,
//       required this.token,
//       // required this.POR,
//       // required this.data,
//       required this.passdate});
//   String token;
//   String passdate;
//   // List<orderResposne> POR;
//   var data;
//   @override
//   State<PastOrderPage> createState() => _PastOrderPageState();
// }

// class _PastOrderPageState extends State<PastOrderPage> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 17, 19, 31),
//       body: SafeArea(
//         minimum: EdgeInsets.fromLTRB(0, 0.07 * height, 0, 0),
//         child: Column(
//           children: [
//             Container(
//               height: 0.041 * height,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Positioned(
//                     left: 0.046 * width,
//                     child: ZoomTapAnimation(
//                         onTap: () {
//                           HapticFeedback.lightImpact();
//                           Get.back();
//                         },
//                         child: SvgPicture.asset(
//                           'assests/Arrow.svg',
//                           height: 0.041 * height,
//                           width: 0.041 * width,
//                         )),
//                   ),
//                   // SizedBox(
//                   //   width: 0.3 * width,
//                   // ),
//                   Center(
//                       child: Text(
//                     'Orders',
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 220, 221, 233),
//                       fontSize: 0.043 * width,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w600,
//                     ),
//                   )),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 0.08 * width,
//             ),
//             Flexible(
//                 child: FutureBuilder(
//                     future: PastOrderCall(widget.token, widget.passdate),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         var data = jsonDecode(snapshot.data);

//                         if (data["msg"] == "No Data Found") {
//                           return Center(
//                             child: Text(
//                               "No Trades Found!",
//                               style: TextStyle(
//                                   fontSize: 0.045 * width,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white),
//                             ),
//                           );
//                         } else {
//                           List<dynamic> data1 = data["data"];
//                           List<order> POR = data1
//                               .map((e) => order.fromjson(e))
//                               .toList();
//                           return Padding(
//                             padding: EdgeInsets.fromLTRB(
//                                 0.046 * width, 0, 0.046 * width, 0),
//                             child: ListView(
//                               children: POR
//                                   .map((order data) =>
//                                       Past_order(context, data))
//                                   .toList(),
//                             ),
//                           );
//                         }
//                       } else {
//                         return Center(
//                             child: SpinKitThreeBounce(
//                           size: 40,
//                           color: Colors.white,
//                         ));
//                       }
//                     })
//                 //
//                 ),
//             // button_navigator(token: widget.token)
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tikr/widget/orderPage_con.dart';
import 'package:http/http.dart' as http;
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../Modals/orders/orders_modal.dart';

Future PastOrderCall(token, date) async {
  final String getProfileBalanceURL =
      "http://34.204.28.184:8000/get_past_trades";
  var client = http.Client();
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY4MDQzNzE5OX0.Lof3zjEFXPKEJ7_55qVJmtBcnJ4COYVTJy3Vcaro8F0";
  var map = Map<String, dynamic>();
  // print(pool_name);
  // print(pool_name[0] + pool_name[1]);
  map["req_date"] = date;
  var res = await client.post(Uri.parse(getProfileBalanceURL),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);
  print("Search");
  print(res.body);
  return res.body;
}

class PastOrderPage extends StatefulWidget {
  PastOrderPage(
      {super.key,
      required this.token,
      // required this.POR,
      // required this.data,
      required this.passdate});
  String token;
  String passdate;
  // List<orderResposne> POR;
  var data;
  @override
  State<PastOrderPage> createState() => _PastOrderPageState();
}

class _PastOrderPageState extends State<PastOrderPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(0, 0.07 * height, 0, 0),
        child: Column(
          children: [
            Container(
              height: 0.041 * height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0.046 * width,
                    child: ZoomTapAnimation(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          'assests/Arrow.svg',
                          height: 0.041 * height,
                          width: 0.041 * width,
                        )),
                  ),
                  // SizedBox(
                  //   width: 0.3 * width,
                  // ),
                  Center(
                      child: Text(
                    'Orders',
                    style: TextStyle(
                      color: Color.fromARGB(255, 220, 221, 233),
                      fontSize: 0.043 * width,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 0.08 * width,
            ),
            Flexible(
                child: FutureBuilder(
                    future: PastOrderCall(widget.token, widget.passdate),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = jsonDecode(snapshot.data);

                        if (data["msg"] == "No Data Found") {
                          return Center(
                            child: Text(
                              "No trade found",
                              style: TextStyle(
                                  fontSize: 0.045 * width,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          );
                        } else {
                          List<dynamic> data1 = data["data"];
                          List<order> POR =
                              data1.map((e) => order.fromjson(e)).toList();
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                                0.046 * width, 0, 0.046 * width, 0),
                            child: ListView(
                              children: POR
                                  .map(
                                      (order data) => Past_order(context, data))
                                  .toList(),
                            ),
                          );
                        }
                      } else {
                        return Center(
                            child: SpinKitThreeBounce(
                          size: 40,
                          color: Colors.white,
                        ));
                      }
                    })
                //
                ),
            // button_navigator(token: widget.token)
          ],
        ),
      ),
    );
  }
}
