import 'dart:async';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class SplashScreenController extends GetxController {
  String uid = "";
  String token = "";

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    uid = FirebaseUid.onGet() ?? "";
    token = await FirebaseAccessToken.onGet() ?? "";

    await splashScreen();
  }

  Future<void> splashScreen() async {
    Timer(
      const Duration(milliseconds: 100),
      () async {
        if (Database.isNewUser) {
          Get.offAllNamed(AppRoutes.loginPage);
        } else {
          await onGetProfile();
        }
      },
    );
  }

  Future<void> onGetProfile() async {
    if (uid.isEmpty || token.isEmpty) {
      Utils.showLog("Splash: No uid or token - redirect to login");
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
      Database.onSetIsNewUser(true);
      Get.offAllNamed(AppRoutes.loginPage);
      return;
    }

    await FetchSettingApi.callApi(uid: uid, token: token);

    if (FetchSettingApi.fetchSettingModel?.data == null) {
      Utils.showLog("Splash: Settings API failed - check API URL (${Database.accessToken.isEmpty ? 'no token' : 'has token'})");
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
      Get.offAllNamed(AppRoutes.loginPage);
      return;
    }

    await FetchLoginUserProfileApi.callApi(token: token, uid: uid);

    if (FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user == null) {
      Utils.showLog("Splash: User profile API failed - token may be expired");
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
      Get.offAllNamed(AppRoutes.loginPage);
      return;
    }

    if (FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.isBlock == true) {
      Utils.showToast(text: EnumLocal.txtYouAreBlockedByAdmin.name.tr);
      return;
    }

    // Show fill profile only when profile is incomplete (first-time / placeholder)
    if (!_isProfileComplete) {
      Get.offAllNamed(AppRoutes.fillProfilePage);
      return;
    }

    Get.offAllNamed(AppRoutes.bottomBarPage);
  }

  bool get _isProfileComplete {
    final user = FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user;
    if (user == null) return false;
    final un = (user.userName ?? '').trim();
    final age = user.age ?? 0;
    if (un.isEmpty || age <= 0) return false;
    if (RegExp(r'^user_\d+$').hasMatch(un)) return false;
    return true;
  }
}
