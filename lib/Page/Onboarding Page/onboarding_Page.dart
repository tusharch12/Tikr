import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tikr/Page/Onboarding%20Page/slider1_Page.dart';
import 'package:tikr/Page/Onboarding%20Page/slider2_Page.dart';
import 'package:tikr/Page/Onboarding%20Page/slider_page.dart';
import 'package:tikr/page/signIn.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/button.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../Wallet/WalletPage.dart';

class onboarding extends StatefulWidget {
  onboarding({Key? key}) : super(key: key);
  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  int _currentpage = 0;
  PageController _controller = PageController();
  List<Widget> _pages = [
    sliderpage(
        title:
            "We are a stock market based skilled gaming platform.\nTo predict candle colours!",
        description:
            "Simply add cash, join a pool or play with bot to withdraw cash rewards.",
        
        image: Images.arrow),
    sliderpage1(
        title: "No demat required.\nHighly safe.",
        description:
            "Its just a game where you apply technical skills! No hustle of broker or hefty documentation, you just need a phone number!",
        image: Images.s2),
    sliderpage1(
        title: "Min. Trade of ₹2.\nEasy withdrawl.",
        description:
            "Made for the traders to make high\nwith small. Allowing daily withdrawl of\nprofits in your wallet.",
        image: Images.s3),
    sliderpage2(
        title: "Easy to trade.\nLoved by millions.",
        description:
            "Trusted by all traders who win daily\nwith us. Simply predict and buy the\nticket, thats it.",
        image: Images.logo1),
  ];
  onChanged(int index) {
    setState(() {
      _currentpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: onChanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: (_currentpage == (_pages.length - 1))
                    ? ZoomTapAnimation(
                        onTap: () {
                          Get.to(() => signin1());
                        },
                        child: Button(title: "Start Playing"))
                    : Container(
                        color: Color.fromARGB(255, 17, 19, 31),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: ZoomTapAnimation(
                                onTap: () {
                                  Get.to(() => signin1());
                                },
                                child: Text(
                                  'Skip to sign up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      fontSize: 0.039 * width,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              'N E ',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 0.038 * width,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            ZoomTapAnimation(
                              onTap: () {
                                _controller.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOutQuint);
                              },
                              child: Container(
                                // color: Color.fromARGB(255, 17, 19, 31),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 227, 51, 66),
                                      Color.fromARGB(255, 182, 18, 103)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 222, 203, 195),
                                        Color.fromARGB(0, 222, 203, 195)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 7.9, 0, 7.9),
                                    constraints: BoxConstraints(
                                      maxWidth: 0.25 * width,
                                      minHeight: 0.002 * height,
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 0.3,
                                          ),
                                          Center(
                                            child: Text(
                                              "X T",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 0.038 * width,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 0.02 * width,
                                          ),
                                          SvgPicture.asset(
                                            Images.Arrow,
                                            height: 0.05 * width,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 0.03 * height,
            )
          ]),
        ],
      ),
    );
  }
}
