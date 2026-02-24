import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/custom/function/custom_fetch_random_name.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/anonymous_authentication.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/firebase/authentication/google_authentication.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/page/login_page/api/login_api.dart';
import 'package:tingle/page/login_page/model/login_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class LoginController extends GetxController {
  LoginModel? loginModel;

  String randomName = "";

  @override
  void onInit() {
    randomName = CustomFetchRandomName.onGet();
    super.onInit();
  }

  void onQuickLogin() async {
    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

    await AnonymousAuthentication.signInWithAnonymous(); // Anonymous Login...

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    loginModel = await LoginApi.callApi(
      loginType: 3, // Quick Login
      identity: Database.identity,
      fcmToken: Database.fcmToken,
      email: Database.identity,
      uid: uid ?? "",
      token: token ?? "",
      name: randomName,
      userName: "@${randomName.replaceAll(' ', '').trim().toLowerCase()}",
    );

    Get.back(); // Stop Loading...

    if (loginModel?.status == true) {
      onGetProfile(token: token ?? "", uid: uid ?? "");
    } else {
      Utils.showLog(loginModel?.message ?? "");
    }
  }

  void onGoogleLogin() async {
    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

    UserCredential? userCredential = await GoogleAuthentication.signInWithGoogle(); // Google Login...

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    if (userCredential?.user?.email != null && userCredential?.user?.displayName != null && userCredential?.user?.photoURL != null) {
      loginModel = (userCredential?.additionalUserInfo?.isNewUser == false)
          ? await LoginApi.callApi(
              loginType: 2, // Google Login
              identity: Database.identity,
              fcmToken: Database.fcmToken,
              email: userCredential?.user?.email ?? "",
              uid: uid ?? "",
              token: token ?? "",
            )
          : await LoginApi.callApi(
              loginType: 2, // Google Login
              identity: Database.identity,
              fcmToken: Database.fcmToken,
              email: userCredential?.user?.email ?? "",
              name: userCredential?.user?.displayName ?? "",
              userName: "@${(userCredential?.user?.displayName ?? "").replaceAll(' ', '').trim().toLowerCase()}",
              image: userCredential?.user?.photoURL ?? "",
              uid: uid ?? "",
              token: token ?? "",
            );

      Get.back(); // Stop Loading...

      if (loginModel?.status == true) {
        onGetProfile(token: token ?? "", uid: uid ?? "");
      } else {
        Utils.showLog(loginModel?.message ?? "");
      }
    } else {
      Utils.showToast(text: EnumLocal.txtGoogleLoginFailed.name.tr);
      Get.back(); // Stop Loading...
    }
  }

  void onGetProfile({required String token, required String uid}) async {
    await FetchSettingApi.callApi(uid: uid, token: token); // CALL ADMIN SETTING API

    if (FetchSettingApi.fetchSettingModel?.data != null) {
      await FetchLoginUserProfileApi.callApi(token: token, uid: uid);

      if (FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.id != null) {
        // >>>> >>>>> Store In Local Database <<<<< <<<<<

        Database.onSetIsNewUser(false);
        Database.onSetLoginUserId(FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.id ?? "");
        Database.onSetLoginType(FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.loginType ?? 0);

        Get.toNamed(AppRoutes.fillProfilePage)?.then((value) => Utils.onChangeStatusBar(brightness: Brightness.light));
      }
    }
  }
}
