import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tingle/common/model/fetch_setting_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/utils.dart';

import '../page/login_page/model/fetch_login_user_profile_model.dart';
import 'constant.dart';

class Database {
  static final localStorage = GetStorage();

  static const String _searchUserHistory = "searchUserHistory";
  static const String _fakeProfileImage = "fakeProfileImage";

  static Future<void> init(String identity, String fcmToken) async {
    Utils.showLog("Local Database Initialize....");

    onSetFcmToken(fcmToken);
    onSetIdentity(identity);

    Utils.showLog("Is New User => $isNewUser");
  }

  // >>>>> >>>>> LOGIN DATABASE <<<<< <<<<<

  static String get fcmToken => localStorage.read("fcmToken") ?? "";
  static String get identity => localStorage.read("identity") ?? "";

  static onSetFcmToken(String fcmToken) async => await localStorage.write("fcmToken", fcmToken);
  static onSetIdentity(String identity) async => await localStorage.write("identity", identity);

  static bool get isNewUser => localStorage.read("isNewUser") ?? true;
  static int get loginType => localStorage.read("loginType") ?? 0;
  static String get loginUserId => localStorage.read("loginUserId") ?? "";

  static onSetIsNewUser(bool isNewUser) async => await localStorage.write("isNewUser", isNewUser);
  static onSetLoginType(int loginType) async => localStorage.write("loginType", loginType);
  static onSetLoginUserId(String loginUserId) async => localStorage.write("loginUserId", loginUserId);

  static int get onGetMyCoins => localStorage.read("coins") ?? 0;
  static onSetMyCoins(int coins) async => localStorage.write("coins", coins);

  // >>>>> >>>>> LOGIN USER PROFILE DATABASE <<<<< <<<<<

  static FetchLoginUserProfileModel? fetchLoginUserProfile() =>
      localStorage.read('loginUserProfile') != null ? FetchLoginUserProfileModel.fromJson(jsonDecode(localStorage.read('loginUserProfile') ?? "")) : null;

  static onSetLoginUserProfile(String loginUserProfile) async => localStorage.write("loginUserProfile", loginUserProfile);

  // >>>>> >>>>> ADMIN SETTING DATABASE <<<<< <<<<<

  static FetchSettingModel? fetchAdminSetting() => localStorage.read('adminSetting') != null ? FetchSettingModel.fromJson(jsonDecode(localStorage.read('adminSetting') ?? "")) : null;
  static onSetAdminSetting(String adminSetting) async => localStorage.write("adminSetting", adminSetting);

  // >>>>> >>>>> LANGUAGE DATABASE <<<<< <<<<<

  static String get selectedLanguage => localStorage.read("language") ?? AppConstant.languageEn;
  static String get selectedCountryCode => localStorage.read("countryCode") ?? AppConstant.countryCodeEn;

  static onSetSelectedLanguage(String language) async => await localStorage.write("language", language);
  static onSetSelectedCountryCode(String countryCode) async => await localStorage.write("countryCode", countryCode);

  // >>>>> >>>>> NETWORK IMAGE DATABASE <<<<< <<<<<

  static String? networkImage(String image) => localStorage.read(image);
  static onSetNetworkImage(String image) async => localStorage.write(image, image);

  static String get fakeProfileImage => localStorage.read(_fakeProfileImage) ?? "";
  static onSetFakeProfileImage(String image) async => localStorage.write(_fakeProfileImage, image);

  // >>>>> >>>>> NOTIFICATION DATABASE <<<<< <<<<<

  static bool get isShowNotification => localStorage.read("isShowNotification") ?? true;
  static onSetNotification(bool isShowNotification) async => localStorage.write("isShowNotification", isShowNotification);

  // >>>>> >>>>> Search User History Database <<<<< <<<<<

  static List get searchUserHistory => localStorage.read(_searchUserHistory) ?? [];
  static onSetSearchUserHistory(List searchUserHistory) async => localStorage.write(_searchUserHistory, searchUserHistory);

  // >>>>> >>>>> In App Purchase History Database <<<<< <<<<<

  static onSetIsPurchase(bool isPurchase) async => await localStorage.write("isPurchase", isPurchase);

  // >>>>> >>>>> Log Out User Database <<<<< <<<<<

  static Future<void> onLogOut() async {
    final backUpIdentity = identity;
    final backUpFcmToken = fcmToken;

    localStorage.erase();

    onSetFcmToken(backUpIdentity);
    onSetIdentity(backUpFcmToken);

    Get.offAllNamed(AppRoutes.loginPage);
  }
}
