import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../class/contoller.dart';

class My extends StatefulWidget {
  My({super.key, required this.token});
  String token;
  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  late MainWrapperController _mainWrapperController =
      MainWrapperController(widget.token);
      bool _isFocused = false;
  @override
  void initState() {
    final MainWrapperController _mainWrapperController =
        Get.put(MainWrapperController(widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        allowImplicitScrolling: false,
        controller: _mainWrapperController.pageController,
        // physics: const BouncingScrollPhysics(),
        // onPageChanged: _mainWrapperController.animateToTab,
        children: [..._mainWrapperController.pages],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 17, 19, 31),
        elevation: 10,
        notchMargin: 0,
        child: Container(
          margin: EdgeInsets.only(
            left: 0.040 * w,
            right: 0.040 * w,
            // top: 0.03 * h,
            bottom: 0.02 * h,
          ),
          height: 0.076 * h,
          width: 0.923 * w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: GradientBoxBorder(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromARGB(255, 92, 95, 122),
                    Color.fromARGB(0, 0, 0, 0),
                  ])),
              color: Color.fromARGB(255, 30, 32, 51)
              // color: Colors.amber
              ),
          padding: EdgeInsets.symmetric(
            horizontal: 0.07 * w,
          ),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.amber,
                  //  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.017),
                  child: _bottomAppBarItem(
                    Text1: "assests/bottonNavigator/home.svg",
                    text2: "assests/bottonNavigator/home-1.svg",
                    page: 0,
                    context,
                    label: "Home",
                  ),
                ),
                Container(
                  //  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.017),
                  child: _bottomAppBarItem(
                    Text1: "assests/bottonNavigator/userplusS.svg",
                    text2: "assests/bottonNavigator/home-1.svg",
                    page: 1,
                    context,
                    label: "Home",
                  ),
                ),
                Container(
                  //  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.017),
                  child: _bottomAppBarItem(
                    Text1: "assests/bottonNavigator/cartS.svg",
                    text2: "assests/bottonNavigator/home-1.svg",
                    page: 2,
                    context,
                    label: "Home",
                  ),
                ),
                Container(
                  //  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.017),
                  child: _bottomAppBarItem(
                    Text1: "assests/bottonNavigator/settingS.svg",
                    text2: "assests/bottonNavigator/home-1.svg",
                    page: 3,
                    context,
                    label: "Home",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget _bottomAppBarItem(BuildContext context,
      {required Text1, required text2, required page, required label}) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return ZoomTapAnimation(
      onTap: () {
         if (!_isFocused) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _isFocused = true;
                    });
                  }
        _mainWrapperController.goToTab(page);
      },
      child: InkWell(
        child: Container(
          // color: Colors.amber,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          // color: Colors.amber,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Text1,
                color: _mainWrapperController.currentPage == page
                    ? Colors.red
                    : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
