import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/button.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../widget/CustomNotification.dart';
import '../../widget/ineternet_connection.dart';

Future getProfileApi(token) async {
  final String getprofiled = "http://34.204.28.184:8000/getprofile";
  var client = http.Client();
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY3OTU2NDAxOH0.Hmn_jvmRSOyxenf81xDg-8NTcY6O3vkw4xV0zPbW1M4";
  var res = await client.post(
    Uri.parse(getprofiled),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  print("dog");
  print(res.statusCode);
  return res.body;
}

Future updateProfleApi(token, name, email, birthday, state) async {
  final String getprofiled = "http://34.204.28.184:8000/updateprofile";
  var client = http.Client();

  var map = Map<String, dynamic>();
  map["name"] = name;
  map["email"] = email;
  map["birthday"] = birthday;
  map["state"] = state;
  var res = await client.post(Uri.parse(getprofiled),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);
  print(res.body);
  print("dog");
  print(res.statusCode);
  return res.body;
}

class edit extends StatefulWidget {
  edit({required this.token});
  String token;
  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
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
                ? editprofile(token: widget.token)
                : buildNoInternet(context);
      },
    );
  }
}

class editprofile extends StatefulWidget {
  editprofile({required this.token});
  String token;

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  // bool isEditable = false;
  late userpro _data;
  TextEditingController _namecontoller = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _birthday = TextEditingController();
  TextEditingController _state = TextEditingController();
  @override
  void initState() {
    word();
    super.initState();
  }

  var auth;
  void word() async {
    var data = await getProfileApi(widget.token);
    var data1 = jsonDecode(data);

    auth = data1["auth"];
    print(auth);
    print("rajnandini");
    print(data1["data"]["data"]);
    var data2 = data1["data"]["data"];
    _data = userpro.fromJson(data2);
    setState(() {
      _namecontoller = TextEditingController(text: _data.name);
      _email = TextEditingController(text: _data.email);
      _birthday = TextEditingController(text: _data.birthday);
      _state = TextEditingController(text: _data.state);
    });
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
          child: Column(
            children: [
              Container(
                height: 0.041 * h,
                //  padding: EdgeInsets.fromLTRB(0, 0.02 * h, 0, 0),
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
                    // Spacer(),
                    Center(
                        child: Text(
                      "Edit Profile",
                      textAlign: TextAlign.center,
                      style: ResponsiveTextStyle.header(context),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 0.03 * h,
              ),
              Container(
                // height: 0.12 * h,
                width: 0.9 * w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: GradientBoxBorder(
                      width: 0.7,
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 92, 95, 122),
                          Color.fromARGB(0, 0, 0, 0),
                          // Color.fromARGB(255, 30, 32, 51)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      )),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 54, 45, 54),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 0.03 * h),
                    SvgPicture.asset(
                      Images.name,
                      // width: 0.045 * w,
                      height: 0.05 * h,
                    ),
                    SizedBox(
                      width: 0.03 * h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Name',
                            style: ResponsiveTextStyle.regular(context)),
                        Container(
                            // height: 0.06 * h,
                            width: 0.4 * w,
                            child: TextField(
                              cursorColor: Color(0XFFDCDDE9),
                              controller: _namecontoller,
                              style: ResponsiveTextStyle.get(context),
                              decoration: InputDecoration(
                                isDense: true,
                                // labelText: data.name,
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  fontSize: 0.05 * w,
                                  color: Color(0XFFDCDDE9),
                                ),
                                border: InputBorder.none,
                              ),
                            ))
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        SizedBox(
                          height: 0.01 * h,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            Images.edit,
                            height: 0.035 * h,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 0.01 * w,
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  // padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
                  // height: 0.12 * h,
                  width: 0.9 * w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          width: 0.7,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 92, 95, 122),
                              Color.fromARGB(0, 0, 0, 0),
                              // Color.fromARGB(255, 30, 32, 51)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                          )),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 54, 45, 54),
                          Color.fromARGB(0, 0, 0, 0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 0.03 * h),
                      SvgPicture.asset(
                        Images.birthday,
                        height: 0.05 * h,
                      ),
                      SizedBox(
                        width: 0.03 * h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Birthday',
                              style: ResponsiveTextStyle.regular(context)),
                          Container(
                              // height: 0.06 * h,
                              width: 0.4 * w,
                              child: TextField(
                                cursorColor: Color(0XFFDCDDE9),
                                controller: _birthday,
                                style: ResponsiveTextStyle.get(context),
                                decoration: InputDecoration(
                                  isDense: true,
                                  // labelText: data.name,
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 0.05 * w,
                                    color: Color(0XFFDCDDE9),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ))
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          SizedBox(
                            height: 0.01 * h,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              Images.edit,
                              height: 0.035 * h,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 0.01 * w,
                      )
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
                  // height: 0.12 * h,
                  width: 0.9 * w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          width: 0.7,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 92, 95, 122),
                              Color.fromARGB(0, 0, 0, 0),
                              // Color.fromARGB(255, 30, 32, 51)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                          )),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 54, 45, 54),
                          Color.fromARGB(0, 0, 0, 0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 0.03 * h),
                      SvgPicture.asset(
                        Images.email,
                        height: 0.05 * h,
                      ),
                      SizedBox(
                        width: 0.03 * h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Spacer(),
                          Text('Email',
                              style: ResponsiveTextStyle.regular(context)),
                          Container(
                              // color: Colors.amber,
                              width: 0.4 * w,
                              child: TextField(
                                cursorColor: Color(0XFFDCDDE9),
                                controller: _email,
                                style: ResponsiveTextStyle.get(context),
                                decoration: InputDecoration(
                                  isDense: true,
                                  // labelText: data.name,
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 0.04 * w,
                                    color: Color(0XFFDCDDE9),
                                  ),
                                  border: InputBorder.none,
                                ),
                              )),

                          // Spacer()
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          SizedBox(
                            height: 0.01 * h,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              Images.edit,
                              height: 0.035 * h,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 0.01 * w,
                      )
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
                  // height: 0.12 * h,
                  width: 0.9 * w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          width: 0.7,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 92, 95, 122),
                              Color.fromARGB(0, 0, 0, 0),
                              // Color.fromARGB(255, 30, 32, 51)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                          )),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 54, 45, 54),
                          Color.fromARGB(0, 0, 0, 0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 0.03 * h),
                      SvgPicture.asset(
                        Images.state,
                        height: 0.05 * h,
                      ),
                      SizedBox(
                        width: 0.03 * h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('State',
                              style: ResponsiveTextStyle.regular(context)),
                          Container(
                              // height: 0.06 * h,
                              width: 0.4 * w,
                              child: TextField(
                                cursorColor: Color(0XFFDCDDE9),
                                controller: _state,
                                style: ResponsiveTextStyle.get(context),
                                decoration: InputDecoration(
                                  isDense: true,
                                  // labelText: data.name,
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 0.05 * w,
                                    color: Color(0XFFDCDDE9),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ))
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          SizedBox(
                            height: 0.01 * h,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              Images.edit,
                              height: 0.035 * h,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 0.01 * w,
                      )
                    ],
                  )),
              Spacer(),
              ZoomTapAnimation(
                  onTap: () async {
                    HapticFeedback.lightImpact();
                    var resUpdateProfileApi = await updateProfleApi(
                        widget.token,
                        _namecontoller.text,
                        _email.text,
                        _birthday.text,
                        _state.text);
                    var res_body = jsonDecode(resUpdateProfileApi);
                    // if (res_body["msg"] == "Balance insufficient") {
                    Future.delayed(Duration(milliseconds: 700), () {
                      Navigator.pop(context);
                      CustomMessageDisplay customMessageDisplay =
                          CustomMessageDisplay(context);
                      customMessageDisplay.showMessage(res_body["msg"]);
                    });
                    // Navigator.pop(context);
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text(res_body["msg"])));
                  },
                  child: Button(title: "update")),
              SizedBox(
                height: 0.03 * h,
              )
            ],
          ),
        ));
  }
}

class userProfile {
  String msg;
  bool auth;
  Map<String, String> data;

  userProfile({required this.msg, required this.auth, required this.data});

  factory userProfile.fromJson(Map<String, dynamic> json) {
    return userProfile(msg: json["msg"], auth: json["auth"], data: {
      "email": json["data"]["email"],
      "name": json["data"]["name"],
      "birthday": json["data"]["birthday"],
      "state": json["data"]["state"],
    });
  }
}

class userpro {
  String phone_no;
  String email;
  String name;
  String birthday;
  String state;

  userpro(
      {required this.phone_no,
      required this.email,
      required this.name,
      required this.birthday,
      required this.state});

  factory userpro.fromJson(Map<String, dynamic> json) {
    return userpro(
      phone_no: json["phone_no"],
      email: json["email"],
      name: json["name"],
      birthday: json["birthday"],
      state: json["state"],
    );
  }
}
