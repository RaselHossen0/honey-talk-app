import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tingle/utils/color.dart';

class CustomRandomLightColor {
  static Color onGet() {
    List<Color> colors = [
      AppColor.color_1,
      AppColor.color_3,
      AppColor.color_4,
      AppColor.color_7,
      AppColor.color_8,
      AppColor.color_9,
      AppColor.color_10,
      AppColor.color_11,
      AppColor.color_12,
    ];

    final random = Random();
    return colors[random.nextInt(colors.length)];
  }
}
