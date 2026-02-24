import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/video_call_ringing_page/controller/video_call_ringing_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class VideoCallRingingView extends GetView<VideoCallRingingController> {
  const VideoCallRingingView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.black,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              GetBuilder<VideoCallRingingController>(
                id: AppConstant.onInitializeCamera,
                builder: (controller) {
                  if (controller.isLoading == false && controller.cameraController != null) {
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
                },
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: Get.height / 4,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.black.withAlpha(204), AppColor.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width / 2,
                          child: Text(
                            textAlign: TextAlign.center,
                            controller.receiverName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.styleW700(AppColor.white, 22),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text(
                            textAlign: TextAlign.center,
                            "Calling...",
                            style: AppFontStyle.styleW600(AppColor.white, 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                    child: GestureDetector(
                      onTap: controller.onCancelVideoCall,
                      child: Container(
                        height: 65,
                        width: 65,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: AppColor.red,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          AppAssets.icCallDecline,
                          color: AppColor.white,
                          width: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
