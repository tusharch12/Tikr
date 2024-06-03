import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";
import "package:gradient_borders/box_borders/gradient_box_border.dart";
import "package:tikr/Page/Setting%20Page/contactus.dart";
import "package:tikr/widget/button.dart";
import "package:tikr/widget/textstyle.dart";

import "package:zoom_tap_animation/zoom_tap_animation.dart";
import 'package:http/http.dart' as http;


import "../../widget/CustomNotification.dart";
import "confirm.dart";

Future withdraw_req(token, data) async {
  const String withDrawReqUrl = "http://34.204.28.184:8000/withdraw_gc_request";
  var client = http.Client();
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY4MDQzNzE5OX0.Lof3zjEFXPKEJ7_55qVJmtBcnJ4COYVTJy3Vcaro8F0";

  var map = Map<String, dynamic>();
  var map1 = Map<String, dynamic>();
  map["amount_request"] = data.price;
  map["entity"] = data.company;
  map["remark"] = data.title;

  var res = await client.post(Uri.parse(withDrawReqUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);
  map1["body"] = jsonDecode(res.body);
  map1["statusCode"] = res.statusCode;
  return map1;
}

class WithdrawReq extends StatefulWidget {
  WithdrawReq(
      {super.key,
      required this.data,
      required this.response,
      required this.token});
  var data;
  var response;
  String token;
  @override
  State<WithdrawReq> createState() => _WithdrawReqState();
}

class _WithdrawReqState extends State<WithdrawReq> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 17, 19, 31),
      body: SafeArea(
          minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            'assests/Arrow.svg',
                            height: 0.041 * h,
                            width: 0.041 * w,
                          )),
                    ),
                    Center(
                        child: Text(
                      "Withdraw Request",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 220, 221, 233),
                        fontSize: 0.043 * w,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 0.04 * h,
                      ),
                      Text(
                        "Confirm Your Contact Details",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Color.fromARGB(255, 220, 221, 233),
                          fontSize: 0.055 * w,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 0.02 * h,
                      ),
                      Text(
                        "It’s important to enter correct profile details for the delivery of the gift card. Tikr99 will NOT be responsible if gift card is delivered to the wrong/NA address!",
                        // textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          fontSize: 0.041 * w,
                          color: Color.fromARGB(255, 122, 124, 143),
                        ),
                      ),
                      SizedBox(
                        height: 0.03 * h,
                      ),
                      Text('Name', style: ResponsiveTextStyle.get(context)),
                      Text(widget.response["data"]["data"]["name"],
                          style: ResponsiveTextStyle.headline1(context)),
                      SizedBox(
                        height: 0.02 * h,
                      ),
                      Text('Email', style: ResponsiveTextStyle.get(context)),
                      Text(widget.response["data"]["data"]["email"],
                          style: ResponsiveTextStyle.headline1(context)),
                      SizedBox(
                        height: 0.02 * h,
                      ),
                      Text('Date of Birth',
                          style: ResponsiveTextStyle.get(context)),
                      Text(widget.response["data"]["data"]["birthday"],
                          style: ResponsiveTextStyle.headline1(context)),
                      SizedBox(
                        height: 0.02 * h,
                      ),
                      Text('State', style: ResponsiveTextStyle.get(context)),
                      Text(widget.response["data"]["data"]["state"],
                          style: ResponsiveTextStyle.headline1(context)),
                      SizedBox(
                        height: 0.02 * h,
                      ),
                      Spacer(),
                      ZoomTapAnimation(
                          onTap: () async {
                            var response =
                                await withdraw_req(widget.token, widget.data);
                            if (response["statusCode"] == 200) {
                              Get.to(
                                  () => confirm(
                                        token: widget.token,
                                      ),
                                  transition: Transition.noTransition);
                            } else {
                              CustomMessageDisplay customMessageDisplay =
                                  CustomMessageDisplay(context);
                              customMessageDisplay
                                  .showMessage(response["body"]["msg"]);
                            }
                          },
                          child: Button(title: "Confirm")),
                      SizedBox(height: 0.03 * h),
                    ],
                  ),
                ),
              ))
            ],
          )),
    );
  }
}
