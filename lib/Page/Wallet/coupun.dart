import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tikr/Page/Wallet/withdrawRequest_Page.dart';
import 'package:tikr/page/signIn.dart';
import 'package:tikr/widget/signUpButton.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:tikr/widget/Images.dart';
import '../../provider/pool_provider.dart';
import '../../widget/CustomNotification.dart';

Future coupunapicall(token) async {
  const String getcoupon = "http://34.204.28.184:8000/get_giftcards";
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

// Hey ----------<  raj >--------- add all this comment
Future co(token) async {
  const String getProfile = "http://34.204.28.184:8000/getprofile";
  var client = http.Client();
  var map = Map<String, dynamic>();

  try {
    var res = await client.post(
      Uri.parse(getProfile),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(res.body);
    map["body"] = jsonDecode(res.body);
    map["statusCode"] = res.statusCode;

    return map;
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

class coupons extends StatefulWidget {
  coupons({super.key, required this.token});
  String token;
  @override
  State<coupons> createState() => _couponsState();
}

class _couponsState extends State<coupons> {
  void initState() {
    coupunapicall(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 17, 19, 31),
        body: SafeArea(
            minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return ConstrainedBox(
                  constraints: constraints.copyWith(
                    minHeight: constraints.maxHeight,
                  ),
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
                                    // httpRequest().getWallet();
                                    HapticFeedback.lightImpact();
                                    Get.back();
                                  },
                                  child: SvgPicture.asset(
                                    Images.back,
                                    height: 0.041 * h,
                                    width: 0.041 * w,
                                  ),
                                )),

                            Center(
                              child: Text(
                                'Cash Rewards',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 220, 221, 233),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.043,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            // ),
                          ],
                        )),
                    Expanded(
                      child: Container(
                        child: FutureBuilder(
                            future: coupunapicall(widget.token),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                var body = snapshot.data;
                                if (body.containsKey('error')) {
                                  return Center(
                                      child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.046 * w, 0, 0.046 * w, 0),
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
                                if (body["auth"] == false) {
                                  return SignUpButton(w, h);
                                } else {
                                  // print(body.runtimeType);
                                  List<rewards> giftCard = [];
                                  // List<dynamic> sortList = [];
                                  List<dynamic> list = body["data"];

                                  for (var item in list) {
                                    for (var price in item["price"]) {
                                      giftCard.add(rewards(
                                        image: item['image'],
                                        company: item['company'],
                                        title: item['title'],
                                        category: item["category"],
                                        price: price.toString(),
                                      ));
                                    }
                                  }
                                  giftCard.sort((a, b) => double.parse(a.price)
                                      .compareTo(double.parse(b.price)));
                                  // giftCard.sort(
                                  //     (a, b) => a.price.compareTo(b.price));

                                  return SingleChildScrollView(
                                    child: GridView(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          // mainAxisSpacing: 0.0003 *
                                          //     h, // Adjust this value to change the vertical gap
                                          // crossAxisSpacing: 0.01 *
                                          //     w, // Adjust this value to change the horizontal gap
                                          // // childAspectRatio: 0.2 * w / (0.12 * h),
                                        ),
                                        children: giftCard
                                            .map((rewards data) => hatcheck(
                                                context, data, widget.token))
                                            .toList()),
                                  );
                                }
                              } else {
                                return loader(context, w, h);
                              }
                            }),
                      ),
                    ),
                  ]));
            })));
  }
}

Widget hatcheck(BuildContext context, rewards data, token) {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  var image = base64.decode(data.image);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0.04 * w),
    child: ZoomTapAnimation(
      onTap: () async {
        var response = await co(token);
        if (response["statusCode"] == 201) {
          print(response["body"]);
          Get.to(
              () => WithdrawReq(
                    data: data,
                    response: response["body"],
                    token: token,
                  ),
              transition: Transition.noTransition);
        } else {
          CustomMessageDisplay customMessageDisplay =
              CustomMessageDisplay(context);
          customMessageDisplay.showMessage("Error");
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 0.02 * h,
          ),
          IntrinsicHeight(
            child: Container(
              width: 0.5 * w,
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
                      Color.fromARGB(255, 50, 40, 25),
                      Color.fromARGB(0, 30, 32, 51),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 0.01 * h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Container(
                      height: 0.06 * h,
                      width: 0.13 * w,
                      child: Image.memory(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  GradientText(
                    'Rs. ' + data.price.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 0.05 * w,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                    colors: [
                      const Color.fromARGB(255, 100, 180, 103),
                      const Color.fromARGB(255, 152, 218, 198)
                    ],
                  ),
                  Container(
                    child: Text(
                      data.company,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 0.03 * w,
                        color: Color(0XFFDCDDE9),
                      ),
                    ),
                  ),
                  Text(data.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Color(0XFFDCDDE9))),
                  SizedBox(
                    height: 0.01 * h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class rewards {
  final String image;
  final String company;
  final String title;
  final String category;
  final String price;

  rewards(
      {required this.image,
      required this.company,
      required this.title,
      required this.category,
      required this.price
      // required this.Answer5,
      });
  factory rewards.fromjson(Map<String, dynamic> json) {
    return rewards(
        image: json["image"],
        company: json["company"],
        title: json["title"],
        category: json["category"],
        price: json["price"]);
  }
}
