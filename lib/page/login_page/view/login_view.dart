import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/login_page/widget/login_botton_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppAssets.imgLoginBg,
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: Image.asset(
              AppAssets.imgOnBoarding_3,
              height: 350,
              width: 350,
            ),
          ),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LoginButtonWidget(
                    image: AppAssets.icQuick,
                    title: EnumLocal.txtQuickLogIn.name.tr,
                    iconSize: 22,
                    callback: () => controller.onQuickLogin(),
                  ),
                  10.height,
                  LoginButtonWidget(
                    image: AppAssets.icGoogle,
                    iconSize: 24,
                    title: EnumLocal.txtLogInWithGoogle.name.tr,
                    callback: () => controller.onGoogleLogin(),
                  ),
                  20.height,
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        padding: const EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.white),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                      10.width,
                      Text(
                        EnumLocal.txtIHaveAcceptAllTermsAndCondition.name.tr,
                        style: AppFontStyle.styleW500(AppColor.white, 14),
                      ),
                    ],
                  ),
                  15.height,
                  RichText(
                    text: TextSpan(
                      text: EnumLocal.txtTermsAndCondition.name.tr,
                      style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      children: [
                        TextSpan(
                          text: " ${EnumLocal.txtAnd.name.tr} ",
                          style: const TextStyle(
                            color: AppColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        TextSpan(
                          text: EnumLocal.txtPrivacyPolicy.name.tr,
                          style: const TextStyle(
                            color: AppColor.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
