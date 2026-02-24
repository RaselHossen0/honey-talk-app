import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/page/splash_screen_page/controller/splash_screen_controller.dart';
import 'package:tingle/utils/color.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashScreenController>();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColor.transparent,
      ),
    );
    return Scaffold(
        // body: Image.asset(
        //   AppAssets.imgLoginBg,
        //   fit: BoxFit.cover,
        //   height: Get.height,
        //   width: Get.width,
        // ),
        );
  }
}
