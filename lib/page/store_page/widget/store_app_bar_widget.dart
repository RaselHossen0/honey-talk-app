import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class StoreAppBarWidget extends StatelessWidget {
  const StoreAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 50,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, right: 5),
      alignment: Alignment.topLeft,
      width: Get.width,
      color: AppColor.transparent,
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
                color: AppColor.white,
              ),
            ),
          ),
          Text(
            EnumLocal.txtMyStore.name.tr,
            style: AppFontStyle.styleW700(AppColor.white, 18),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.backpackPage)?.then(
              (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
            ),
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                AppAssets.icBag,
                width: 25,
                color: AppColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
