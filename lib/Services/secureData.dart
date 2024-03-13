import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class saveData {
  final storage = FlutterSecureStorage();

  void setTickVal(int set_val) async {
    await storage.write(key: 'tick_val', value: set_val.toString());
  }

  Future<String> getTickVal(keyToken) async {
    var tk = await storage.read(key: keyToken);

    if (tk == null) {
      return '1';
    } else {
      return tk;
    }
  }
}
