import 'dart:async';
import 'dart:convert';
import 'package:confetti/confetti.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tikr/Page/Pool%20page/createPool_popUp.dart';
import 'package:tikr/widget/button.dart';

import 'package:tikr/widget/popUp.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../widget/CustomNotification.dart';
import '../../widget/ineternet_connection.dart';
// import 'Images.dart';

create_pool(String pool_name, String type, String token) async {
  String url = "http://34.204.28.184:8000/create_pool";
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxOTAwMTEyMDQ2NSIsImV4cCI6MTY3MTYzOTY3M30.tFxyvwO3eZY94bn72nwGN8D1Z7M_giRiBgh9bS6jhFc";

  var map = Map<String, dynamic>();
  map["pool_name"] = pool_name;
  map["pool_type"] = type;
  var response = await http.post(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);

  print(response.body);
  // print("dog");
  print(response.statusCode);
  return response;
}

Join_pool(String pool_name, String token) async {
  String url = "http://34.204.28.184:8000/join_pool";
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxOTAwMTEyMDQ2NSIsImV4cCI6MTY3MTYzOTY3M30.tFxyvwO3eZY94bn72nwGN8D1Z7M_giRiBgh9bS6jhFc";

  var map = Map<String, dynamic>();
  print(pool_name);
  // print(pool_name[0] + pool_name[1]);
  map["pool_code"] = pool_name;
  // map["pool_type"] = "PU";

  var response = await http.post(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);
  // print(response.body);
  // print("dog");
  // print(response.statusCode);
  return response;
}

// ignore: must_be_immutable
class Pools extends StatefulWidget {
  Pools({required this.token, Key? key}) : super(key: key);
  String token;

  @override
  State<Pools> createState() => _PoolsState();
}

class _PoolsState extends State<Pools> {
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
                ? pool(token: widget.token)
                : buildNoInternet(context);
      },
    );
  }
}

class pool extends StatefulWidget {
  pool({required this.token, Key? key}) : super(key: key);
  String token;
  @override
  State<pool> createState() => _poolState();
}

class _poolState extends State<pool> {
  ConfettiController _confettiController = ConfettiController();
  TextEditingController _nameCon = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _nameConJoin = TextEditingController();
  TextEditingController _typeJoin = TextEditingController();
  @override
  String _selectedItem = 'Public';
  List<String> _items = ['Public', 'Private'];

  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 4));
  }

  void _startSparkleEffect() {
    _confettiController.play();
    Future.delayed(Duration(seconds: 2), () {
      _confettiController.stop();
    });
  }

  Future<void> create() async {
    FocusScope.of(context).unfocus();
    await Future.delayed(Duration(milliseconds: 200));

    HapticFeedback.lightImpact();
    var res = await Join_pool(_nameConJoin.text, widget.token);
    print(res);
    print(res.runtimeType);
    var res_body = jsonDecode(res.body);
    Future.delayed(Duration(milliseconds: 700), () {
      if (res.statusCode == 201) Navigator.of(context).pop();

      CustomMessageDisplay customMessageDisplay = CustomMessageDisplay(context);
      customMessageDisplay.showMessage(res_body["msg"]);
    });
  }

  Future<void> join() async {
    FocusScope.of(context).unfocus();
    // await Future.delayed(Duration(milliseconds: 200));

    // HapticFeedback.lightImpact();
    // var res = await Join_pool(_nameConJoin.text, widget.token);
    // print(res);
    // print(res.runtimeType);
    // var res_body = jsonDecode(res);
    // Future.delayed(Duration(milliseconds: 700), () {
    //   CustomMessageDisplay customMessageDisplay = CustomMessageDisplay(context);
    //   customMessageDisplay.showMessage(res_body["msg"]);
    // });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: [
      Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromARGB(255, 17, 19, 31),
          body: SafeArea(
              minimum: EdgeInsets.fromLTRB(0, 0.07 * height, 0, 0),
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 0.041 * height,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 0.046 * width,
                                child: ZoomTapAnimation(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                      'assests/Arrow.svg',
                                      height: 0.041 * height,
                                      width: 0.041 * width,
                                    )),
                              ),
                              Center(
                                child: Text(
                                  'Pool',
                                  style: ResponsiveTextStyle.header(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                0.05 * width, 0, 0.05 * width, 0),
                            child: Column(children: [
                              SizedBox(
                                height: 0.03 * height,
                              ),
                              Container(
                                height: 0.05 * height,
                                width: 0.8 * width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                child: TabBar(
                                  unselectedLabelColor: Colors.white,
                                  indicatorColor: Colors.black,
                                  indicator: BoxDecoration(
                                      border: GradientBoxBorder(
                                          gradient: LinearGradient(colors: [
                                        Color.fromARGB(255, 222, 203, 195),
                                        Color.fromARGB(0, 222, 203, 195)
                                      ])),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 227, 51, 66),
                                          Color.fromARGB(255, 182, 18, 103)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30)),
                                  tabs: [
                                    Tab(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'New',
                                            style: TextStyle(
                                              fontSize: 0.035 * width,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 225, 225, 255),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        height: 0.07 * height,
                                        width: 0.6 * width,
                                        decoration: BoxDecoration(
                                          // color: Color.fromARGB(100, 30, 32, 51),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Join',
                                            style: TextStyle(
                                              fontSize: 0.035 * width,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 225, 225, 255),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.07 * height,
                              ),
                              Container(
                                height: 0.72 * height,
                                width: 0.9 * width,
                                child: TabBarView(children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name',
                                          style:
                                              ResponsiveTextStyle.pool(context),
                                        ),
                                        SizedBox(
                                          height: 0.01 * height,
                                        ),
                                        Container(
                                          // height: 0.08 * height,
                                          width: 0.9 * width,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 30, 32, 51),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 0.05 * width),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());
                                                  },
                                                  child: TextFormField(
                                                    // textAlignVertical:
                                                    //     TextAlignVertical.center,
                                                    textAlign: TextAlign.start,
                                                    controller: _nameCon,
                                                    onEditingComplete: create,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            123,
                                                            123,
                                                            148)),
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Enter the name of the pool",
                                                      border: InputBorder.none,
                                                      hintStyle: TextStyle(
                                                          fontSize:
                                                              0.038 * width,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color.fromARGB(
                                                              255,
                                                              123,
                                                              123,
                                                              148)),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.03 * height,
                                        ),
                                        Text(
                                          'Type',
                                          style:
                                              ResponsiveTextStyle.pool(context),
                                        ),
                                        SizedBox(
                                          height: 0.01 * height,
                                        ),
                                        Container(
                                          // height: 0.08 * height,
                                          width: 0.9 * width,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 30, 32, 51),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: DropdownButtonFormField(
                                            alignment: Alignment.bottomRight,
                                            isExpanded: false,
                                            dropdownColor:
                                                Color.fromARGB(255, 30, 32, 51),
                                            itemHeight:
                                                kMinInteractiveDimension,
                                            style: TextStyle(
                                                fontSize: 0.038 * width,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(
                                                    255, 123, 123, 148)),
                                            decoration: InputDecoration(
                                              // fillColor: Color.fromARGB(255, 30, 32, 51),
                                              hintText: "none",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            hint: Text("None"),
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            value: _selectedItem,
                                            items: _items.map((String item) {
                                              return DropdownMenuItem<String>(
                                                // alignment: Alignment,
                                                value: item,
                                                child: Text(item),
                                              );
                                            }).toList(),
                                            onChanged: (name) {
                                              setState(() {
                                                _selectedItem = name!;
                                              });
                                            },
                                          ),
                                        ),
                                        Spacer(),
                                        ZoomTapAnimation(
                                            onTap: () async {
                                              HapticFeedback.lightImpact();
                                              var res = await create_pool(
                                                  _nameCon.text,
                                                  _selectedItem,
                                                  widget.token);

                                              var res_body =
                                                  jsonDecode(res.body);

                                              if (res.statusCode == 201) {
                                                var pool_name =
                                                    (res_body["data"]
                                                        ["pool_name"]);
                                                var pool_code =
                                                    (res_body["data"]
                                                        ["pool_code"]);

                                                createPoolpopUp(
                                                    context,
                                                    pool_name,
                                                    pool_code,
                                                    _selectedItem);
                                              }

                                              CustomMessageDisplay
                                                  customMessageDisplay =
                                                  CustomMessageDisplay(context);
                                              customMessageDisplay
                                                  .showMessage(res_body["msg"]);
                                            },
                                            child: Center(
                                                child: Button(
                                              title: "Create",
                                            ))),
                                        SizedBox(
                                          height: 0.02 * height,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pool Code',
                                        style:
                                            ResponsiveTextStyle.pool(context),
                                      ),
                                      SizedBox(
                                        height: 0.01 * height,
                                      ),
                                      Container(
                                        // height: 0.08 * height,
                                        width: 0.9 * width,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 30, 32, 51),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 0.05 * width),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                },
                                                child: Center(
                                                  child: TextFormField(
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    textAlign: TextAlign.start,
                                                    // keyboardType: TextInputType.number,
                                                    onEditingComplete: join,
                                                    controller: _nameConJoin,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            123,
                                                            123,
                                                            148)),
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Enter Pool code",
                                                      border: InputBorder.none,
                                                      hintStyle: TextStyle(
                                                          fontSize:
                                                              0.038 * width,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color.fromARGB(
                                                              255,
                                                              123,
                                                              123,
                                                              148)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //     SizedBox(
                                      //       height: 0.03 * height,
                                      //     ),
                                      //     Text(
                                      //       'Type',
                                      //       style: ResponsiveTextStyle.pool(context),
                                      //     ),
                                      //     SizedBox(
                                      //       height: 0.01 * height,
                                      //     ),
                                      //     Container(
                                      //       // height: 0.08 * height,
                                      //       width: 0.9 * width,
                                      //       decoration: BoxDecoration(
                                      //         color: Color.fromARGB(255, 30, 32, 51),
                                      //         borderRadius: BorderRadius.circular(10),
                                      //       ),
                                      //       child: DropdownButtonFormField(
                                      //         alignment: Alignment.bottomRight,
                                      //         isExpanded: false,
                                      //         dropdownColor: Color.fromARGB(255, 30, 32, 51),
                                      //         itemHeight: kMinInteractiveDimension,
                                      //         style: TextStyle(
                                      //             fontSize: 0.038 * width,
                                      //             fontFamily: 'Poppins',
                                      //             fontWeight: FontWeight.w400,
                                      //             color: Color.fromARGB(255, 123, 123, 148)),
                                      //         decoration: InputDecoration(
                                      //           // fillColor: Color.fromARGB(255, 30, 32, 51),
                                      //           hintText: "none",
                                      //           border: OutlineInputBorder(
                                      //             borderRadius: BorderRadius.circular(10.0),
                                      //           ),
                                      //         ),
                                      //         hint: Text("None"),
                                      //         icon: Icon(Icons.keyboard_arrow_down),
                                      //         value: _selectedItem,
                                      //         items: _items.map((String item) {
                                      //           return DropdownMenuItem<String>(
                                      //             // alignment: Alignment,
                                      //             value: item,
                                      //             child: Text(item),
                                      //           );
                                      //         }).toList(),
                                      //         onChanged: (name) {
                                      //           setState(() {
                                      //             _selectedItem = name!;
                                      //           });
                                      //         },
                                      //       ),
                                      //     ),
                                      Spacer(),
                                      ZoomTapAnimation(
                                          onTap: () async {
                                            HapticFeedback.lightImpact();
                                            var res = await Join_pool(
                                                _nameConJoin.text,
                                                widget.token);
                                            print(res);
                                            print(res.runtimeType);
                                            var res_body = jsonDecode(res.body);
                                            Future.delayed(
                                                Duration(milliseconds: 700),
                                                () {
                                              if (res.statusCode == 201)
                                                Navigator.of(context).pop();

                                              CustomMessageDisplay
                                                  customMessageDisplay =
                                                  CustomMessageDisplay(context);
                                              customMessageDisplay
                                                  .showMessage(res_body["msg"]);
                                            });
                                          },
                                          child: Center(
                                              child: Button(
                                            title: "Enter",
                                          ))),
                                      SizedBox(
                                        height: 0.02 * height,
                                      ),
                                    ],
                                  )),
                                ]),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: ConfettiWidget(
                                  // shouldLoop: true,
                                  blastDirectionality:
                                      BlastDirectionality.explosive,
                                  confettiController: _confettiController,
                                  blastDirection: 3.14, // radial value - PI
                                  maxBlastForce: 6,
                                  minBlastForce: 5,
                                  numberOfParticles: 10,
                                  gravity: 0.2,
                                ),
                              )
                            ]))
                      ]))))
    ]);
  }
}
