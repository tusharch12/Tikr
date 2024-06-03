import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:tikr/class/secure_storage.dart';
import 'package:tikr/page/Home.dart';
import 'package:tikr/page/signIn.dart';
import 'package:tikr/provider/otpProvider.dart';
import 'package:tikr/widget/button.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../Modals/createfund_modal.dart';
import '../Modals/loginVer_modal.dart';

import '../widget/CustomNotification.dart';

class loginVer {
  Future postVerify(countrycode, phone, otp) async {
    final String verifyUrl = "http://34.204.28.184:8000/login_verification";
    // String token =

    var map = Map<String, dynamic>();
    map["country"] = countrycode;
    map["phone"] = phone;
    map["otp"] = otp;
    var response = await http.post(Uri.parse(verifyUrl),
        headers: {
          // 'Authorization': 'Bearer $token',
        },
        body: map);
    var map1 = Map<String, dynamic>();
    map1["status"] = response.statusCode;
    map1["body"] = jsonDecode(response.body);
    // print(response.body);
    return map1;
  }
}

Future? getFcmToken(String token) {
  FirebaseMessaging.instance.getToken().then((fcm_token) async {
    print("Firebase Messaging Token: $token");

    final String verifyUrl = "http://34.204.28.184:8000/update_fcm_token";
    Map<String, dynamic> map = Map();
    map["fcm_token"] = fcm_token;
    String token1 =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NiIsImV4cCI6MTY4NTk2MDQ4OH0.Q3_fw9Grb8Uptn47AGsrK0_wXB4zK4e_ktjxgBQB6lM";
    var response = await http.post(Uri.parse(verifyUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: map);
    print(response.body);
  });
}

Future<create_fund> creteFund(data) async {
  final String verifyUrl = "http://34.204.28.184:8000/create_funds_entity";

  String token1 = data;
  var response = await http.post(
    Uri.parse(verifyUrl),
    headers: {
      'Authorization': 'Bearer $token1',
    },
  );
  print(response.body);

  return create_fund.fromjson(jsonDecode(response.body));
}

class otp1 extends StatefulWidget {
  const otp1({
    required this.phone,
    required this.cntyCode,
    Key? key,
  }) : super(key: key);
  // final TextEditingController countrycode;
  final String phone;
  final String cntyCode;
  @override
  State<otp1> createState() => otp1State();
}

class otp1State extends State<otp1> {
  final form = GlobalKey<FormState>();
  Future<void> otpv() async {
    FocusScope.of(context).unfocus();
    await Future.delayed(Duration(milliseconds: 100));
    if (form.currentState!.validate()) {
      form.currentState!.save();
    }
    String OTP = OTP1 + OTP2 + OTP3 + OTP4;
    var data = await loginVer().postVerify(widget.cntyCode, widget.phone, OTP);
    login_ver lv = login_ver.fromjson(data["body"]);
    print(lv.data);
    if (data["status"] == 200) {
      create_fund cf = await creteFund(lv.data["user"]["token"]);
      print(lv.data["user"]["token"]);
      String token = lv.data["user"]["token"];
      print(token);
      secureStorage().setToken(token);
      getFcmToken(token);
      if (cf.auth == true) {
        Get.offAll(() => My(
              token: token,
            ));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => signin1()));
      }
    } else {
      CustomMessageDisplay customMessageDisplay = CustomMessageDisplay(context);
      customMessageDisplay.showMessage(lv.msg);
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => signin1()));
    }
  }

  @override
  late StreamController<int> _streamController;
  late Timer _timer;
  bool _showRestartButton = false;

  void initState() {
    // SendPh().postPh(widget.cntyCode, widget.phone.toString());
    _streamController = StreamController<int>();
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);

    super.initState();
  }

  String OTP1 = "";
  String OTP2 = "";
  String OTP3 = "";
  String OTP4 = "";

  void _onTimerTick(Timer timer) {
    if (_streamController.isClosed) {
      return;
    }
    if (_showRestartButton) {
      return;
    }
    if (_timer.tick == 60) {
      _streamController.add(0);
    }
    if (_timer.tick == 60) {
      _timer.cancel();
      _showRestartButton = true;
      _streamController.close();
      setState(() {});
    } else {
      _streamController.add(60 - _timer.tick);
    }
  }

  void _restartTimer() {
    SendPh().postPh(widget.cntyCode, widget.phone.toString());
    setState(() {
      _showRestartButton = false;
      _streamController = StreamController<int>();
      _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
    });
  }

  @override
  void dispose() {
    _streamController.close();
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => timer(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromARGB(255, 17, 19, 31),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.045,
              ),
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.04 * height),
                      Text(
                        'Enter OTP',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color.fromARGB(255, 223, 221, 233),
                            fontSize: 0.065 * width,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 0.022 * height,
                      ),
                      Text(
                        'To keep connected with us please login\nwith your personal info',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color.fromARGB(255, 122, 124, 143),
                            fontSize: 0.040 * width,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 0.03 * height,
                      ),
                      Text(
                        'OTP',
                        style: TextStyle(
                          fontSize: 0.028 * width,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 123, 123, 148),
                        ),
                      ),
                      SizedBox(height: 0.01 * height),
                      Form(
                        key: form,
                        child: Row(
                          //  crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // BOX 1 ///////////////////////////////////////////////
                            Expanded(
                              child: Container(
                                height: 0.072 * height,
                                // width: 0.1 * width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color.fromARGB(163, 33, 38, 65),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    child: TextFormField(
                                      // textAlignVertical: TextAlignVertical.top,
                                      autofocus: true,
                                      onSaved: (STR) {
                                        OTP1 = STR!;
                                        print("OTP = " + OTP1);
                                      },
                                      validator: (str) {
                                        print(str);
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      onEditingComplete: otpv,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // ),
                            SizedBox(width: 0.03 * width),
                            //box 2222222222222222222222222222222222
                            Expanded(
                              child: Container(
                                height: 0.072 * height,
                                // width: 0.19 * width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color.fromARGB(163, 33, 38, 65),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    child: TextFormField(
                                      // textAlignVertical: TextAlignVertical.top,
                                      onSaved: (STR) {
                                        OTP2 = STR!;
                                        print("OTP = " + OTP2);
                                      },
                                      validator: (str) {
                                        print(str);
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 0.03 * width),

                            Expanded(
                              child: Container(
                                height: 0.072 * height,
                                // width: 0.19 * width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color.fromARGB(163, 33, 38, 65),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    child: TextFormField(
                                      // textAlignVertical: TextAlignVertical.top,
                                      onSaved: (STR) {
                                        OTP3 = STR!;
                                        print("OTP = " + OTP3);
                                      },
                                      validator: (str) {
                                        print(str);
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 0.03 * width),
                            Expanded(
                              child: Container(
                                height: 0.072 * height,
                                // width: 0.19 * width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color.fromARGB(163, 33, 38, 65),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  child: Center(
                                    child: TextFormField(
                                      // textAlignVertical: TextAlignVertical.top,
                                      onSaved: (STR) {
                                        OTP4 = STR!;
                                        print("OTP = " + OTP4);
                                      },
                                      validator: (str) {
                                        print(str);
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0.0285 * height,
                      ),
                      Consumer<timer>(builder: (context, value, child) {
                        return _showRestartButton
                            ? Container(
                                child: GestureDetector(
                                    onTap: _restartTimer,
                                    child: Text('Send OTP again ',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 36, 201, 171),
                                          fontSize: 0.039 * width,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w200,
                                        ))),
                              )
                            : StreamBuilder(
                                stream: _streamController.stream,
                                initialData: 60,
                                builder: (context, snapshot) {
                                  return Row(
                                    children: [
                                      Text('Resend OTP in  ',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 36, 201, 171),
                                            fontSize: 0.039 * width,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w200,
                                          )),
                                      Text('${snapshot.data}',
                                          style: TextStyle(
                                              fontSize: 0.039 * width,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w200,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255))),
                                      Text(' Seconds  ',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 36, 201, 171),
                                            fontSize: 0.039 * width,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w200,
                                          ))
                                    ],
                                  );
                                });

                        //     })
                      }),
                      Spacer(),
                      // SizedBox(
                      //   height: 0.43 * height,
                      // ),
                      // Spacer(),
                      ZoomTapAnimation(
                          onTap: () async {
                            if (form.currentState!.validate()) {
                              form.currentState!.save();
                            }
                            String OTP = OTP1 + OTP2 + OTP3 + OTP4;
                            var data = await loginVer()
                                .postVerify(widget.cntyCode, widget.phone, OTP);
                            login_ver lv = login_ver.fromjson(data["body"]);
                            print(lv.data);
                            if (data["status"] == 200) {
                              create_fund cf =
                                  await creteFund(lv.data["user"]["token"]);
                              print(lv.data["user"]["token"]);
                              String token = lv.data["user"]["token"];
                              print(token);
                              secureStorage().setToken(token);
                              getFcmToken(token);
                              if (cf.auth == true) {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => My(
                                          
                                //           token: token,
                                //         )));
                                Get.offAll(() =>  My(
                                      token: token,
                                    ));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => signin1()));
                              }
                            } else {
                              CustomMessageDisplay customMessageDisplay =
                                  CustomMessageDisplay(context);
                              customMessageDisplay.showMessage(lv.msg);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => signin1()));
                            }
                          },
                          child: Button(
                            title: "Let’s Begin",
                          )),
                      SizedBox(height: 0.03 * height),
                    ]),
              ),
            ),
          )),
    );
  }
}
