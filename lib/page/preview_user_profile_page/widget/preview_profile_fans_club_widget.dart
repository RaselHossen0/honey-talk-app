import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileFansClubWidget extends StatelessWidget {
  const PreviewProfileFansClubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.colorBorder.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                EnumLocal.txtFansClub.name.tr,
                style: AppFontStyle.styleW700(AppColor.black, 16),
              ),
              3.height,
              Text(
                "${EnumLocal.txtNumberOfClubMembers.name.tr} 0",
                style: AppFontStyle.styleW500(AppColor.grayText, 12),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Image.asset(AppAssets.icYellowFansClub, width: 45),
                5.width,
                Image.asset(AppAssets.icGreyFansClub, width: 45),
                5.width,
                Image.asset(AppAssets.icOrangeFansClub, width: 45),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
