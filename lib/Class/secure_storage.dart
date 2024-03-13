import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Page/HomePage/Home_Page.dart';
import '../Page/Onboarding Page/onboarding_Page.dart';

// ignore: camel_case_types
class secureStorage {
  final storage = const FlutterSecureStorage();
  final String _keyToken = "token";
  Future setToken(String token) async {
    await storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    var tk = await storage.read(key: _keyToken);
    print(tk);
    return tk;
  }
}

class AuthSerive {
  handleAuthState() {
    return FutureBuilder(
        future: secureStorage().getToken(),
        builder: (context, snapshot) {
          print(snapshot.data);
          print(snapshot.hasData);
          if (snapshot.hasData) {
            String? token = snapshot.data;
            print(token);
            if (token == null) {
              return onboarding();
            } else {
              return ConnectivityChecker(token: token, index: 0);
            }
          } else {
            print("loader");
            return onboarding();
          }
        });
  }
}
