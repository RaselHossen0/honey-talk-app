import 'dart:math';

import 'package:flutter/cupertino.dart';

class GenerateRandomName {
  static String onGenerate() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    final String name = List.generate(25, (index) => chars[random.nextInt(chars.length)]).join();
    debugPrint("Generate Random Name => $name");
    return name;
  }
}
