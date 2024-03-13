import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:tikr/Modals/homePage/homePageStockList_modal.dart';
import 'package:tikr/Page/Home.dart';
import 'package:tikr/Page/Wallet/WalletPage.dart';
import 'package:tikr/Page/signIn.dart';
import 'package:tikr/provider/pool_provider.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../widget/ProfilePicWidget.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../widget/ineternet_connection.dart';
import '../../widget/signUpButton.dart';
import 'StockList_widget.dart';

class homeList {
  var client = http.Client();
  final String geturl = "http://34.204.28.184:8000/get_instrument_list_cc";
  Future getListdata(token) async {
    var map = Map<String, dynamic>();
    map["game_category"] = "in_stocks";
    try {
      var res = await client.post(Uri.parse(geturl),
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: map);
      print(res.body);
      var body = jsonDecode(res.body);
      var auth = body["auth"];
      print(body);
      return res;
    } catch (e) {}
  }
}

Future _bannercards(token) async {
  var client = http.Client();
  final String geturl = "http://34.204.28.184:8000/get_bannercards";
  var map = Map<String, dynamic>();

  try {
    var res = await client.post(
      Uri.parse(geturl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(res.body);
    var body = jsonDecode(res.body);
    // print(body);
    // var auth = body["auth"];
    // map["auth"] = body["auth"];
    // map["status"] = body["status"];
    return body;
  } catch (e) {}
}

Future marketApi(token) async {
  var client = http.Client();
  final String geturl = "http://34.204.28.184:8000/get_india_mkt_status";
  var map = Map<String, dynamic>();

  try {
    var res = await client.post(
      Uri.parse(geturl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(res.body);
    var body = jsonDecode(res.body);
    var auth = body["auth"];
    map["auth"] = body["auth"];
    map["status"] = body["status"];
    return map;
  } catch (e) {}
}

class ConnectivityChecker extends StatefulWidget {
  ConnectivityChecker({required this.token, required this.index, super.key});
  String token;
  int index;
  @override
  _ConnectivityCheckerState createState() => _ConnectivityCheckerState();
}

class _ConnectivityCheckerState extends State<ConnectivityChecker> {
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
                ? My(
                    token: widget.token,
                  )
                : buildNoInternet(context);
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({required this.token, super.key});
  String token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _walletKey = GlobalKey();
  final GlobalKey _adiPic = GlobalKey();

  // final GlobalKey _walletKey = GlobalKey();
  @override
  void initState() {
    // getConnectivity();
    _bannercards(widget.token);

    final provider = Provider.of<poolProvider>(context, listen: false);
    final marketRes = marketApi(widget.token);
    provider.call(widget.token);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final provider = Provider.of<poolProvider>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 17, 19, 31),
        body: SafeArea(
            minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
            child: Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                child: Row(
                  children: [
                    ZoomTapAnimation(
                      onTap: () {
                        Get.to(() => WalletPage(token: widget.token));
                        HapticFeedback.lightImpact();
                      },
                      child: SvgPicture.asset(
                        Images.wallet,
                        height: 0.041 * h,
                        width: 0.041 * w,
                      ),
                    ),
                    SizedBox(width: 0.13 * w),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Candle Colors',
                          style: ResponsiveTextStyle.header(context),
                        ),
                      ),
                    ),
                    Consumer<poolProvider>(builder: (context, state, child) {
                      // print(state.poolName);
                      return ProfilePic(context, widget.token, state);
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 0.03 * h,
              ),
              CarouselSlider(
                items: [
                  Container(
                    width: 0.9 * w,
                    height: 0.1 * h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.slider1), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Container(
                    width: 0.9 * w,
                    height: 0.1 * h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.slider2), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
                options: CarouselOptions(
                    height: 0.12 * h,
                    aspectRatio: 16 / 9,
                    initialPage: 1,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 3),
                    viewportFraction: 0.999),
              ),
              SizedBox(
                height: 0.02 * h,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                child: Row(
                  children: [
                    // Text('Select the Stock',
                    //     style: TextStyle(
                    //         color: Color.fromARGB(255, 220, 221, 233),
                    //         fontSize: 0.055 * w,
                    //         fontFamily: 'Poppins',
                    //         fontWeight: FontWeight.w600)),
                    Consumer<poolProvider>(builder: (builder, value, child) {
                      // final provider =
                      //     Provider.of<searchPool>(context, listen: false);
                      return Container(
                        height: 0.041 * h,
                        width: 0.64 * w,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 30, 32, 51),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 0.030 * w),
                            Container(
                                height: 0.07 * h,
                                width: 0.04 * w,
                                child: SvgPicture.asset(
                                  'assests/search1.svg',
                                  height: 0.03 * h,
                                  width: 0.03 * w,
                                )),
                            SizedBox(width: 0.010 * w),
                            Expanded(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                onChanged: (value) =>
                                    provider.updatelist(value),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color.fromARGB(255, 220, 221, 233),
                                  fontSize: 0.032 * w,
                                  fontWeight: FontWeight.w300,
                                ),
                                // color: Color.fromARGB(255, 123, 123, 148)),
                                decoration: InputDecoration(
                                  // prefix: SvgPicture.asset(Images.wallet),
                                  // prefixIcon: Icon(
                                  //   Icons.search,
                                  //   color: Color.fromARGB(255, 220, 221, 233),
                                  //   weight: 1,
                                  // ),
                                  hintText: "Search for your favourite stocks",
                                  fillColor: Color.fromARGB(255, 31, 32, 51),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontFamily: 'Poppins',
                                      color:
                                          Color.fromARGB(255, 220, 221, 223)),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    // Spacer(),
                    FutureBuilder(
                        future: marketApi(widget.token),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var res = snapshot.data;
                            print(res);
                            var auth = res["auth"];
                            var status = res["status"];
                            return Container(
                              height: 0.0395 * h,
                              width: 0.26 * w,
                              child: Center(
                                  child: status == true
                                      ? Text(
                                          'Market Open',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              color: Color(0XFFFFFFFF),
                                              fontSize: 0.029 * w),
                                        )
                                      : Text(
                                          'Market Close',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              color: Color(0XFFFFFFFF),
                                              fontSize: 0.029 * w),
                                        )),
                              decoration: BoxDecoration(
                                color: status == true
                                    ? Color(0XFF24C9AB)
                                    : Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                    topLeft: Radius.circular(0),
                                    bottomLeft: Radius.circular(0)),
                              ),
                            );
                          } else {
                            return Text("");
                          }
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 0.02 * h,
              ),
              Flexible(
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 0.046 * w),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Consumer<poolProvider>(
                              builder: (builder, value, child) {
                            print("object");
                            print(value.mainList.isNotEmpty);
                            return ConstrainedBox(
                              constraints: BoxConstraints(minHeight: 0.7 * h),
                              child: Container(
                                  width: 0.9 * w,
                                  child: value.loader
                                      ? provider.homeListAuth
                                          ? value.mainList.isNotEmpty
                                              ? Column(
                                                  children: provider.mainList
                                                      .map(
                                                          (homePageStockList_modal
                                                                  data) =>
                                                              listCard(
                                                                context,
                                                                data,
                                                                widget.token,
                                                                value,
                                                              ))
                                                      .toList(),
                                                )
                                              : Center(
                                                  child: Text(
                                                    "No Pools Found!",
                                                    style: TextStyle(
                                                        fontSize: 0.045 * w,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        color: Colors.white),
                                                  ),
                                                )
                                          : SignUpButton(w, h)
                                      : loader(context, w, h)),
                            );
                          }),
                        ]);
                      }))
            ])));
  }
}
