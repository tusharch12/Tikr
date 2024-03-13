import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get_rx/src/rx_types/rx_types.dart";
import "package:get/get_state_manager/src/simple/get_controllers.dart";
import 'package:tikr/page/Setting%20Page/Setting_page.dart';
import "../Page/HomePage/Home_Page.dart";
import "../Page/Search page/searchPage.dart";
import '../page/Order page/order_page.dart';


class MainWrapperController extends GetxController {
  String token;
  late PageController pageController = PageController();

  RxInt currentPage = 0.obs;
  RxBool isDarkTheme = false.obs;

  MainWrapperController(this.token) {
    pages = [
      Builder(
        builder: (context) {
          return HomePage(token: token,);
        }
      ),
      searchPage(token: token),
      orderPage(token: token),
      settingPage(token: token),
    ];
  }
  late List<Widget> pages;
  void goToTab(int page) {
    HapticFeedback.lightImpact();
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    HapticFeedback.lightImpact();
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
// The instance member 'token' can't be accessed in an initializer.