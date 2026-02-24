import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MoreOptionBottomSheet {
  static void show({
    required BuildContext context,
    required Callback reportCallBack,
    required Callback deleteCallBack,
    required Callback editCallBack,
  }) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: 220,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 65,
              color: AppColor.secondary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  50.width,
                  const Spacer(),
                  Text(
                    EnumLocal.txtMoreOption.name.tr,
                    style: AppFontStyle.styleW700(AppColor.black, 17),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondary.withValues(alpha: 0.6),
                      ),
                      child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            5.height,
            GestureDetector(
              onTap: editCallBack,
              child: Container(
                height: 50,
                color: AppColor.transparent,
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: Image.asset(
                          AppAssets.icEditPen,
                          width: 28,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    10.width,
                    Text(
                      EnumLocal.txtEdit.name.tr,
                      style: AppFontStyle.styleW600(AppColor.black, 17),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: reportCallBack,
              child: Container(
                height: 50,
                color: AppColor.transparent,
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: Image.asset(
                          AppAssets.icReportBorder,
                          width: 28,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    10.width,
                    Text(
                      EnumLocal.txtReport.name.tr,
                      style: AppFontStyle.styleW600(AppColor.black, 17),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: deleteCallBack,
              child: Container(
                height: 50,
                color: AppColor.transparent,
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: Image.asset(
                          AppAssets.icDeleteBorder,
                          width: 24,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    10.width,
                    Text(
                      EnumLocal.txtDelete.name.tr,
                      style: AppFontStyle.styleW600(AppColor.black, 17),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
