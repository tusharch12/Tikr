import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tikr/Page/Setting%20Page/Editprofile.dart';
import 'package:tikr/Page/Setting%20Page/contactus.dart';
import 'package:tikr/Page/Pool%20page/Pool_Page.dart';
import 'package:tikr/Page/Setting%20Page/privacypolicy.dart';
import 'package:tikr/Page/Setting%20Page/ticketSize.dart';
import 'package:tikr/Page/signIn.dart';
import 'package:tikr/Page/Setting%20Page/termsndcondition.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/button.dart';
import 'package:tikr/widget/signUpButton.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../Services/secureData.dart';
import '../../provider/recentOrder.dart';
import '../../theme/decoration.dart';
import 'package:http/http.dart' as http;
import '../Wallet/WalletPage.dart';
import 'FAQ.dart';

Future<Map<String, dynamic>> getUserIdApi(String token) async {
  final String getUserIdUrl = "http://34.204.28.184:8000/getuserid";
  var client = http.Client();
  var map = Map<String, dynamic>();
  try {
    var res = await client.post(
      Uri.parse(getUserIdUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      map["statusCode"] = res.statusCode;
      map["body"] = res.body;
      // print(res.body);
      return map;
    } else {
      throw Exception('Failed to get user ID');
    }
  } catch (e) {
    throw Exception('Failed to get user ID: $e');
  } finally {
    client.close();
  }
}

class settingPage extends StatefulWidget {
  settingPage({super.key, required this.token});
  String token;

  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  @override
  void initState() {
    final provider = Provider.of<recentOrderPro>(context, listen: false);
    provider.ProfileApiCall(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final provider = Provider.of<recentOrderPro>(context, listen: false);
    provider.ProfileApiCall(widget.token);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZoomTapAnimation(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Get.to(() => wallt(token: widget.token));
                      },
                      child: SvgPicture.asset(
                        Images.wallet,
                        height: 0.041 * h,
                        width: 0.041 * w,
                      )),
                  Expanded(
                    child: Center(
                        child: Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: ResponsiveTextStyle.header(context),
                    )),
                  ),
                  ZoomTapAnimation(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Share.share(
                            "Hi! Join me on Tikr99 and get Rs 20 for FREE, to trade and earn on this real stock market game!");
                      },
                      child: SvgPicture.asset(
                        Images.share,
                        height: 0.041 * h,
                        width: 0.041 * w,
                      )),
                ],
              ),
            ),
            Scrollbar(
              child: Container(
                height: 0.8 * h,
                padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: SvgPicture.asset(
                        Images.profile,
                      ),
                    ),
                    Center(
                      child: Text('Phone Number',
                          style: ResponsiveTextStyle.headline1(context)),
                    ),
                    Consumer<recentOrderPro>(builder: (context, value, child) {
                      return provider.Profileloader
                          ? provider.profileAuth
                              ? Container(
                                  // width: 0.17 * w,
                                  child: Center(
                                    child: GradientText(
                                      value.profileResBody.data["userid"]!,
                                      style: TextStyle(
                                          fontSize: 0.065 * w,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins'),
                                      colors: [
                                        const Color.fromARGB(255, 0, 220, 207),
                                        const Color.fromARGB(255, 142, 88, 255)
                                      ],
                                    ),
                                  ),
                                )
                              : SignUpButton(w, h)
                          : loader(context, w, h);
                    }),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Text('Your Profile',
                        style: ResponsiveTextStyle.get(context)),
                    SizedBox(
                      height: 0.01 * h,
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Get.to(() => edit(
                              token: widget.token,
                            ));
                      },
                      child: Container(
                          height: 0.065 * h,
                          width: 0.9 * w,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 0.15 * w,
                              ),
                              Text('Edit Pofile',
                                  style: ResponsiveTextStyle.profile(context)),
                              Spacer(),
                              SvgPicture.asset('assests/Rightarrow.svg'),
                              SizedBox(
                                width: 0.08 * w,
                              )
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
                                    Color.fromARGB(255, 37, 41, 41),
                                    Color.fromARGB(0, 30, 32, 51)
                                  ]))),
                    ),
                    SizedBox(
                      height: 0.013 * h,
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Pools(token: widget.token)));
                      },
                      child: Container(
                        height: 0.065 * h,
                        width: 0.9 * w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.15 * w,
                            ),
                            Text('Pools',
                                style: ResponsiveTextStyle.profile(context)),
                            Spacer(),
                            SvgPicture.asset('assests/Rightarrow.svg'),
                            SizedBox(
                              width: 0.08 * w,
                            )
                          ],
                        ),
                        decoration: decoration(),
                      ),
                    ),
                    SizedBox(
                      height: 0.013 * h,
                    ),
                    ZoomTapAnimation(
                      onTap: () async {
                        HapticFeedback.lightImpact();
                        var def_val = await saveData().getTickVal('tick_val');
                        print(def_val.runtimeType);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ticketSize(
                                token: widget.token, def_val: def_val)));
                      },
                      child: Container(
                        height: 0.065 * h,
                        width: 0.9 * w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.15 * w,
                            ),
                            Text('Ticket Size',
                                style: ResponsiveTextStyle.profile(context)),
                            Spacer(),
                            SvgPicture.asset('assests/Rightarrow.svg'),
                            SizedBox(
                              width: 0.08 * w,
                            )
                          ],
                        ),
                        decoration: decoration(),
                      ),
                    ),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Text('Other Options',
                        style: ResponsiveTextStyle.get(context)),
                    SizedBox(
                      height: 0.01 * h,
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Get.to(() => fandq(
                              token: widget.token,
                            ));
                      },
                      child: Container(
                        height: 0.065 * h,
                        width: 0.9 * w,
                        decoration: decoration(),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.15 * w,
                            ),
                            Text('FAQs',
                                style: ResponsiveTextStyle.profile(context)),
                            Spacer(),
                            SvgPicture.asset('assests/Rightarrow.svg'),
                            SizedBox(
                              width: 0.08 * w,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.013 * h,
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Get.to(() => terms());
                      },
                      child: Container(
                        height: 0.065 * h,
                        width: 0.9 * w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.15 * w,
                            ),
                            Text('Terms & Conditions',
                                style: ResponsiveTextStyle.profile(context)),
                            Spacer(),
                            SvgPicture.asset('assests/Rightarrow.svg'),
                            SizedBox(
                              width: 0.08 * w,
                            )
                          ],
                        ),
                        decoration: decoration(),
                      ),
                    ),
                    SizedBox(
                      height: 0.013 * h,
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Get.to(() => privacy());
                      },
                      child: Container(
                        height: 0.065 * h,
                        width: 0.9 * w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.15 * w,
                            ),
                            Text('Privacy Policy',
                                style: ResponsiveTextStyle.profile(context)),
                            Spacer(),
                            SvgPicture.asset('assests/Rightarrow.svg'),
                            SizedBox(
                              width: 0.08 * w,
                            )
                          ],
                        ),
                        decoration: decoration(),
                      ),
                    ),
                    SizedBox(
                      height: 0.013 * h,
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => contact(
                                  token: widget.token,
                                )));
                      },
                      child: Container(
                        height: 0.065 * h,
                        width: 0.9 * w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.15 * w,
                            ),
                            Text('Contact us',
                                style: ResponsiveTextStyle.profile(context)),
                            Spacer(),
                            SvgPicture.asset('assests/Rightarrow.svg'),
                            SizedBox(
                              width: 0.08 * w,
                            ),
                          ],
                        ),
                        decoration: decoration(),
                      ),
                    ),
                    SizedBox(
                      height: 0.013 * h,
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Pop1(context, widget.token);
                      },
                      child: Container(
                        height: 0.065 * h,
                        width: 0.9 * w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.15 * w,
                            ),
                            Text('Logout',
                                style: ResponsiveTextStyle.profile(context)),
                            Spacer(),
                            SvgPicture.asset('assests/Rightarrow.svg'),
                            SizedBox(
                              width: 0.08 * w,
                            ),
                          ],
                        ),
                        decoration: decoration(),
                      ),
                    ),
                    SizedBox(
                      height: 0.01 * h,
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
    // );
  }
}

void Pop1(context, token) {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  showModalBottomSheet(
      isDismissible: true,
      backgroundColor: Color(0XFF1E2033),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bc).viewInsets.bottom,
          ),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.04 * w),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 30, 32, 51),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0.02 * w,
                    ),
                    Image.asset(Images.conatiner),
                    Row(
                      children: [
                        ZoomTapAnimation(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(Images.cross)),
                        // SizedBox(
                        //   width: 0.25 * w,
                        // ),
                        // Spacer(),
                        // ZoomTapAnimation(
                        //     onTap: () async {
                        //       HapticFeedback.lightImpact();
                        //       // copyToClipboard(data.pool_code);
                        //       // await Clipboard.setData(
                        //       //     ClipboardData(text: data.pool_code));
                        //     },
                        //     child: SvgPicture.asset(Images.copy)),
                      ],
                    ),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    // SizedBox(
                    //   height: 0.05 * w,
                    // ),
                    Image.asset(
                      Images.logout,
                      width: 0.2 * w,
                    ),
                    Text(
                      'Are you sure?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.05 * w,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 220, 221, 223)),
                    ),
                    SizedBox(
                      height: 0.02 * w,
                    ),
                    Text(
                      'Sad to see you go away 😢',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 0.04 * w,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 220, 221, 223)),
                    ),
                    SizedBox(
                      height: 0.05 * h,
                    ),
                    ZoomTapAnimation(
                        onTap: () async {
                          HapticFeedback.lightImpact();
                          final storage = const FlutterSecureStorage();
                          var tk = await storage.read(key: "token");
                          await storage.write(key: 'token', value: null);
                          await storage.delete(key: "player_type");
                          await storage.delete(key: "pool_code");
                          await storage.delete(key: "pool_type");
                          Get.offAll(() => signin1());
                        },
                        child: Button(title: 'Logout')),
                    SizedBox(
                      height: 0.03 * h,
                    ),
                  ],
                ),
              )),
        );
      });
}
