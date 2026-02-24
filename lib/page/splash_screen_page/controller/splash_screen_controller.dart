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
    await FetchSettingApi.callApi(uid: uid, token: token); // CALL ADMIN SETTING API

    if (FetchSettingApi.fetchSettingModel?.data != null) {
      await FetchLoginUserProfileApi.callApi(token: token, uid: uid); // CALL FETCH LOGIN USER PROFILE API
      if (FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user != null) {
        if (FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.isBlock == true) {
          Utils.showToast(text: EnumLocal.txtYouAreBlockedByAdmin.name.tr);
        } else {
          Get.offAllNamed(AppRoutes.bottomBarPage);
        }
      } else {
        Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
      }
    } else {
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
    }
  }
}
