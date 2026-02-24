import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key, this.title, this.iconSize, this.titleSize, this.color});

  final String? title;
  final double? iconSize;
  final double? titleSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            height: iconSize ?? 200,
            width: iconSize ?? 200,
            AppAssets.imgNoDataFoundPlaceHolder,
          ),
          Text(
            title ?? EnumLocal.txtNoDataFound.name.tr,
            style: AppFontStyle.styleW600(color ?? AppColor.grayText, titleSize ?? 14),
          ),
        ],
      ),
    );
  }
}
