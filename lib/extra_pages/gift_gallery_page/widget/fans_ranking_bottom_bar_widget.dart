import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FansRankingBottomBarWidget extends StatelessWidget {
  const FansRankingBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: Get.width,
      color: AppColor.greyBlue,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            "My rank Is :",
            style: AppFontStyle.styleW600(AppColor.white, 14),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(
              color: AppColor.white,
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
