import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:http/http.dart' as http;

import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/textstyle.dart';
import '../../widget/signUpButton.dart';
import 'coupun.dart';

Future withdrawStatus(String token) async {
  const String getcoupon = "http://34.204.28.184:8000/get_withdraw_requests";
  var client = http.Client();

  try {
    var res = await client.post(
      Uri.parse(getcoupon),
      headers: {
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 30));

    print(res.body);
    return jsonDecode(res.body);
  } on TimeoutException catch (_) {
    print('Request timeout');
    // You can return an error object or throw an exception here
    return {
      'auth': true,
      'error': 'Request timed out. Please check your internet connection!'
    };
  } catch (e) {
    print('Error: $e');
    // You can return an error object or throw an exception here
    return {
      'auth': true,
      'error': 'An error occurred, contact the support team!'
    };
  } finally {
    client.close();
  }
}

class withdrawl_Req extends StatefulWidget {
  withdrawl_Req({super.key, required this.token});

  String token;
  @override
  State<withdrawl_Req> createState() => _withdrawl_ReqState();
}

class _withdrawl_ReqState extends State<withdrawl_Req> {
  // String ?link;
  @override
  Widget build(BuildContext context) {
    // String link1 = res["body"]["data"]["Link"];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 17, 19, 31),
      body: SafeArea(
          minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
          child: Column(
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
                        'Withdrawal Requests',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 220, 221, 233),
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.04 * h,
              ),
              Flexible(
                child: FutureBuilder(
                    future: withdrawStatus(widget.token),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var body = snapshot.data;
                        if (body.containsKey('error')) {
                          return Center(
                              child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                            child: Center(
                              child: Text(
                                body['error'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 0.045 * w,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                              ),
                            ),
                          ));
                        }
                        if (body["data"].isEmpty) {
                          return Center(
                            child: Text(
                              "No withdrawal request found",
                              style: TextStyle(
                                  fontSize: 0.045 * w,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          );
                        } else {
                          List<dynamic> giftCard = body["data"];
                          return SingleChildScrollView(
                            child: Column(
                                children: giftCard
                                    .map((data) => withdrawal_page(
                                        context, data, widget.token))
                                    .toList()),
                          );
                        }
                      } else {
                        return Center(
                            child: SpinKitThreeBounce(
                          size: 40,
                          color: Colors.white,
                        ));
                        // button_navigator(token
                      }
                    }),
              ),
              // Spacer(),
            ],
          )),
    );
  }
}

Widget withdrawal_page(context, data, token) {
  double time = double.parse(data["datetime_request"]);
  print(time);
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch((time * 1000).toInt());
  String formattedDate = DateFormat('HH:mm a , dd MMMM yyyy').format(dateTime);
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  return FittedBox(
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
                  Color.fromARGB(255, 64, 53, 45),
                  Color.fromARGB(0, 30, 32, 51),
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
              Image.asset(
                'assests/diamond1.png',
                height: 0.05 * h,
              ),
              SizedBox(
                width: 0.03 * w,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data["entity"],
                        style: ResponsiveTextStyle.get(context)),
                    // SizedBox(width: 0.05*w,),
                    // Container(
                    //   height: 0.04 * h,
                    //   width: 0.04 * w,
                    //   decoration: BoxDecoration(
                    //       color: boo ? Colors.green : Colors.red,
                    //       shape: BoxShape.circle),
                    // ),
                    GradientText(
                      "\u{20B9} ${data["amount_request"]}",
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
                      data["remark"],
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
                        Text(data["rewarded"],
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
  );
}
