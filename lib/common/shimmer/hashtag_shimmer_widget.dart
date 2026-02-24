import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';

class HashtagShimmerWidget extends StatelessWidget {
  const HashtagShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Shimmer.fromColors(
        baseColor: AppColor.baseColor,
        highlightColor: AppColor.highlightColor,
        child: Wrap(
          spacing: 15,
          alignment: WrapAlignment.start,
          children: [
            for (int index = 0; index < 10; index++)
              Chip(
                padding: const EdgeInsets.only(top: 7, bottom: 7, right: 35, left: 25),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                deleteIconColor: AppColor.black,
                elevation: 0,
                autofocus: false,
                deleteIcon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Image.asset(AppAssets.icClose, color: AppColor.lightGreyPurple),
                ),
                backgroundColor: AppColor.lightGrayBg,
                side: BorderSide(width: 0.8, color: AppColor.secondary.withValues(alpha: 0.3)),
                label: Text(
                  "",
                  style: AppFontStyle.styleW700(AppColor.grayText, 13),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
