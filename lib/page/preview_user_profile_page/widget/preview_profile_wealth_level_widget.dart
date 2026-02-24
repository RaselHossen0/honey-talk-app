import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileWealthLevelWidget extends GetView<PreviewUserProfileController> {
  const PreviewProfileWealthLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.imgLiveStreamLevelBg,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Image.asset(AppAssets.icWealthLevel, width: 45),
                15.width,
                Text(
                  EnumLocal.txtMyWealthLevel.name.tr,
                  style: AppFontStyle.styleW500(AppColor.white, 15),
                ),
                Spacer(),
                SizedBox(
                  height: 30,
                  width: 50,
                  child: PreviewWealthLevelImage(
                    height: 30,
                    width: 50,
                    image: controller.fetchUserProfileModel?.user?.wealthLevel?.levelImage,
                  ),
                ),
                10.width,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
