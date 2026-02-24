import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/edit_feed_page/controller/edit_feed_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class EditFeedAppBarWidget {
  static PreferredSizeWidget onShow(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top + 60),
      child: Container(
        height: MediaQuery.of(context).viewPadding.top + 60,
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        alignment: Alignment.center,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.white, boxShadow: [
          BoxShadow(color: AppColor.secondary.withValues(alpha: 0.2), spreadRadius: 2, blurRadius: 2),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(right: 30),
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                child: Image.asset(
                  AppAssets.icArrowLeft,
                  width: 10,
                ),
              ),
            ),
            Text(
              EnumLocal.txtEditPost.name.tr,
              style: AppFontStyle.styleW700(AppColor.black, 18),
            ),
            GetBuilder<EditFeedController>(
              id: AppConstant.onChangeImages,
              builder: (controller) => GestureDetector(
                onTap: controller.onUploadPost,
                child: Container(
                  height: 30,
                  width: 60,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: controller.postImages.isEmpty ? AppColor.lightGrayBg : AppColor.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    EnumLocal.txtEdit.name.tr,
                    style: AppFontStyle.styleW600(controller.postImages.isEmpty ? AppColor.secondary : AppColor.white, 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
