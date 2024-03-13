import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tikr/page/Home.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/button.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:http/http.dart' as http;
import '../../widget/CustomNotification.dart';
import '../../widget/ineternet_connection.dart';
import '../Wallet/WalletPage.dart';

class contact extends StatefulWidget {
  contact({Key? key, required this.token}) : super(key: key);
  String token;

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
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

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<bool?>(
      valueListenable: _isConnected,
      builder: (context, isConnected, child) {
        return isConnected == null
            ? buildLoading()
            : isConnected
                ? contactus(token: widget.token)
                : buildNoInternet(context);
      },
    );
  }
}

class contactus extends StatefulWidget {
  contactus({Key? key, required this.token}) : super(key: key);
  String token;
  @override
  State<contactus> createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  TextEditingController _subject = TextEditingController();
  TextEditingController _message = TextEditingController();
  bool _isFocused = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 17, 19, 31),
        body: SafeArea(
            minimum: EdgeInsets.fromLTRB(0, 0.07 * height, 0, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 0.041 * height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0.046 * width,
                      child: ZoomTapAnimation(
                          onTap: () {
                            Navigator.pop(context);
                            HapticFeedback.lightImpact();
                          },
                          child: SvgPicture.asset(
                            Images.back,
                            height: 0.04 * height,
                            width: 0.04 * width,
                          )),
                    ),
                    Center(
                      child: Text(
                        'Contact',
                        style: ResponsiveTextStyle.header(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.04 * height,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.05 * width, 0, 0.046 * width, 0),
                child: Text(
                  'Subject',
                  style: ResponsiveTextStyle.pool(context),
                ),
              ),
              SizedBox(
                height: 0.01 * height,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.05 * width, 0, 0.05 * width, 0),
                child: Container(
                  // height: 0.08 * height,
                  width: 0.9 * width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 30, 32, 51),
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(width: 1, color: Colors.black)
                  ),
                  child: Row(children: [
                    SizedBox(width: 0.05 * width),
                    Expanded(
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.start,
                        controller: _subject,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            // color: Color.fromARGB(255, 220, 221, 233),
                            fontSize: 0.04 * width,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 123, 123, 148)),
                        decoration: InputDecoration(
                          hintText: "Topic of query",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 123, 123, 148)),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 0.03 * height,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.05 * width, 0, 0.046 * width, 0),
                child: Text(
                  'Message',
                  style: ResponsiveTextStyle.pool(context),
                ),
              ),
              SizedBox(
                height: 0.01 * height,
              ),
              GestureDetector(
                onTap: () {
                  if (!_isFocused) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _isFocused = true;
                    });
                  }
                },
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(0.05 * width, 0, 0.05 * width, 0),
                  child: Container(
                    height: 0.2 * height,
                    width: 0.9 * width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 30, 32, 51),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.05 * width, 0, 0, 0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        controller: _message,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 0.04 * width,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 123, 123, 148)),
                        decoration: InputDecoration(
                          hintText: "Explain your message or topic",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 123, 123, 148)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                  padding:
                      EdgeInsets.fromLTRB(0.05 * width, 0, 0.05 * width, 0),
                  child: ZoomTapAnimation(
                    onTap: () async {
                      HapticFeedback.lightImpact();
                      String token = widget.token;
                      var map = Map<String, dynamic>();
                      map["subject"] = _subject.text;
                      map["body"] = _message.text;
                      // print(map);

                      final String url =
                          "http://34.204.28.184:8000/contact_app_query";
                      var client = http.Client();
                      // String token =
                      //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY4MDQzNzE5OX0.Lof3zjEFXPKEJ7_55qVJmtBcnJ4COYVTJy3Vcaro8F0";
                      var res = await client.post(Uri.parse(url),
                          headers: {
                            'Authorization': 'Bearer $token',
                          },
                          body: map
                          //
                          );
                      print(res.body);

                      var msg = jsonDecode(res.body);
                      print(msg);
                      Future.delayed(Duration(milliseconds: 700), () {
                        if (res.statusCode == 201) {
                          Navigator.pop(context);
                        }
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage(msg["msg"]);
                      });
                    },
                    child: Button(
                      title: "Send",
                    ),
                  )),
              SizedBox(height: 0.03 * height),
            ])));
  }
}
