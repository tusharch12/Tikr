import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:tikr/widget/Images.dart';
import 'package:http/http.dart' as http;
import 'package:tikr/widget/textstyle.dart';
import '../../widget/CustomNotification.dart';
import 'Recharge_Request.dart';

Future AddbalanceCall(token, method) async {
  const String addCoinUrl = "http://34.204.28.184:8000/add_balance_request";
  var client = http.Client();
  var map = Map<String, dynamic>();
  var map1 = Map<String, dynamic>();
  map["method"] = method;
  var res = await client.post(Uri.parse(addCoinUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);
  print(res.body);
  map1["body"] = jsonDecode(res.body);
  map1["statusCode"] = res.statusCode;
  return map1;
  // return jsonDecode(res.body);
}

class addnew extends StatefulWidget {
  addnew({Key? key, required this.token}) : super(key: key);
  String token;
  @override
  State<addnew> createState() => _addnewState();
}

class _addnewState extends State<addnew> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 17, 19, 31),
        body: SafeArea(
            minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
            child: Column(children: [
              Container(
                height: 0.041 * h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0.046 * w,
                      child: ZoomTapAnimation(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            Images.back,
                            height: 0.041 * h,
                            width: 0.041 * w,
                          )),
                    ),
                    Center(
                        child: Text(
                      "Add Money",
                      textAlign: TextAlign.center,
                      style: ResponsiveTextStyle.header(context),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 0.03 * h,
              ),
              ZoomTapAnimation(
                onTap: () async {
                  var response =
                      await AddbalanceCall(widget.token, "onlinepayment");
                  Get.to(
                      () => rechargeReq(
                          link: response["body"]["data"]["Link"],
                          res: response),
                      transition: Transition.noTransition);
                },
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
                    height: 0.12 * h,
                    width: 0.9 * w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: GradientBoxBorder(
                            width: 0.7,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 137, 137, 137),
                                Color.fromARGB(0, 0, 0, 0),
                                // Color.fromARGB(255, 30, 32, 51)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            )),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 27, 53, 33),
                            Color.fromARGB(255, 30, 32, 51),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 0.02 * h),
                        SvgPicture.asset(Images.online_transfer,
                            height: 0.05 * h),
                        SizedBox(
                          width: 0.02 * h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Online Transfer',
                                style: ResponsiveTextStyle.get(context)),
                            Container(
                              width: 0.6 * w,
                              child: Wrap(children: [
                                Text(
                                    'Use your credit/debit card, mobile wallets, online banking etc',
                                    // softWrap: true,
                                    style:
                                        ResponsiveTextStyle.regular(context)),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              ZoomTapAnimation(
                onTap: () async {
                  var response = await AddbalanceCall(widget.token, "telegram");
                  // if (response["statusCode"] == 200) {
                  Get.to(
                      () => rechargeReq(
                          link: response["body"]["data"]["Link"],
                          res: response),
                      transition: Transition.noTransition);
                },
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
                    height: 0.12 * h,
                    width: 0.9 * w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: GradientBoxBorder(
                            width: 0.7,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 137, 137, 137),
                                Color.fromARGB(0, 0, 0, 0),
                                // Color.fromARGB(255, 30, 32, 51)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            )),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 27, 53, 33),
                            Color.fromARGB(255, 30, 32, 51),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 0.02 * h),
                        SvgPicture.asset(Images.telegram, height: 0.05 * h),
                        SizedBox(
                          width: 0.02 * h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Telegram',
                                style: ResponsiveTextStyle.get(context)),
                            Container(
                              width: 0.6 * w,
                              child: Wrap(children: [
                                Text(
                                    'Send a Query to our Official Telegram ID to add funds',
                                    style:
                                        ResponsiveTextStyle.regular(context)),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              ZoomTapAnimation(
                onTap: () async {
                  var response = await AddbalanceCall(widget.token, "whatsapp");
                  print("tushar");
                  Get.to(
                      () => rechargeReq(
                          link: response["body"]["data"]["Link"],
                          res: response),
                      transition: Transition.noTransition);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
                  height: 0.12 * h,
                  width: 0.9 * w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          width: 0.7,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 137, 137, 137),
                              Color.fromARGB(0, 0, 0, 0),
                              // Color.fromARGB(255, 30, 32, 51)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                          )),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 27, 53, 33),
                          Color.fromARGB(255, 30, 32, 51),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 0.02 * h),
                      SvgPicture.asset(Images.whatsapp, height: 0.05 * h),
                      SizedBox(
                        width: 0.02 * h,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('WhatsApp',
                                style: ResponsiveTextStyle.get(context)),
                            Container(
                              width: 0.6 * w,
                              child: Wrap(children: [
                                Text(
                                    'Send a Query to our Official WhatsApp ID to add funds',
                                    style:
                                        ResponsiveTextStyle.regular(context)),
                              ]),
                            )
                          ]),
                    ],
                  ),
                ),
              )
            ])));
  }
}
