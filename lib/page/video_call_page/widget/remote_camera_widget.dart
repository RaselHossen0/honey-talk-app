import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/video_call_page/controller/video_call_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';

class RemoteCameraWidget extends StatelessWidget {
  const RemoteCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      id: AppConstant.onEventHandler,
      builder: (controller) => Container(
        child:
            //
            // controller.isMuteRemoteVideo
            //     ? VideoCallPlaceHolder(
            //         image: controller.callerId == Database.loginUserId ? controller.receiverImage : controller.callerImage,
            //       )
            //     : (controller.engine != null && controller.remoteUid != null)
            //         ? AgoraVideoView(
            //             controller: VideoViewController.remote(
            //               rtcEngine: controller.engine!,
            //               canvas: VideoCanvas(uid: controller.remoteUid),
            //               connection: RtcConnection(channelId: controller.channelId),
            //             ),
            //           )
            //         :
            VideoCallPlaceHolder(
          image: controller.callerId == Database.loginUserId ? controller.receiverImage : controller.callerImage,
        ),
      ),
    );
  }
}

class VideoCallPlaceHolder extends StatelessWidget {
  const VideoCallPlaceHolder({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: AppColor.black,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PreviewPostImageWidget(
            image: image,
            fit: BoxFit.cover,
          ),
          BlurryContainer(
            blur: 3,
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.zero,
            color: AppColor.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(0),
            child: Offstage(),
          ),
          Container(
            height: 80,
            width: 80,
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.white.withValues(alpha: 0.4),
            ),
            child: Container(
              height: 80,
              width: 80,
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
              child: PreviewProfileImageWidget(
                image: image,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
