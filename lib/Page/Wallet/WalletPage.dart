import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:tikr/Page/Wallet/withdraw_Req.dart';
import 'package:tikr/page/Wallet/withdraw.dart';
import 'package:tikr/widget/signUpButton.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../Images.dart';
import '../../textstyle.dart';
import '../../widget/ineternet_connection.dart';
import 'Add_money.dart';

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

class wallt extends StatefulWidget {
  wallt({super.key, required this.token});
  String token;

  @override
  State<wallt> createState() => _walltState();
}

class _walltState extends State<wallt> {
  late ValueNotifier<bool?> _isConnected;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    _isConnected = ValueNotifier<bool?>(null);
    _initConnectivity();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _isConnected.value = result != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _isConnected.dispose();
    super.dispose();
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await Connectivity().checkConnectivity();
    } catch (e) {
      print(e);
    }
    _isConnected.value = result != ConnectivityResult.none;
  }

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Center(
      child: ValueListenableBuilder<bool?>(
        valueListenable: _isConnected,
        builder: (context, isConnected, child) {
          return isConnected == null
              ? buildLoading()
              : isConnected
                  ? WalletPage(token: widget.token)
                  : buildNoInternet(context);
        },
      ),
    );
  }
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
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 17, 19, 31),
        body: SafeArea(
            minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
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
                                'Wallet',
                                textAlign: TextAlign.center,
                                style: ResponsiveTextStyle.header(context),
                              ),
                            ),
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: FutureBuilder(
                              future: httpRequest().getWallet(widget.token),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  wallet? Wallet = snapshot.data;
                                  var Total =
                                      Wallet!.data["recharge_balance"]! +
                                          Wallet.data["promotional_balance"]! +
                                          Wallet.data["referal_balance"]!;
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.046 * w, 0, 0.046 * w, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 0.03 * h,
                                        ),
                                        Center(
                                          child: GradientText(
                                            '\u{20B9} ${Total}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 0.08 * w,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'),
                                            colors: [
                                              const Color.fromARGB(
                                                  255, 100, 180, 103),
                                              const Color.fromARGB(
                                                  255, 152, 218, 198)
                                            ],
                                          ),
                                        ),
                                        //     ),
                                        //   ],
                                        // ),
                                        SizedBox(
                                          height: 0.03 * h,
                                        ),

                                        Container(
                                          width: 0.923 * w,
                                          height: 0.116 * h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: const GradientBoxBorder(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                    Color.fromARGB(
                                                        255, 92, 95, 122),
                                                    Color.fromARGB(0, 0, 0, 0),
                                                  ])),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 41, 39, 37),
                                                    Color.fromARGB(
                                                        0, 30, 32, 51)
                                                  ])),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 0.05 * w,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      Images.deposit),
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
                                                      style: ResponsiveTextStyle
                                                          .get(context)),
                                                  Container(
                                                    height: 0.041 * h,
                                                    child: GradientText(
                                                      '\u{20B9} ${Wallet.data["recharge_balance"]} \n ',
                                                      style: TextStyle(
                                                          fontSize: 0.05 * w,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Poppins'),
                                                      colors: const [
                                                        Color.fromARGB(
                                                            255, 100, 180, 103),
                                                        Color.fromARGB(
                                                            255, 122, 218, 190)
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
                                                  ZoomTapAnimation(
                                                    onTap: () {
                                                      Get.to(() => addnew(
                                                          token: widget.token));
                                                      HapticFeedback
                                                          .lightImpact();
                                                    },
                                                    child: Container(
                                                      width: 0.287 * w,
                                                      height: 0.041 * h,
                                                      decoration: BoxDecoration(
                                                          border:
                                                              const GradientBoxBorder(
                                                                  gradient:
                                                                      LinearGradient(
                                                                          colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    222,
                                                                    203,
                                                                    195),
                                                                Color.fromARGB(
                                                                    0,
                                                                    222,
                                                                    203,
                                                                    195),
                                                                // Color.fromARGB(255, 30, 32, 51)
                                                              ])),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    71,
                                                                    99,
                                                                    76),
                                                                Color.fromARGB(
                                                                    100,
                                                                    68,
                                                                    171,
                                                                    86)
                                                              ])),
                                                      child: Center(
                                                        child: Text(
                                                          'Add Money',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  0.04 * w,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 0.014 * h,
                                                  ),
                                                  ZoomTapAnimation(
                                                    onTap: () {
                                                      Get.to(() => withdraw(
                                                          token: widget.token));
                                                      HapticFeedback
                                                          .lightImpact();
                                                    },
                                                    child: Container(
                                                      width: 0.287 * w,
                                                      height: 0.041 * h,
                                                      decoration: BoxDecoration(
                                                          border:
                                                              const GradientBoxBorder(
                                                                  gradient:
                                                                      LinearGradient(
                                                                          colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    222,
                                                                    203,
                                                                    195),
                                                                Color.fromARGB(
                                                                    0,
                                                                    222,
                                                                    203,
                                                                    195),
                                                                // Color.fromARGB(255, 30, 32, 51)
                                                              ])),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          gradient: const LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    99,
                                                                    71,
                                                                    71),
                                                                Color.fromARGB(
                                                                    255,
                                                                    167,
                                                                    70,
                                                                    70)
                                                              ])),
                                                      child: Center(
                                                        child: Text(
                                                          'Withdraw',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  0.04 * w,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: const GradientBoxBorder(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                    Color.fromARGB(
                                                        255, 92, 95, 122),
                                                    Color.fromARGB(0, 0, 0, 0),
                                                  ])),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 41, 39, 37),
                                                    Color.fromARGB(
                                                        0, 30, 32, 51)
                                                  ])),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 0.05 * w,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      Images.promotional),
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
                                                  Text('Promotional',
                                                      style: ResponsiveTextStyle
                                                          .get(context)),
                                                  Container(
                                                    height: 0.041 * h,
                                                    child: Container(
                                                      width: 0.173 * w,
                                                      child: GradientText(
                                                        '\u{20B9} ${Wallet.data["promotional_balance"]} \n ',
                                                        style: TextStyle(
                                                            fontSize: 0.05 * w,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Poppins'),
                                                        colors: [
                                                          const Color.fromARGB(
                                                              255,
                                                              100,
                                                              180,
                                                              103),
                                                          const Color.fromARGB(
                                                              255,
                                                              122,
                                                              218,
                                                              190)
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
                                                  ZoomTapAnimation(
                                                    onTap: () {
                                                      HapticFeedback
                                                          .lightImpact();
                                                      Share.share(
                                                          "Hi! Join me on Tikr99 and get Rs 20 for FREE, to trade and earn on this real stock market game!");
                                                    },
                                                    child: Container(
                                                      width: 0.287 * w,
                                                      height: 0.041 * h,
                                                      decoration: BoxDecoration(
                                                          border:
                                                              const GradientBoxBorder(
                                                                  gradient: LinearGradient(
                                                                      colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    222,
                                                                    203,
                                                                    195),
                                                                Color.fromARGB(
                                                                    0,
                                                                    222,
                                                                    203,
                                                                    195),
                                                                // Color.fromARGB(255, 30, 32, 51)
                                                              ])),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          gradient: const LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    99,
                                                                    98,
                                                                    71),
                                                                Color.fromARGB(
                                                                    255,
                                                                    159,
                                                                    156,
                                                                    66)
                                                              ])),
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Center(
                                                          child: Text(
                                                            'Share',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    0.04 * w,
                                                                color: Colors
                                                                    .white),
                                                          ),
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
                                          height: 0.02 * h,
                                        ),
                                        Text('Quick Actions',
                                            style: ResponsiveTextStyle.get(
                                                context)),
                                        SizedBox(
                                          height: 0.02 * h,
                                        ),
                                        ZoomTapAnimation(
                                          onTap: () {
                                            Get.to(() => withdrawl_Req(
                                                token: widget.token));
                                          },
                                          child: Container(
                                              height: 0.072 * h,
                                              width: 0.9 * w,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 0.12 * w,
                                                  ),
                                                  Text('Withdraw Requests',
                                                      style: ResponsiveTextStyle
                                                          .profile(context)),
                                                  Spacer(),
                                                  SvgPicture.asset(
                                                      'assests/Rightarrow.svg'),
                                                  SizedBox(
                                                    width: 0.08 * w,
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border:
                                                      const GradientBoxBorder(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                        Color.fromARGB(
                                                            255, 92, 95, 122),
                                                        Color.fromARGB(
                                                            0, 0, 0, 0),
                                                      ])),
                                                  gradient:
                                                      const LinearGradient(
                                                          begin:
                                                              Alignment
                                                                  .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                        Color.fromARGB(
                                                            255, 41, 39, 37),
                                                        Color.fromARGB(
                                                            0, 30, 32, 51)
                                                      ]))),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return loader(context, w, h);
                                }
                              }),
                        ),
                      ),
                      // SizedBox(
                      //   height: 0.02 * h,
                      // ),
                    ])),
              );
            })));
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
