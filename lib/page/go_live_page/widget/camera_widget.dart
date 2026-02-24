import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/circle_icon_button_ui.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/go_live_page/controller/go_live_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class CameraWidget extends StatelessWidget {
  const CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          GetBuilder<GoLiveController>(
              id: AppConstant.onInitializeCamera,
              builder: (controller) {
                if (controller.cameraController != null && (controller.cameraController?.value.isInitialized ?? false)) {
                  final mediaSize = MediaQuery.of(context).size;
                  final scale = 1 / (controller.cameraController!.value.aspectRatio * mediaSize.aspectRatio);

                  return ClipRect(
                    clipper: _MediaSizeClipper(mediaSize),
                    child: Transform.scale(
                      scale: scale,
                      alignment: Alignment.topCenter,
                      child: CameraPreview(controller.cameraController!),
                    ),
                  );
                } else {
                  return const LoadingWidget();
                }
              }),
          Positioned(
            bottom: 0,
            child: Container(
              height: 150,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            child: SizedBox(
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleIconButtonUi(
                      circleSize: 40,
                      iconSize: 20,
                      color: AppColor.white.withValues(alpha: 0.1),
                      icon: AppAssets.icClose,
                      iconColor: AppColor.white,
                      callback: () => Get.back(),
                    ),
                    20.height,
                    GetBuilder<GoLiveController>(
                      id: AppConstant.onSwitchFlash,
                      builder: (controller) => CircleIconButtonUi(
                        circleSize: 40,
                        iconSize: 20,
                        gradient: AppColor.primaryGradient,
                        icon: controller.isFlashOn ? AppAssets.icFlashOn : AppAssets.icFlashOff,
                        iconColor: AppColor.white,
                        callback: controller.onSwitchFlash,
                      ),
                    ),
                    20.height,
                    GetBuilder<GoLiveController>(
                      builder: (controller) => CircleIconButtonUi(
                        circleSize: 40,
                        iconSize: 20,
                        gradient: AppColor.primaryGradient,
                        icon: AppAssets.icCameraRotate,
                        iconColor: AppColor.white,
                        callback: controller.onSwitchCamera,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
