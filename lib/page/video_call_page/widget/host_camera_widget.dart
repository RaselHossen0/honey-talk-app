import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/video_call_page/controller/video_call_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class HostCameraWidget extends StatelessWidget {
  const HostCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      id: AppConstant.onEventHandler,
      builder: (controller) =>
          // controller.engine != null && controller.isLoading == false
          //     ? AgoraVideoView(
          //         controller: VideoViewController(
          //           rtcEngine: controller.engine!,
          //           canvas: const VideoCanvas(uid: 0),
          //         ),
          //       )
          //     :
          LoadingWidget(color: AppColor.white),
    );
  }
}
