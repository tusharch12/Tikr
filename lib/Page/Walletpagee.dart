import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:tikr/page/signIn.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class httpRequest {
  final String getProfileBalanceURL =
      "http://34.204.28.184:8000/get_profile_balance";
  var client = http.Client();
  // String token =
  //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxOTAwMTEyMDQ2NSIsImV4cCI6MTY3MTYzOTY3M30.tFxyvwO3eZY94bn72nwGN8D1Z7M_giRiBgh9bS6jhFc';
  Future<wallet> getWallet(String token) async {
    // var data;
    var res = await client.post(
      Uri.parse(getProfileBalanceURL),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(res.body);
    return wallet.fromJson(jsonDecode(res.body));
  }
}

@override
void initState() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

class WalletPage extends StatefulWidget {
  WalletPage({super.key, required this.token});
  String token;
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final httpRequest httpService = httpRequest();
  @override
  void initState() {
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
            minimum: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0.02 * h, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ZoomTapAnimation(
                          onTap: () {
                            // httpRequest().getWallet();
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            'assests/Arrow.svg',
                            height: 0.04 * h,
                            width: 0.04 * w,
                          )),
                      // SizedBox(
                      //   width: 0.3 * w,
                      // ),
                      Expanded(
                          child: Center(
                        child: Text(
                          'Wallet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 220, 221, 233),
                              fontSize: 0.024 * h,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                      SizedBox(
                        height: 0.04 * h,
                        width: 0.041 * w,
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                    future: httpRequest().getWallet(widget.token),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        wallet? Wallet = snapshot.data;
                        var Total = Wallet!.data["recharge_balance"]! +
                            Wallet.data["promotional_balance"]! +
                            Wallet.data["referal_balance"]!;
                        return Column(children: [
                          Center(
                            child: Container(
                              height: 0.1 * h,
                              child: GradientText(
                                '\u{20B9} ${Total}\n',
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                                colors: [
                                  const Color.fromARGB(255, 0, 220, 207),
                                  const Color.fromARGB(255, 142, 88, 255)
                                ],
                              ),
                            ),
                          ),
                          Container(
                              child: Column(
                            children: [
                              Container(
                                width: 0.923 * w,
                                height: 0.116 * h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: const GradientBoxBorder(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Color.fromARGB(255, 92, 95, 122),
                                          Color.fromARGB(0, 0, 0, 0),
                                        ])),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 41, 39, 37),
                                          Color.fromARGB(0, 30, 32, 51)
                                        ])),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 0.05 * w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assests/wcp.svg',
                                          height: 0.05 * h,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 0.05 * w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 0.019 * h,
                                        ),
                                        /*     */ Text('Deposit',
                                            style: ResponsiveTextStyle.get(
                                                context)),
                                        Container(
                                          height: 0.041 * h,
                                          child: GradientText(
                                            '\u{20B9} ${Wallet.data["recharge_balance"]} \n ',
                                            style: TextStyle(
                                                fontSize: 0.05 * w,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'),
                                            colors: const [
                                              Color.fromARGB(
                                                  255, 100, 180, 103),
                                              Color.fromARGB(255, 122, 218, 190)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 0.203 * w,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 0.014 * h,
                                        ),
                                        Container(
                                          width: 0.287 * w,
                                          height: 0.041 * h,
                                          decoration: BoxDecoration(
                                              border: const GradientBoxBorder(
                                                  gradient:
                                                      LinearGradient(colors: [
                                                Color.fromARGB(
                                                    255, 222, 203, 195),
                                                Color.fromARGB(
                                                    0, 222, 203, 195),
                                                // Color.fromARGB(255, 30, 32, 51)
                                              ])),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 71, 99, 76),
                                                    Color.fromARGB(
                                                        100, 68, 171, 86)
                                                  ])),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Center(
                                              child: Text(
                                                'Buy Coins',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 0.04 * w,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.014 * h,
                                        ),
                                        Container(
                                          width: 0.287 * w,
                                          height: 0.041 * h,
                                          decoration: BoxDecoration(
                                              border: const GradientBoxBorder(
                                                  gradient:
                                                      LinearGradient(colors: [
                                                Color.fromARGB(
                                                    255, 222, 203, 195),
                                                Color.fromARGB(
                                                    0, 222, 203, 195),
                                                // Color.fromARGB(255, 30, 32, 51)
                                              ])),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 99, 71, 71),
                                                    Color.fromARGB(
                                                        255, 167, 70, 70)
                                                  ])),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Center(
                                              child: Text(
                                                'Sell',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 0.04 * w,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 0.025 * w,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.015 * h,
                              ),
                              Container(
                                width: 0.923 * w,
                                height: 0.119 * h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: const GradientBoxBorder(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Color.fromARGB(255, 92, 95, 122),
                                          Color.fromARGB(0, 0, 0, 0),
                                        ])),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 41, 39, 37),
                                          Color.fromARGB(0, 30, 32, 51)
                                        ])),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 0.05 * w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assests/trophy.svg',
                                          height: 0.05 * h,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 0.05 * w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 0.046 * w,
                                          height: 0.019 * h,
                                        ),
                                        /*     */ Text('Permotional',
                                            style: ResponsiveTextStyle.get(
                                                context)),
                                        Container(
                                          height: 0.041 * h,
                                          child: Container(
                                            width: 0.173 * w,
                                            child: GradientText(
                                              '\u{20B9} ${Wallet.data["promotional_balance"]} \n ',
                                              style: TextStyle(
                                                  fontSize: 0.05 * w,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins'),
                                              colors: [
                                                const Color.fromARGB(
                                                    255, 100, 180, 103),
                                                const Color.fromARGB(
                                                    255, 122, 218, 190)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 0.203 * w),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 0.287 * w,
                                          height: 0.041 * h,
                                          decoration: BoxDecoration(
                                              border: const GradientBoxBorder(
                                                  gradient:
                                                      LinearGradient(colors: [
                                                Color.fromARGB(
                                                    255, 222, 203, 195),
                                                Color.fromARGB(
                                                    0, 222, 203, 195),
                                                // Color.fromARGB(255, 30, 32, 51)
                                              ])),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 99, 98, 71),
                                                    Color.fromARGB(
                                                        255, 159, 156, 66)
                                                  ])),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Center(
                                              child: Text(
                                                'Share',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 0.04 * w,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 0.025 * w,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ))
                        ]);
                      } else {
                        return Center(
                            child: SpinKitThreeBounce(
                          size: 40,
                          color: Colors.white,
                        ));
                      }
                    }),
                SizedBox(
                  height: 0.02 * h,
                ),
                Container(
                    height: 0.072 * h,
                    width: 0.9 * w,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 0.12 * w,
                        ),
                        Text('My Transactions',
                            style: TextStyle(
                                color: Color.fromARGB(255, 220, 221, 233),
                                fontSize: 0.045 * w,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400)),
                        Spacer(),
                        SvgPicture.asset('assests/RightArrow.svg'),
                        SizedBox(
                          width: 0.08 * w,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: const GradientBoxBorder(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color.fromARGB(255, 92, 95, 122),
                              Color.fromARGB(0, 0, 0, 0),
                            ])),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 41, 39, 37),
                              Color.fromARGB(0, 30, 32, 51)
                            ]))),
                SizedBox(height: 0.02 * h),
                Container(
                    height: 0.072 * h,
                    width: 0.9 * w,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 0.12 * w,
                        ),
                        Text('Balance History',
                            style: TextStyle(
                                color: Color.fromARGB(255, 220, 221, 233),
                                fontSize: 0.045 * w,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400)),
                        Spacer(),
                        SvgPicture.asset('assests/RightArrow.svg'),
                        SizedBox(
                          width: 0.08 * w,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: const GradientBoxBorder(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color.fromARGB(255, 92, 95, 122),
                              Color.fromARGB(0, 0, 0, 0),
                            ])),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 41, 39, 37),
                              Color.fromARGB(0, 30, 32, 51)
                            ]))),
                SizedBox(
                  height: 0.02 * h,
                ),
                Container(
                    height: 0.072 * h,
                    width: 0.9 * w,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 0.12 * w,
                        ),
                        Text('Account Verification',
                            style: TextStyle(
                                color: Color.fromARGB(255, 220, 221, 233),
                                fontSize: 0.045 * w,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400)),
                        Spacer(),
                        SvgPicture.asset('assests/RightArrow.svg'),
                        SizedBox(
                          width: 0.08 * w,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: const GradientBoxBorder(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color.fromARGB(255, 92, 95, 122),
                              Color.fromARGB(0, 0, 0, 0),
                            ])),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 41, 39, 37),
                              Color.fromARGB(0, 30, 32, 51)
                            ]))),
                SizedBox(
                  height: 0.02 * h,
                ),
                Container(
                    height: 0.07 * h,
                    width: 0.9 * w,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 0.12 * w,
                        ),
                        Text('KYC approval',
                            style: TextStyle(
                                color: Color.fromARGB(255, 220, 221, 233),
                                fontSize: 0.045 * w,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400)),
                        Spacer(),
                        SvgPicture.asset('assests/RightArrow.svg'),
                        SizedBox(
                          width: 0.08 * w,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: const GradientBoxBorder(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color.fromARGB(255, 92, 95, 122),
                              Color.fromARGB(0, 0, 0, 0),
                            ])),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 41, 39, 37),
                              Color.fromARGB(0, 30, 32, 51)
                            ])))
              ],
            )));
  }
}

class wallet {
  String msg;
  bool auth;
  Map<String, double> data;

  wallet({required this.msg, required this.auth, required this.data});

  factory wallet.fromJson(Map<String, dynamic> json) {
    return wallet(msg: json["msg"], auth: json["auth"], data: {
      "recharge_balance": json["data"]["recharge_balance"],
      "promotional_balance": json["data"]["promotional_balance"],
      "referal_balance": json["data"]["referal_balance"],
    });
  }
}
