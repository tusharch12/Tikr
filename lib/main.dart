import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:tikr/Page/Home.dart';
import 'package:tikr/Page/Search%20page/searchPage.dart';
import 'package:tikr/Page/Setting%20Page/Setting_page.dart';
import 'package:tikr/Page/signIn.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tikr/class/secure_storage.dart';
import 'package:tikr/Page/Wallet/WalletPage.dart';
import 'package:tikr/provider/g1Provider.dart';
import 'package:tikr/provider/pool_provider.dart';
import 'package:tikr/provider/recentOrder.dart';
import 'package:tikr/provider/searchPool.dart';
import 'package:tikr/provider/timerCandle.dart';
import 'package:tikr/provider/timerprov.dart';

import 'Class/custom_candle.dart';
import 'Page/HomePage/Home_Page.dart';
import 'Page/Order page/order_Page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showNotification(message);
  });
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // var token = await secureStorage().getToken();

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    _navigateToItemDetail(message);
  });

  RemoteMessage? initialMessage1 =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    _navigateToItemDetail(initialMessage1!);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => timerCandle()),
        ChangeNotifierProvider(create: (context) => recentOrderPro()),
        ChangeNotifierProvider(create: (context) => timer()),
        ChangeNotifierProvider(create: (context) => poolProvider()),
        ChangeNotifierProvider(create: (context) => searchPool()),
        ChangeNotifierProvider(create: (context) => g1Provider()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          home:
              //  customChart()
              AuthSerive().handleAuthState()),
    );
  }
  // );
}

Future<void> _showNotification(RemoteMessage message) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      playSound: true,
      icon: 'notification_icon');
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
      message.notification?.body, platformChannelSpecifics,
      payload: 'item id 2');
}

void _navigateToItemDetail(RemoteMessage message) async {
  final type = message.data['type'];
  var token = await secureStorage().getToken();

  print("Type: $type");
  print("Token: $token");

  switch (type) {
    case 'orders':
      if (token == null) {
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => signin1()));
      } else {
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => My(token: token.toString())));
      }
      break;
    case 'wallet':
      if (token == null) {
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => signin1()));
      } else {
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => My(
                  token: token,
                )));
      }
      break;
    case 'home':
      if (token == null) {
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => signin1()));
      } else {
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => My(
                  token: token,
                )));
      }

      break;

    case 'profile':
      if (token == null) {
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => signin1()));
      } else {
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => My(
                  token: token,
                )));
      }

      break;
    case 'pool':
      if (token == null) {
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => signin1()));
      } else {
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => My(
                  token: token,
                )));
      }

      break;
    // handle other types...
  }
}
