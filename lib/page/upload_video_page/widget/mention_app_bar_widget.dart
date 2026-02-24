import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/upload_video_page/controller/upload_video_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class MentionAppBarWidget extends StatelessWidget {
  const MentionAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 60,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      alignment: Alignment.center,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: Get.back,
                child: Container(
                  height: 45,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                  child: Image.asset(
                    AppAssets.icArrowLeft,
                    width: 10,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                EnumLocal.txtMention.name.tr,
                style: AppFontStyle.styleW700(AppColor.black, 18),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GetBuilder<UploadVideoController>(
                  id: AppConstant.onGetFriend,
                  builder: (controller) => Text(
                    "${EnumLocal.txtCompleted.name.tr} (${controller.mentionedUserIds.length}/10)",
                    style: AppFontStyle.styleW500(AppColor.primary, 13),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
