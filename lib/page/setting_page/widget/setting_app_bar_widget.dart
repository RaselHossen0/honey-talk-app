import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class SettingAppBarWidget {
  static PreferredSizeWidget onShow(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top + 50),
      child: Container(
        height: MediaQuery.of(context).viewPadding.top + 50,
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        alignment: Alignment.center,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(color: AppColor.secondary.withValues(alpha: 0.15), spreadRadius: 2, blurRadius: 2),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                child: Image.asset(
                  AppAssets.icArrowLeft,
                  width: 10,
                ),
              ),
            ),
            Text(
              EnumLocal.txtSettings.name.tr,
              style: AppFontStyle.styleW600(AppColor.black, 16),
            ),
            45.width,
          ],
        ),
      ),
    );
  }
}
