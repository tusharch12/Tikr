import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikr/Page/HomePage/Home_Page.dart';
import 'package:tikr/Page/Potrait%20Chart/popUp.dart';
import 'package:tikr/Services/sound_effect.dart';
import 'package:tikr/page/Potrait%20Chart/recentnew.dart';
import 'package:tikr/page/signIn.dart';
import 'package:tikr/provider/timerprov.dart';
import 'package:tikr/widget/popUp.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../Class/custom_candle.dart';
import 'package:tikr/widget/Images.dart';
import '../../Modals/StockChart/StockpriceList_modal.dart';
import '../../Services/secureData.dart';
import '../../Services/ticket_purchase.dart';
import '../../provider/g1Provider.dart';
import '../../provider/pool_provider.dart';
import '../../provider/timerCandle.dart';
import 'package:tikr/widget/textstyle.dart';
import '../../widget/CustomNotification.dart';
import '../../widget/ProfilePicWidget.dart';
import '../../widget/showCaseview.dart';
import '../Wallet/WalletPage.dart';
import '../g1new.dart';
import 'package:showcaseview/showcaseview.dart';

class potraitChart extends StatefulWidget {
  potraitChart({
    super.key,
    required this.dn,
    required this.data,
    required this.token,
    required this.state,
  });
  var state;
  String dn;
  String token;
  String data;
  @override
  State<potraitChart> createState() => _potraitChartState();
}

class _potraitChartState extends State<potraitChart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _ffirst = GlobalKey();
  final GlobalKey _first = GlobalKey();
  final GlobalKey _second = GlobalKey();
  final GlobalKey _third = GlobalKey();
  final GlobalKey _fourth = GlobalKey();
  final GlobalKey _fifth = GlobalKey();
  final GlobalKey _stockName = GlobalKey();
  final GlobalKey _orentation = GlobalKey();
  final GlobalKey _greencandle = GlobalKey();
  final GlobalKey _redcandle = GlobalKey();
  final GlobalKey _Predict = GlobalKey();
  final GlobalKey _timerCandle = GlobalKey();

  late SharedPreferences perference;
  int _num = 1;
  late Timer _timer;
  String formatted = "";
  bool time_interval = true;
  late WebSocketChannel channel_m1;
  late WebSocketChannel channel_m2;
  bool? isMarketOpen = true;
  int? buyTicket;

  @override
  void initState() {
    // audioCache = AudioCache(prefix: 'assets/audio/');
    super.initState();
    // pro = Provider.of<g1Provider>(context, listen: false).ticketValue();

    // pro.ticketValue();
    // _num = pro.value;

    // displayShowCase();
    displayShowCase().then((status) {
      print("object");
      print(status);
      if (status) {
        ShowCaseWidget.of(context)
            .startShowCase([_first, _second, _third, _fourth, _fifth]);
      }
    });

    channel_m2 = IOWebSocketChannel.connect(
      Uri.parse(
        'ws://34.204.28.184:8080/livedata/' +
            widget.token +
            '/2m/' +
            widget.data,
      ),
    );
    channel_m2.sink.close();
  }
// ticket val

// for time show at bottom
  predictTimer() async {
    var res = await marketApi(widget.token);
    isMarketOpen = res["status"];
    print("isMarketOpen from func :");
    print(isMarketOpen);
    isMarketOpen = true;
    if (isMarketOpen == true) {
      final provider = Provider.of<timer>(context, listen: false);
      // super.initState();
      var data = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      var data3 = data % 60;
      var data1 = (data - data3);
      var data2 = data1 + 60;

      // val = data2;
      double time = double.parse(data2.toString());
      // print(time);
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch((data2 * 1000).toInt()).toLocal();

      formatted = DateFormat('HH:mm a').format(dateTime);
      provider.setvalue(formatted);
      print("call initfunction P 2m");
    }
  }

// it is the show case widget
  displayShowCase() async {
    perference = await SharedPreferences.getInstance();
    bool? scVisibilityStatus = perference.getBool("isVisible");
    if (scVisibilityStatus == null) {
      perference.setBool("isVisible", false);
      return true;
    } else {
      return false;
    }
  }

  void dispose() {
    print("disConnect P");
    print(DateTime.now());
    channel_m1.sink.close();
    channel_m2.sink.close();
    super.dispose();
  }

// web socket for 1 min
  sc1m() {
    print("dis-2m");
    channel_m2.sink.close();
    print("connect - 1m");
    channel_m1 = IOWebSocketChannel.connect(
      Uri.parse(
        'ws://34.204.28.184:8080/livedata/' +
            widget.token +
            '/1m/' +
            widget.data,
      ),
    );
    print("1m p ");
    print(DateTime.now());
    // print(channel_m1.stream);
    return channel_m1.stream;
  }

// web socket 2 min
  sc2m() {
    channel_m1.sink.close();
    channel_m2 = IOWebSocketChannel.connect(
      Uri.parse(
        'ws://34.204.28.184:8080/livedata/' +
            widget.token +
            '/2m/' +
            widget.data,
      ),
    );
    print("2m p");
    print(DateTime.now());
    // print(channel_m2.stream);
    return channel_m2.stream;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    print("isMarketOpen :");
    print(isMarketOpen);
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 17, 19, 31),
        body: Stack(children: [
          SafeArea(
              minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
              child: ChangeNotifierProvider(
                  create: (context) => g1ProviderChartP(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 0.041 * h,
                          padding:
                              EdgeInsets.fromLTRB(0.043 * w, 0, 0.046 * w, 0),
                          child: Stack(alignment: Alignment.center, children: [
                            Positioned(
                              left: 0.00 * w,
                              child: ZoomTapAnimation(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    Images.back,
                                    height: 0.041 * h,
                                    width: 0.041 * w,
                                  )),
                            ),
                            Center(
                              child: Text(
                                widget.dn,
                                textAlign: TextAlign.center,
                                style: ResponsiveTextStyle.header(context),
                              ),
                            ),
                            Positioned(
                              right: 0.13 * w,
                              child: Showcase(
                                key: _ffirst,
                                description: "Check out your balance here 💰",
                                child: ZoomTapAnimation(
                                  onTap: () async {
                                    // playAudio();
                                    // final player = AudioPlayer();
                                    // player.play(
                                    //     AssetSource('purchase_effect.mp3'));
                                    Get.to(
                                        () => WalletPage(token: widget.token));
                                    HapticFeedback.lightImpact();
                                  },
                                  child: SvgPicture.asset(
                                    Images.wallet,
                                    height: 0.041 * h,
                                    width: 0.041 * w,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                right: 0.008 * w,
                                child: Showcase(
                                    key: _first,
                                    description:
                                        "You can play with Bot or play in any of the available public or private pools! 🙋🏻‍♂️",
                                    child: Consumer<poolProvider>(
                                        builder: (context, state, child) {
                                      if (state.isFlash == true) {
                                        Future.delayed(
                                            Duration(milliseconds: 500), () {
                                          state.flash_false(state.isFlash);
                                          print(state.isFlash);
                                        });
                                      }
                                      // print(state.poolName);
                                      return GestureDetector(
                                          onTap: () {
                                            HapticFeedback.lightImpact();
                                            Pool_popUP(
                                                context, widget.token, state);
                                          },
                                          child: FutureBuilder(
                                              future: state
                                                  .getPool_type("pool_type"),
                                              builder: (context, snapshot) {
                                                var pc = snapshot.data;
                                                return pc == "NA"
                                                    ? ClipOval(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        child: Image(
                                                            width: 0.071 * w,
                                                            // height: 0.041 * h,
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                              Images.exit_code,
                                                            )))
                                                    // )
                                                    : pc == "PUBLIC"
                                                        ? ClipOval(
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: SvgPicture
                                                                .asset(
                                                              Images.public,
                                                              fit: BoxFit.cover,
                                                              height: 0.041 * h,
                                                              width: 0.041 * w,
                                                              // height: 0.041 * h,
                                                              // height: 0.040 * h,
                                                            ))
                                                        : ClipOval(
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: SvgPicture
                                                                .asset(
                                                              Images.private,
                                                              fit: BoxFit.cover,
                                                              height: 0.041 * h,
                                                              width: 0.041 * w,
                                                              // height: 0.037 * h,
                                                            ));
                                              }),
                                          onLongPress: () async {
                                            var poolname = await state
                                                .getPool_name("pool_name");
                                            Clipboard.setData(
                                                ClipboardData(text: 'Message'));
                                            Future.delayed(
                                                Duration(milliseconds: 700),
                                                () {
                                              CustomMessageDisplay
                                                  customMessageDisplay =
                                                  CustomMessageDisplay(context);
                                              // Navigator.pop(context);

                                              //     state.getPool_name("pool_name"),
                                              // builder: (context, snapshot) {
                                              //   var pc = snapshot.data;
                                              //   print(pc);
                                              customMessageDisplay.showMessage(
                                                  poolname.toString());
                                            });
                                          }
                                          // return ProfilePic(context, widget.token, state);
                                          );
                                    }))),
                          ]),
                        ),

                        SizedBox(
                          height: 0.05 * h,
                        ),
                        ChangeNotifierProvider<g1ProviderChartP>(
                            create: (context) => g1ProviderChartP(),
                            child: ChangeNotifierProvider(
                              create: (context) => timerCandle(),
                              child: Consumer<g1ProviderChartP>(
                                  builder: (context, provide, child) {
                                final provider = Provider.of<g1ProviderChartP>(
                                    context,
                                    listen: false);
                                return Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.046 * w, 0, 0.046 * w, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 0.49 * h,
                                            width: 0.9 * w,
                                            child: StreamBuilder(
                                                stream: provider.is_min1
                                                    ? sc1m()
                                                    : sc2m(),
                                                builder: (context, snapshot) {
                                                  // print(provide.is_min1);
                                                  if (snapshot.hasData) {
                                                    var data = snapshot.data;
                                                    print(data.runtimeType);

                                                    var response_b = jsonDecode(
                                                        data as String);

                                                    // print("aa rha hai");
                                                    print(response_b);
                                                    // print(response_b[2]);
                                                    // print(response_b["auth"]);
                                                    if (response_b is Map &&
                                                        response_b.containsKey(
                                                            "auth")) {
                                                      if (response_b["auth"] ==
                                                          "false") {
                                                        return ZoomTapAnimation(
                                                          onTap: () {
                                                            HapticFeedback
                                                                .lightImpact();
                                                            Get.offAll(
                                                                signin1());
                                                          },
                                                          child: Center(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              constraints:
                                                                  BoxConstraints(
                                                                maxWidth:
                                                                    0.37 * w,
                                                                maxHeight:
                                                                    0.027 * h,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.pink,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color.fromARGB(
                                                                        255,
                                                                        100,
                                                                        180,
                                                                        103),
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            34,
                                                                            63,
                                                                            51)
                                                                  ],
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight,
                                                                ),
                                                                border:
                                                                    GradientBoxBorder(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color.fromARGB(
                                                                          255,
                                                                          100,
                                                                          203,
                                                                          195),
                                                                      Color.fromARGB(
                                                                          0,
                                                                          222,
                                                                          203,
                                                                          195)
                                                                    ],
                                                                    begin: Alignment
                                                                        .centerLeft,
                                                                    end: Alignment
                                                                        .centerRight,
                                                                  ),
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                "Login to continue",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        0.04 *
                                                                            w),
                                                              )),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Center(
                                                          child: Text(
                                                            "chart is not available",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    0.045 * w,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      List<dynamic> data1 =
                                                          jsonDecode(
                                                              data.toString());

                                                      var n = data1.length;
                                                      // print(n);
                                                      // for (int i = 0; i < 9; i++) {
                                                      //   List <dynamic>data2 = data1[]
                                                      // }
                                                      var minX = data1[0]
                                                              ["Datetime"] -
                                                          60000;
                                                      var maxX = data1[8]
                                                              ["Datetime"] +
                                                          60000;
                                                      var lastCandle;
                                                      if (data1[7]["Datetime"] -
                                                              data1[6][
                                                                  "Datetime"] ==
                                                          60000)
                                                        lastCandle = data1[8]
                                                                ["Datetime"] +
                                                            60000;
                                                      else {
                                                        lastCandle = data1[8]
                                                                ["Datetime"] +
                                                            120000;
                                                      }
                                                      print(lastCandle);
                                                      List<ChartData>
                                                          _getChart = data1
                                                              .map(
                                                                (e) => ChartData
                                                                    .fromjson(
                                                                        e),
                                                              )
                                                              .toList();
                                                      // print(_getChart);
                                                      return customChart(
                                                        data: _getChart,
                                                        lastCandle: lastCandle,
                                                      );
                                                    }
                                                  } else {
                                                    return Center(
                                                        child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0.03 * w,
                                                              0,
                                                              0.03 * w,
                                                              0),
                                                      child: Center(
                                                          child:
                                                              SpinKitThreeBounce(
                                                        size: 40,
                                                        color: Colors.white,
                                                      )),
                                                    ));
                                                  }
                                                }),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.02 * h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Showcase(
                                            key: _third,
                                            description:
                                                "Check out your recent trades here 📝",
                                            titleTextStyle: TextStyle(
                                                fontSize: 0.03 * w,
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                            child: ZoomTapAnimation(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                Get.to(() => recentNew(
                                                    token: widget.token));
                                              },
                                              child: SvgPicture.asset(
                                                'assests/shoppingbag1.svg',
                                                height: 0.032 * h,
                                                width: 0.032 * w,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 0.10 * w,
                                          // ),
                                          SizedBox(
                                            width: 0.05 * w,
                                          ),
                                          Showcase(
                                            key: _fourth,
                                            description:
                                                "You can choose from any of the candle interval ⏱️",
                                            titleTextStyle: TextStyle(
                                                fontSize: 0.03 * w,
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            height: 0.045 * h,
                                                            width: 0.28 * w),
                                                    child: ElevatedButton(
                                                      child: Center(
                                                        child: Text(
                                                          '1m',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  0.035 * w,
                                                              fontFamily:
                                                                  'Poppins',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      220,
                                                                      221,
                                                                      223)),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        HapticFeedback
                                                            .lightImpact();
                                                        Provider.of<timerCandle>(
                                                                context,
                                                                listen: false)
                                                            .Min1();
                                                        if (provide.is_min1 ==
                                                            false) {
                                                          provide.Min1();
                                                          if (isMarketOpen ==
                                                              true)
                                                            Provider.of<timer>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .Min1();
                                                          time_interval =
                                                              provide.is_min1;
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: provide
                                                                .is_min1
                                                            ? Color.fromARGB(
                                                                255,
                                                                31,
                                                                71,
                                                                211)
                                                            : Color.fromARGB(
                                                                255,
                                                                31,
                                                                32,
                                                                51),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 0.023 * w,
                                                  ),
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            height: 0.045 * h,
                                                            width: 0.28 * w),
                                                    child: ElevatedButton(
                                                      child: Center(
                                                        child: Text(
                                                          '2m',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  0.035 * w,
                                                              fontFamily:
                                                                  'Poppins',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      220,
                                                                      221,
                                                                      223)),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        HapticFeedback
                                                            .lightImpact();
                                                        Provider.of<timerCandle>(
                                                                context,
                                                                listen: false)
                                                            .min2();
                                                        if (provide.is_min1 ==
                                                            true) {
                                                          print("2min");
                                                          provide.min2();
                                                          // if(isMarketOpen==true)
                                                          Provider.of<timer>(
                                                                  context,
                                                                  listen: false)
                                                              .min2();
                                                          time_interval =
                                                              provide.is_min1;
                                                          print(
                                                              provide.is_min1);
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: provide
                                                                .is_min1
                                                            ? Color.fromARGB(
                                                                255, 31, 32, 51)
                                                            : Color.fromARGB(
                                                                255,
                                                                31,
                                                                71,
                                                                211),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 0.05 * w,
                                          ),
                                          Showcase(
                                            key: _fifth,
                                            description:
                                                "Click to play in landscape mode to predict future timings 🤳🏻",
                                            child: ZoomTapAnimation(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                // final isP =
                                                //     MediaQuery.of(context)
                                                //             .orientation ==
                                                //         Orientation.portrait;

                                                // if (isP) {
                                                //   setL();
                                                // } else {
                                                //   setP();
                                                // }
                                              },
                                              child: SvgPicture.asset(
                                                'assests/rotate2.svg',
                                                height: 0.032 * h,
                                                width: 0.032 * w,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                            )),
                        // ),
                        SizedBox(height: 0.025 * h),
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                          child: Text(
                            "Number of Tickets",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 0.04 * w,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 220, 221, 223)),
                          ),
                        ),
                        SizedBox(height: 0.025 * h),
                        ChangeNotifierProvider<g1Provider>(
                          create: (context) => g1Provider(),
                          child: Consumer<g1Provider>(
                            builder: (context, provider, child) {
                              buyTicket = provider.value;
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0.046 * w, 0, 0.046 * w, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ZoomTapAnimation(
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          provider.des_num();
                                        },
                                        child: SvgPicture.asset(
                                          'assests/minus.svg',
                                          height: 0.032 * h,
                                          width: 0.032 * w,
                                        )),
                                    SizedBox(
                                      width: 0.05 * w,
                                    ),
                                    Container(
                                        height: 0.045 * h,
                                        width: 0.583 * w,

                                        // width: 0.55 * w,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 30, 32, 51),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                          provider.value == null
                                              ? ''
                                              : provider.value.toString(),
                                          style: TextStyle(
                                              fontSize: 0.045 * w,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ))
                                        //  FutureBuilder(
                                        //     future:
                                        //         saveData().getTickVal('tick_val'),
                                        //     builder:
                                        //         (BuildContext context, snapshot) {
                                        //       if (snapshot.hasData) {
                                        //         print("1");
                                        //         var num1 = snapshot.data;
                                        //         _num = int.parse(num1.toString());
                                        //         return Center(
                                        //             child: Text(
                                        //           _num.toString(),
                                        //           style: TextStyle(
                                        //               fontSize: 0.045 * w,
                                        //               fontFamily: 'Poppins',
                                        //               fontWeight: FontWeight.w400,
                                        //               color: Colors.white),
                                        //         ));
                                        //       } else {
                                        //         return Text('');
                                        //       }
                                        //     }),
                                        ),
                                    SizedBox(
                                      width: 0.05 * w,
                                    ),
                                    ZoomTapAnimation(
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          provider
                                              .increase_num(provider.value!); //
                                          _num = provider.value!;
                                        },
                                        child: SvgPicture.asset(
                                          'assests/plus.svg',
                                          height: 0.032 * h,
                                          width: 0.032 * w,
                                        )),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 0.025 * h),
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                          child: Row(
                            children: [
                              ZoomTapAnimation(
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  // CustomMessageDisplay customMessageDisplay =
                                  //     CustomMessageDisplay(context);
                                  // customMessageDisplay
                                  //     .showMessage("Loading . . .");

                                  final date = Provider.of<timer>(context,
                                      listen: false);
                                  date.currTime();
                                  popUp1(
                                      context,
                                      "hello",
                                      date,
                                      "green",
                                      widget.dn,
                                      buyTicket,
                                      time_interval,
                                      widget.token,
                                      widget.state);
                                  // if (res["statusCode"] == 201 &&
                                  //     res["body"]["data"]["player_type"] ==
                                  //         "BOT") {
                                  //   sound_effect().onPurchase_play();
                                  //   popUp(context, res["body"]["data"]);
                                  // } else if (res["statusCode"] == 201 &&
                                  //         (res["body"]["data"]["pool_type"] ==
                                  //                 "PUBLIC" ||
                                  //             res["body"]["data"]
                                  //                     ["pool_type"] ==
                                  //                 "PRIVATE")
                                  //     //          ||
                                  //     // res["body"]["data"]["player_type"] ==
                                  //     //     "PRIVATE"
                                  //     ) {
                                  //   sound_effect().onPurchase_play();
                                  //   popUp(context, res["body"]["data"]);
                                  // } else {
                                  //   Future.delayed(Duration(milliseconds: 800),
                                  //       () {
                                  //     // Navigator.pop(context);
                                  //     CustomMessageDisplay
                                  //         customMessageDisplay =
                                  //         CustomMessageDisplay(context);
                                  //     customMessageDisplay
                                  //         .showMessage(res["msg"]);
                                  //   });
                                  // }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 36, 201, 171),
                                  ),
                                  height: 0.05 * h,
                                  width: 0.44 * w,
                                  child: Center(
                                    child: Text(
                                      'Green',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 0.04 * w,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              ZoomTapAnimation(
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  final date = Provider.of<timer>(context,
                                      listen: false);
                                  date.currTime();

                                  popUp1(
                                      context,
                                      "hello",
                                      date,
                                      "red",
                                      widget.dn,
                                      buyTicket,
                                      time_interval,
                                      widget.token,
                                      widget.state);
                                  // CustomMessageDisplay customMessageDisplay =
                                  //     CustomMessageDisplay(context);
                                  // customMessageDisplay
                                  //     .showMessage("Loading . . .");
                                  // var res = await ticket_purchase(
                                  //     "red",
                                  //     widget.dn,
                                  //     _num,
                                  //     time_interval,
                                  //     widget.token,
                                  //     widget.state);

                                  // print(res["statusCode"]);
                                  // print(res["body"]["data"]["player_type"]);
                                  // var name = ((res["statusCode"] == 201 &&
                                  //         res["body"]["data"]["player_type"] ==
                                  //             "PUBLIC" ||
                                  //     res["body"]["data"]["player_type"] ==
                                  //         "PRIVATE"));
                                  // print(name);
                                  // if (res["statusCode"] == 201 &&
                                  //     res["body"]["data"]["player_type"] ==
                                  //         "BOT") {
                                  //   sound_effect().onPurchase_play();
                                  //   popUp(context, res["body"]["data"]);
                                  // } else if (res["statusCode"] == 201 &&
                                  //         (res["body"]["data"]["pool_type"] ==
                                  //                 "PUBLIC" ||
                                  //             res["body"]["data"]
                                  //                     ["pool_type"] ==
                                  //                 "PRIVATE")
                                  //     //          ||
                                  //     // res["body"]["data"]["player_type"] ==
                                  //     //     "PRIVATE"
                                  //     ) {
                                  //   sound_effect().onPurchase_play();
                                  //   // popUp(context, res["body"]["data"]);
                                  //   ;
                                  // } else {
                                  //   Future.delayed(Duration(milliseconds: 700),
                                  //       () {
                                  //     // Navigator.pop(context);
                                  //     CustomMessageDisplay
                                  //         customMessageDisplay =
                                  //         CustomMessageDisplay(context);
                                  //     customMessageDisplay
                                  //         .showMessage(res["msg"]);
                                  //   });
                                  // }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                  ),
                                  height: 0.05 * h,
                                  width: 0.44 * w,
                                  child: Center(
                                    child: Text(
                                      'Red',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 0.04 * w,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: 125,
                              // ),
                              Spacer(),
                              FutureBuilder(
                                  future: marketApi(widget.token),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var data = snapshot.data;
                                      var isOpen = data["status"];

                                      // isOpen =true;
                                      return isOpen
                                          ? Consumer<timer>(
                                              builder: (context, value, child) {
                                              if (!mounted) {
                                                return Text("disposed ");
                                              } else {
                                                _timer = Timer.periodic(
                                                    Duration(seconds: 1),
                                                    (timer) {
                                                  value.currTime();
                                                });

                                                return Center(
                                                    child: Text(
                                                  "Predict for " +
                                                      value.formattedDate,
                                                  // textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 0.04 * w,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ));
                                              }
                                            })
                                          : Center(
                                              child: Text(
                                              "Trading closed for today",
                                              style: TextStyle(
                                                  fontSize: 0.04 * w,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ));
                                    } else {
                                      return Text("");
                                    }
                                  }),

                              Spacer(),
                              Showcase(
                                key: _stockName,
                                description:
                                    "Click to start the tutorial again 🔁",
                                titleTextStyle: TextStyle(
                                    fontSize: 0.03 * w,
                                    fontFamily: 'Poppins',
                                    color: Colors.white),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: ZoomTapAnimation(
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        ShowCaseWidget.of(context)
                                            .startShowCase([
                                          _ffirst,
                                          _first,
                                          _second,
                                          _third,
                                          _fourth,
                                          _fifth,
                                          _stockName,
                                        ]);
                                      },
                                      mini: true,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: Colors.white,
                                      tooltip: "start tutorial",
                                      child: Center(
                                        child: Icon(
                                          Icons.question_mark,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 20,
                              // )
                            ],
                          ),
                        ),
                        Spacer(),
                      ])))
        ]));
  }
}
