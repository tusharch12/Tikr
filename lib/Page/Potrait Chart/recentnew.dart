import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:tikr/Modals/orders/orders_modal.dart';
import 'package:tikr/page/signIn.dart';
import 'package:tikr/widget/orderPage_con.dart';
import 'package:http/http.dart' as http;
import 'package:tikr/widget/signUpButton.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../provider/recentOrder.dart';
import '../../Modals/SettingPage_modal.dart';
import '../../provider/recent_order1.dart';
import '../Order page/order_Page.dart';
import '../Setting Page/Setting_page.dart';

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

class recentNew extends StatefulWidget {
  recentNew({
    super.key,
    required this.token,
  });

  String token;
  // String passdate;
  // List<orderResposne> POR;
  var data;
  @override
  State<recentNew> createState() => _recentNewState();
}

class _recentNewState extends State<recentNew> {
  double listH = 0.8;
  @override
  void initState() {
    final provider = Provider.of<recentOrderPro>(context, listen: false);
    provider.call(widget.token);
    // final provider = Provider.of<recentOrderPro>(context, listen: false).loader;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  final provider = Provider.of<recentOrderPro>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(0, 0.07 * height, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 0.041 * height,
            child: Stack(children: [
              Positioned(
                left: 0.046 * width,
                child: ZoomTapAnimation(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      'assests/Arrow.svg',
                      height: 0.041 * height,
                      width: 0.041 * width,
                    )),
              ),
              Center(
                child: Text(
                  'Recent Trades',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 220, 221, 233),
                    fontSize: 0.043 * width,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 0.03 * height,
          ),
          Flexible(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 0.046 * width),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return listw(
                    height,
                    width,
                    listH
                  );
                }),
          )
        ]
            //
            ),
        // button_navigator(token: widget.token)
        // ],
      ),
    );
    // );
  }
}

// Column(children: [
//                         Consumer<recentOrderPro>(
//                             builder: (context, value, child) {
//                           return ConstrainedBox(
//                             constraints:
//                                 BoxConstraints(minHeight: 0.7 * height),
//                             child: Container(
//                                 width: 0.9 * width,
//                                 child: value.loader
//                                     ? value.auth
//                                         ? value.mainList.isNotEmpty
//                                             ? Column(
//                                                 children:value.mainList
//                                                     .map((order data) =>
//                                                         Past_order1(
//                                                             context, data))
//                                                     .toList(),
//                                               )
//                                             : Center(
//                                                 child: Text(
//                                                   "No trades found",
//                                                   style: TextStyle(
//                                                       fontSize: 0.045 * width,
//                                                       fontFamily: 'Poppins',
//                                                       fontWeight:
//                                                           FontWeight.w200,
//                                                       color: Colors.white),
//                                                 ),
//                                               )
//                                         : SignUpButton(width, height)
//                                     : loader(context, width, height)),
//                           );
//                         }),
//                       ])
