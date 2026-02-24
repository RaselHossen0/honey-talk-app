import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class RankBottomBarWidget extends StatelessWidget {
  const RankBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: Get.width,
      color: AppColor.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            EnumLocal.txtDistanceFromRankIs.name.tr,
            style: AppFontStyle.styleW600(AppColor.secondary, 14),
          ),
          8.width,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(
              color: AppColor.lightYellow.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                Image.asset(AppAssets.icCoinStar, width: 18),
                3.width,
                Text(
                  "88,874,414",
                  style: AppFontStyle.styleW700(AppColor.lightYellow, 12),
                ),
                5.width,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
