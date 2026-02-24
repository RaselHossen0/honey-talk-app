import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/incoming_video_call_page/controller/incoming_video_call_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class IncomingVideoCallView extends GetView<IncomingVideoCallController> {
  const IncomingVideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      body: Stack(
        children: [
          PreviewPostImageWidget(image: controller.callerImage, fit: BoxFit.cover),
          BlurryContainer(
            height: Get.height,
            width: Get.width,
            blur: 10,
            color: AppColor.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.zero,
            child: Offstage(),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                75.height,
                Column(
                  children: [
                    Text(
                      EnumLocal.txtIncomingVideoCall.name.tr,
                      style: AppFontStyle.styleW700(AppColor.white, 20),
                    ),
                    5.height,
                    Text(
                      controller.callerName,
                      style: AppFontStyle.styleW600(AppColor.white, 16),
                    ),
                  ],
                ),
                40.height,
                Container(
                  height: 140,
                  width: 140,
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.white.withValues(alpha: 0.5)),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
                      child: PreviewProfileImageWidget(image: controller.callerImage),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: controller.onCallDecline,
                      child: Container(
                        height: 65,
                        width: 65,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.red,
                        ),
                        child: Image.asset(
                          AppAssets.icCallDecline,
                          width: 35,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onCallAnswer,
                      child: Container(
                        height: 65,
                        width: 65,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.green,
                        ),
                        child: Image.asset(
                          AppAssets.icCallReceive,
                          width: 25,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
                50.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
