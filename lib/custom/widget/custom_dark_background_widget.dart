import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDarkBackgroundWidget extends StatelessWidget {
  const CustomDarkBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF005EFF).withValues(alpha: 0.5),
            Color(0xFF0088FF).withValues(alpha: 0.5),
            Color(0xFFF0EFFF).withValues(alpha: 0.5),
            Color(0xFFF0EFFF),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
