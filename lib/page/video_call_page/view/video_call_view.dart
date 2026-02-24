import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/function/convert_second_to_time.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/video_call_page/controller/video_call_controller.dart';
import 'package:tingle/page/video_call_page/widget/host_camera_widget.dart';
import 'package:tingle/page/video_call_page/widget/remote_camera_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class VideoCallView extends GetView<VideoCallController> {
  const VideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    Future.delayed(
      Duration(milliseconds: 300),
      () => SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColor.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: AppColor.black,
              child: HostCameraWidget(),
            ),
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 20,
              right: 20,
              child: Container(
                height: 200,
                width: 150,
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: RemoteCameraWidget(),
              ),
            ),
            Positioned(
              top: 50,
              left: 15,
              child: BlurryContainer(
                height: 60,
                width: Get.width / 2.2,
                color: AppColor.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(15),
                blur: 4,
                child: Row(
                  children: [
                    10.width,
                    Container(
                      height: 35,
                      width: 35,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: PreviewProfileImageWidget(
                        image: controller.callerId == Database.loginUserId ? controller.receiverImage : controller.callerImage,
                      ),
                    ),
                    12.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width / 4,
                          child: Text(
                            controller.callerId == Database.loginUserId ? controller.receiverName : controller.callerName,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.styleW600(AppColor.white, 16),
                          ),
                        ),
                        GetBuilder<VideoCallController>(
                          id: AppConstant.onChangeTime,
                          builder: (controller) => Text(
                            overflow: TextOverflow.ellipsis,
                            ConvertSecondToTime.onConvert(controller.countTime),
                            style: AppFontStyle.styleW400(AppColor.white, 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: BlurryContainer(
                  height: 75,
                  blur: 10,
                  width: Get.width,
                  color: AppColor.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(100),
                  child: Row(
                    children: [
                      GetBuilder<VideoCallController>(
                        id: AppConstant.onClickMic,
                        builder: (controller) => IconWidget(
                          icon: controller.isMicMute ? AppAssets.icMicOn : AppAssets.icMicOff,
                          iconSize: 20,
                          color: AppColor.grey,
                          callback: controller.onClickMic,
                        ),
                      ),
                      GetBuilder<VideoCallController>(
                        id: AppConstant.onClickVideo,
                        builder: (controller) => IconWidget(
                          icon: controller.isVideoOn ? AppAssets.icVideoOn : AppAssets.icVideoOff,
                          iconSize: 21,
                          color: AppColor.grey,
                          callback: controller.onClickVideo,
                        ),
                      ),
                      IconWidget(
                        icon: AppAssets.icCameraRotate,
                        iconSize: 20,
                        color: AppColor.grey,
                        callback: controller.onClickCamera,
                      ),
                      IconWidget(
                        icon: AppAssets.icCallDecline,
                        iconSize: 25,
                        color: AppColor.red,
                        callback: controller.onClickCallCut,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({super.key, this.color, this.gradient, required this.icon, required this.iconSize, required this.callback});

  final Color? color;
  final Gradient? gradient;
  final String icon;
  final double iconSize;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: callback,
          child: Container(
            height: 45,
            width: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              gradient: gradient,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              icon,
              width: iconSize,
              color: AppColor.white,
            ),
          ),
        ),
      ),
    );
  }
}

//        Positioned(
//          top: 50,
//          right: 20,
//          child: Container(
//            height: Get.height / 4,
//            width: Get.width / 2.5,
//            clipBehavior: Clip.antiAlias,
//            padding: EdgeInsets.all(1),
//            decoration: BoxDecoration(
//              gradient: AppColor.primaryGradient,
//              borderRadius: BorderRadius.circular(20),
//            ),
//            child: GestureDetector(
//              onTap: () => isShowRemoteView.value = !isShowRemoteView.value,
//              child: Container(
//                height: Get.height / 4,
//                width: Get.width / 2.5,
//                clipBehavior: Clip.antiAlias,
//                decoration: BoxDecoration(
//                  color: Colors.transparent,
//                  borderRadius: BorderRadius.circular(20),
//                ),
//                child: Obx(
//                      () => isShowRemoteView.value
//                      ? isLoadingView.value == false && view != null
//                      ? view!
//                      : Container(color: AppColor.white)
//                      : isLoadingRemoteView.value == false && remoteView != null
//                      ? remoteView!
//                      : Container(color: Colors.black),
//                ),
//              ),
//            ),
//          ),
//        ),
//        Positioned(
//          bottom: 40,
//          child: SizedBox(
//            width: Get.width,
//            child: Padding(
//              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
//              child: BlurryContainer(
//                padding: EdgeInsets.symmetric(vertical: 15),
//                color: AppColor.white.withOpacity(0.3),
//                blur: 5,
//                borderRadius: BorderRadius.circular(20),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    GestureDetector(
//                      // onTap: onMicMute,
//                      child: Container(
//                        height: 55,
//                        width: 55,
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.all(1),
//                        decoration: BoxDecoration(
//                          gradient: AppColor.primaryGradient,
//                          shape: BoxShape.circle,
//                        ),
//                        child: Obx(
//                              () => Image.asset(
//                            isMicMute.value ? AppAssets.icMicOff : AppAssets.icMicOn,
//                            color: AppColor.white,
//                            width: 25,
//                          ),
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                      // onTap: onRotateCamera,
//                      child: Container(
//                        height: 55,
//                        width: 55,
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.all(1),
//                        decoration: BoxDecoration(
//                          gradient: AppColor.primaryGradient,
//                          shape: BoxShape.circle,
//                        ),
//                        child: Image.asset(
//                          AppAssets.icCommentFill,
//                          color: AppColor.white,
//                          width: 25,
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                      // onTap: onCameraOff,
//                      child: Container(
//                        height: 55,
//                        width: 55,
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.all(1),
//                        decoration: BoxDecoration(
//                          gradient: AppColor.primaryGradient,
//                          shape: BoxShape.circle,
//                        ),
//                        child: Obx(
//                              () => Image.asset(
//                            isVideoOff.value ? AppAssets.icCommentFill : AppAssets.icCommentFill,
//                            color: AppColor.white,
//                            width: 25,
//                          ),
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: controller.onClickCallCut,
//                      child: Container(
//                        height: 55,
//                        width: 55,
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.all(1),
//                        decoration: BoxDecoration(
//                          color: AppColor.red,
//                          shape: BoxShape.circle,
//                        ),
//                        child: Image.asset(
//                          AppAssets.icCommentFill,
//                          width: 32,
//                          color: AppColor.white,
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ),
