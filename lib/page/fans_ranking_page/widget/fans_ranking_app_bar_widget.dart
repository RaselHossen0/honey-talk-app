import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FansRankingAppBarWidget extends StatelessWidget {
  const FansRankingAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 60,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      alignment: Alignment.center,
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
            EnumLocal.txtFansRanking.name.tr,
            style: AppFontStyle.styleW700(AppColor.white, 18),
          ),
          45.width,
        ],
      ),
    );
  }
}
