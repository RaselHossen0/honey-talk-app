import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';

abstract class Utils {
  static RxBool isAppOpen = false.obs;

  static RxBool isCurrentlyVideoPage = true.obs;

  static RxBool isExtendBody = false.obs;

  static String defaultCountryName = "India";

  static String defaultCountryFlag = "🇮🇳";

  static void onChangeExtendBody(bool value) async {
    await 20.milliseconds.delay();
    isExtendBody.value = value;
  }

  static void showLog(String text) => log(text);

  static void showToast({
    required String text,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: backgroundColor ?? AppColor.primary,
      textColor: textColor ?? AppColor.white,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void onChangeStatusBar({required Brightness brightness, int? delay}) {
    Future.delayed(
      Duration(milliseconds: delay ?? 0),
      () => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: AppColor.transparent,
          statusBarIconBrightness: brightness,
        ),
      ),
    );
  }

  static void onGetRandomFakeImage() {
    final List fakeProfileImageList = FetchSettingApi.fetchSettingModel?.data?.profilePhotoList ?? [];
    int randomIndex = math.Random().nextInt(fakeProfileImageList.length);
    Database.onSetFakeProfileImage(fakeProfileImageList[randomIndex]);
  }

  static final int shortsDuration = 3000;

  // >>>>> >>>>> AGORA CREDENTIAL <<<<< <<<<<
  static String agoraAppId = "";
  static String agoraCertificate = "";
  static String agoraToken = "";
  static String agoraChannelId = "";

  // >>>>> >>>>> DEEP AR CREDENTIAL <<<<< <<<<<
  static final bool isShowReelsEffect = true;
  static final String effectAndroidLicenseKey = "";
  static final String effectIosLicenseKey = "";

  // >>>>> >>>>> CURRENCY <<<<< <<<<<
  static final String currencySymbol = "\$";
  static final String currencyCode = "USD";
  static final String countryCode = "USA";

  // >>>>> >>>>> Show Payment Method <<<<< <<<<<
  static final bool isShowStripePaymentMethod = true;
  static final bool isShowRazorPayPaymentMethod = true;
  static final bool isShowFlutterWavePaymentMethod = true;
  static final bool isShowInAppPurchasePaymentMethod = true;

  // >>>>> >>>>> RAZORPAY PAYMENT CREDENTIAL <<<<< <<<<<
  static String razorpayTestKey = "";

  // >>>>> >>>>> STRIPE PAYMENT CREDENTIAL <<<<< <<<<<
  static const String stripeUrl = "";

  static String stripeTestSecretKey = "";
  static String stripeTestPublicKey = "";

  // >>>>> >>>>> FLUTTER WAVE CREDENTIAL <<<<< <<<<<
  static String flutterWaveId = "";
}

extension HeightExtension on num {
  SizedBox get height => SizedBox(height: toDouble());
}

extension WidthExtension on num {
  SizedBox get width => SizedBox(width: toDouble());
}
