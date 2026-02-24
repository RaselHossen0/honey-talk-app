import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/convert_second_to_time.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/view/fake_other_user_profile_bottom_sheet.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/scroll_fade_effect_widget.dart';
import 'package:tingle/page/fake_live_page/controller/fake_live_controller.dart';
import 'package:tingle/page/fake_live_page/widget/fake_comment_text_field_widget.dart';
import 'package:tingle/page/fake_live_page/widget/fake_live_comment_widget.dart';
import 'package:tingle/page/live_page/pk_battle_widget/pk_rank_slider_widget.dart';

import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';
import 'package:video_player/video_player.dart';

class FakePkCameraWidget extends StatelessWidget {
  const FakePkCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FakeLiveController>(
      id: AppConstant.onEventHandler,
      builder: (controller) => controller.fakeLiveModel?.isChannelMediaRelay == true
          ? Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(gradient: AppColor.audioRoomGradient),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: Stack(
                          children: [
                            ScrollFadeEffectWidget(
                              axis: Axis.vertical,
                              child: SingleChildScrollView(
                                // physics: const NeverScrollableScrollPhysics(),
                                child: Container(
                                  color: AppColor.transparent,
                                  height: Get.height,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          GetBuilder<FakeLiveController>(
                                            id: AppConstant.onToggleComment,
                                            builder: (controller) => GestureDetector(
                                              behavior: HitTestBehavior.translucent, // Important!
                                              // Make sure this is active
                                              child: Container(
                                                color: Colors.transparent, // Use Flutter's built-in transparent
                                                height: Get.height / 3.3,
                                                width: Get.width,
                                                alignment: AlignmentDirectional.topStart,
                                                child: Visibility(
                                                  visible: true,
                                                  child: Container(
                                                    height: Get.height / 3.3,
                                                    width: Get.width / 1.8,
                                                    color: Colors.transparent, // Also updated
                                                    child: FakeLiveCommentWidget(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          70.height,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 110,
                              child: Container(
                                height: 350,
                                width: Get.width,
                                color: AppColor.transparent,
                                child: Column(
                                  children: [
                                    12.height,
                                    Expanded(
                                      child: Stack(
                                        fit: StackFit.expand,
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            height: 300,
                                            width: Get.width,
                                            child: Row(
                                              children: [
                                                Expanded(child: controller.fakeLiveModel?.isHost == true ? H1CameraWidget() : U1CameraWidget()),
                                                Expanded(child: H2CameraWidget()),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            child: Container(
                                              height: 25,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: AppColor.black.withValues(alpha: 0.5),
                                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                                              ),
                                              child: GetBuilder<FakeLiveController>(
                                                id: AppConstant.onChangePkTime,
                                                builder: (controller) => Text(
                                                  "Cutdown : ${ConvertSecondToTime.onConvert(controller.fakeLiveModel?.pkCountTime ?? 0)}",
                                                  style: AppFontStyle.styleW600(AppColor.white, 8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GetBuilder<FakeLiveController>(
                                      id: AppConstant.onChangeRank,
                                      builder: (controller) => PkRankSliderWidget(
                                        rank1: controller.fakeLiveModel?.host1Rank ?? 0,
                                        rank2: controller.fakeLiveModel?.host2Rank ?? 0,
                                        width: Get.width,
                                        height: 20,
                                      ),
                                    ),
                                    GetBuilder<FakeLiveController>(
                                      id: AppConstant.onSeatUserUpdate,
                                      builder: (controller) => Container(
                                        height: 40,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.blue.withValues(alpha: 0.5),
                                              AppColor.black,
                                              AppColor.pink.withValues(alpha: 0.9),
                                            ],
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            10.width,
                                            Image.asset(AppAssets.icArrowLeft, width: 8, color: AppColor.white),
                                            10.width,
                                            Expanded(
                                              child: HorizantalScrollFadeEffectWidget(
                                                axis: Axis.horizontal,
                                                child: SingleChildScrollView(
                                                  controller: ScrollController(),
                                                  scrollDirection: Axis.horizontal,
                                                  child: ListView.builder(
                                                    itemCount: 4,
                                                    shrinkWrap: true,
                                                    reverse: true,
                                                    scrollDirection: Axis.horizontal,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      final isAvailable = (controller.fakeLiveModel?.host1TopGiftUsers.length ?? 0) > index;

                                                      final indexData = isAvailable ? controller.fakeLiveModel?.host1TopGiftUsers[index] : null;
                                                      return GestureDetector(
                                                        onTap: () => FakeOtherUserProfileBottomSheet.show(
                                                          context: context,
                                                          userId: controller.fakeLiveModel?.host1TopGiftUsers[index].userId!.id ?? "",
                                                        ),
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          margin: EdgeInsets.only(right: 5),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            border: Border.all(color: AppColor.white),
                                                          ),
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            alignment: Alignment.center,
                                                            clipBehavior: Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: AppColor.transparent,
                                                            ),
                                                            child: isAvailable == false
                                                                ? Image.asset(
                                                                    AppAssets.icSeat,
                                                                    width: 20,
                                                                  )
                                                                : Stack(
                                                                    alignment: Alignment.center,
                                                                    children: [
                                                                      PreviewProfileImageWidget(
                                                                        image: indexData?.userId?.image,
                                                                      ),
                                                                      Positioned(
                                                                        bottom: -10,
                                                                        child: Container(
                                                                          height: 22,
                                                                          width: 22,
                                                                          alignment: Alignment.center,
                                                                          padding: EdgeInsets.only(bottom: 14),
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: AppColor.primary,
                                                                          ),
                                                                          child: Text(
                                                                            "${index + 1}",
                                                                            style: AppFontStyle.styleW600(AppColor.white, 7),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            30.width,
                                            Expanded(
                                              child: HorizantalScrollFadeEffectWidget(
                                                axis: Axis.horizontal,
                                                child: SingleChildScrollView(
                                                  controller: ScrollController(),
                                                  scrollDirection: Axis.horizontal,
                                                  child: ListView.builder(
                                                    itemCount: 4,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      final isAvailable = (controller.fakeLiveModel?.host2TopGiftUsers.length ?? 0) > index;

                                                      final indexData = isAvailable ? controller.fakeLiveModel?.host2TopGiftUsers[index] : null;
                                                      return GestureDetector(
                                                        onTap: () => FakeOtherUserProfileBottomSheet.show(
                                                          context: context,
                                                          userId: controller.fakeLiveModel?.host2TopGiftUsers[index].userId!.id ?? "",
                                                        ),
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          margin: EdgeInsets.only(right: 5),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            border: Border.all(color: AppColor.white),
                                                          ),
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            alignment: Alignment.center,
                                                            clipBehavior: Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: AppColor.transparent,
                                                            ),
                                                            child: isAvailable == false
                                                                ? Image.asset(
                                                                    AppAssets.icSeat,
                                                                    width: 20,
                                                                  )
                                                                : Stack(
                                                                    alignment: Alignment.center,
                                                                    children: [
                                                                      PreviewProfileImageWidget(
                                                                        image: indexData?.userId?.image,
                                                                      ),
                                                                      Positioned(
                                                                        bottom: -10,
                                                                        child: Container(
                                                                          height: 22,
                                                                          width: 22,
                                                                          alignment: Alignment.center,
                                                                          padding: EdgeInsets.only(bottom: 14),
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: AppColor.primary,
                                                                          ),
                                                                          child: Text(
                                                                            "${index + 1}",
                                                                            style: AppFontStyle.styleW600(AppColor.white, 7),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            10.width,
                                            Image.asset(AppAssets.icArrowRight, width: 8, color: AppColor.white),
                                            10.width,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: FakeCommentTextFieldWidget(
                        ispklive: true,
                      )),
                ],
              ),
            )
          : Offstage(),
    );
  }
}

class FakeLiveCameraWidget extends StatelessWidget {
  const FakeLiveCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FakeLiveController>(
        id: AppConstant.onEventHandler,
        builder: (controller) => SizedBox(
              height: Get.height,
              width: Get.width,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  // decoration: BoxDecoration(color: AppColor.black),
                  child: AspectRatio(
                    aspectRatio: controller.videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(controller.videoPlayerController!),
                  ),
                  // VideoPlayer(controller.videoPlayerController ?? VideoPlayerController.networkUrl(Uri.parse(controller.fakeLiveModel?.streamSource ?? ""))),
                  // controller.fakeLiveModel?.isHost == true ? H1CameraWidget() : U1CameraWidget(),
                ),
              ),
            ));
  }
}

class H1CameraWidget extends GetView<FakeLiveController> {
  const H1CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        controller.fakeLiveModel?.isChannelMediaRelay == true
            ? PreviewPostImageWidget(
                image: controller.fakeLiveModel?.pkThumbnails.first,
                isBanned: controller.fakeLiveModel?.host1ProfilePicIsBanned,
                fit: BoxFit.cover,
              )
            : LoadingWidget(color: AppColor.white),
        VideoPlayer(controller.videoPlayerController ?? VideoPlayerController.networkUrl(Uri.parse(controller.fakeLiveModel?.pkStreamSources.first ?? ""))),
      ],
    );
  }
}

class H2CameraWidget extends GetView<FakeLiveController> {
  const H2CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        controller.fakeLiveModel?.isChannelMediaRelay == true
            ? PreviewPostImageWidget(
                image: controller.fakeLiveModel?.pkThumbnails.last,
                isBanned: controller.fakeLiveModel?.host2ProfilePicIsBanned,
                fit: BoxFit.cover,
              )
            : LoadingWidget(color: AppColor.white),
        VideoPlayer(controller.pkHost2videoPlayerController ?? VideoPlayerController.networkUrl(Uri.parse(controller.fakeLiveModel?.pkStreamSources.last ?? ""))),
      ],
    );
  }
}

class U1CameraWidget extends GetView<FakeLiveController> {
  const U1CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final video = File(AppAssets.demoVideo_1);
    return Stack(
      fit: StackFit.expand,
      children: [
        controller.fakeLiveModel?.isChannelMediaRelay == true
            ? PreviewPostImageWidget(
                image: controller.fakeLiveModel?.pkThumbnails.first,
                isBanned: controller.fakeLiveModel?.host1ProfilePicIsBanned,
                fit: BoxFit.cover,
              )
            : LoadingWidget(color: AppColor.white),
        VideoPlayer(controller.videoPlayerController ??
            VideoPlayerController.file(video

                // VideoPlayerController.networkUrl(Uri.parse(controller.fakeLiveModel?.pkStreamSources.last ?? "")

                // VideoPlayerController.networkUrl(Uri.parse(controller.fakeLiveModel?.pkStreamSources.first ?? "")
                )),
      ],
    );
  }
}

// class UserCameraWidget extends StatelessWidget {
//   const UserCameraWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FakeLiveController>(
//       id: AppConstant.onEventHandler,
//       builder: (controller) => Stack(
//         children: [
//           Positioned(
//             top: controller.fakeLiveModel?.isChannelMediaRelay == true ? 120 : 0,
//             child: Container(
//               height: controller.fakeLiveModel?.isChannelMediaRelay == true ? (Get.width / 1.8) : Get.height,
//               width: Get.width,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: U1CameraWidget(),
//                   ),
//                   Visibility(
//                     visible: controller.fakeLiveModel?.isChannelMediaRelay == true,
//                     child: Expanded(
//                       child: H2CameraWidget(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HostCameraWidget extends StatelessWidget {
//   const HostCameraWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FakeLiveController>(
//       id: AppConstant.onEventHandler,
//       builder: (controller) => Stack(
//         children: [
//           Positioned(
//             top: controller.fakeLiveModel?.isChannelMediaRelay == true ? 120 : 0,
//             child: Container(
//               height: controller.fakeLiveModel?.isChannelMediaRelay == true ? (Get.width / 1.8) : Get.height,
//               width: Get.width,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: H1CameraWidget(),
//                   ),
//                   Visibility(
//                     visible: controller.fakeLiveModel?.isChannelMediaRelay == true,
//                     child: Expanded(
//                       child: H2CameraWidget(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
