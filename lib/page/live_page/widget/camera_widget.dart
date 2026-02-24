import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/convert_second_to_time.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/page/live_page/pk_battle_widget/pk_rank_slider_widget.dart';
import 'package:tingle/page/live_page/widget/comment_text_field_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PkCameraWidget extends StatelessWidget {
  const PkCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveController>(
      id: AppConstant.onEventHandler,
      builder: (controller) => controller.liveModel?.isChannelMediaRelay == true
          ? Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(gradient: AppColor.audioRoomGradient),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 135,
                              child: Container(
                                height: 320,
                                width: Get.width,
                                color: AppColor.transparent,
                                child: Column(
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     10.width,
                                    //     Container(
                                    //       height: 30,
                                    //       padding: EdgeInsets.only(left: 5, right: 8, top: 5, bottom: 5),
                                    //       decoration: BoxDecoration(
                                    //         color: AppColor.white.withValues(alpha: 0.3),
                                    //         borderRadius: BorderRadius.circular(100),
                                    //       ),
                                    //       child: Row(
                                    //         children: [
                                    //           Container(
                                    //             height: 50,
                                    //             padding: EdgeInsets.only(left: 5, right: 8),
                                    //             decoration: BoxDecoration(
                                    //               gradient: AppColor.lightOrangeYellowGradient,
                                    //               borderRadius: BorderRadius.circular(100),
                                    //             ),
                                    //             child: Row(
                                    //               children: [
                                    //                 Image.asset(AppAssets.icRedYellowColorFire, width: 12),
                                    //                 3.width,
                                    //                 Text(
                                    //                   "Hours",
                                    //                   style: AppFontStyle.styleW700(AppColor.white, 12),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //           5.width,
                                    //           Text(
                                    //             "No.4",
                                    //             style: AppFontStyle.styleW700(AppColor.lightYellow, 12),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     10.width,
                                    //     Container(
                                    //       height: 30,
                                    //       padding: EdgeInsets.only(left: 5, right: 8, top: 4, bottom: 4),
                                    //       decoration: BoxDecoration(
                                    //         color: AppColor.bluePurple,
                                    //         borderRadius: BorderRadius.circular(100),
                                    //       ),
                                    //       child: Row(
                                    //         children: [
                                    //           Container(
                                    //             height: 50,
                                    //             padding: EdgeInsets.only(left: 5, right: 8),
                                    //             decoration: BoxDecoration(
                                    //               color: AppColor.white,
                                    //               borderRadius: BorderRadius.circular(100),
                                    //             ),
                                    //             child: Row(
                                    //               children: [
                                    //                 Image.asset(AppAssets.icLotus, width: 15),
                                    //                 3.width,
                                    //                 Text(
                                    //                   "16",
                                    //                   style: AppFontStyle.styleW700(AppColor.darkBlue, 12),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //           5.width,
                                    //           Text(
                                    //             "2560.45k",
                                    //             style: AppFontStyle.styleW700(AppColor.white, 10),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     Spacer(),
                                    //     Text(
                                    //       "ID:${controller.liveModel?.host1UniqueId}",
                                    //       style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.5), 10),
                                    //     ),
                                    //     10.width,
                                    //   ],
                                    // ),
                                    12.height,
                                    Expanded(
                                      child: Stack(
                                        fit: StackFit.expand,
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            height: 270,
                                            width: Get.width,
                                            child: Row(
                                              children: [
                                                Expanded(child: controller.liveModel?.isHost == true ? H1CameraWidget() : U1CameraWidget()),
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
                                              child: GetBuilder<LiveController>(
                                                id: AppConstant.onChangePkTime,
                                                builder: (controller) => Text(
                                                  "Cutdown : ${ConvertSecondToTime.onConvert(controller.liveModel?.pkCountTime ?? 0)}",
                                                  style: AppFontStyle.styleW600(AppColor.white, 8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GetBuilder<LiveController>(
                                      id: AppConstant.onChangeRank,
                                      builder: (controller) => PkRankSliderWidget(
                                        rank1: controller.liveModel?.host1Rank ?? 0,
                                        rank2: controller.liveModel?.host2Rank ?? 0,
                                        width: Get.width,
                                        height: 20,
                                      ),
                                    ),
                                    GetBuilder<LiveController>(
                                      id: AppConstant.onSeatUserUpdate,
                                      builder: (controller) => Container(
                                        height: 50,
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
                                            15.width,
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: ListView.builder(
                                                    itemCount: 3,
                                                    // itemCount: (controller.liveModel?.host1TopGiftUsers.length ?? 0) < 10 ? 3 : controller.liveModel?.host1TopGiftUsers.length,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      final isAvailable = (controller.liveModel?.host1TopGiftUsers.length ?? 0) > index;

                                                      final indexData = isAvailable ? controller.liveModel?.host1TopGiftUsers[index] : null;
                                                      return GestureDetector(
                                                        onTap: () {
                                                          if (isAvailable && Database.loginUserId != indexData?.userId?.id) {
                                                            FocusManager.instance.primaryFocus?.unfocus();

                                                            OtherUserProfileBottomSheet.show(context: context, userId: indexData?.userId?.id ?? "");
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 35,
                                                          width: 35,
                                                          margin: EdgeInsets.only(right: 10),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            border: Border.all(color: AppColor.white),
                                                          ),
                                                          child: Container(
                                                            height: 35,
                                                            width: 35,
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
                                                                          height: 28,
                                                                          width: 28,
                                                                          alignment: Alignment.center,
                                                                          padding: EdgeInsets.only(bottom: 16),
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
                                            40.width,
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: ListView.builder(
                                                    itemCount: 3,
                                                    // itemCount: (controller.liveModel?.host2TopGiftUsers.length ?? 0) < 3 ? 3 : controller.liveModel?.host2TopGiftUsers.length,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      final isAvailable = (controller.liveModel?.host2TopGiftUsers.length ?? 0) > index;

                                                      final indexData = isAvailable ? controller.liveModel?.host2TopGiftUsers[index] : null;
                                                      return GestureDetector(
                                                        onTap: () {
                                                          if (isAvailable && Database.loginUserId != indexData?.userId?.id) {
                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                            OtherUserProfileBottomSheet.show(context: context, userId: indexData?.userId?.id ?? "");
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 35,
                                                          width: 35,
                                                          margin: EdgeInsets.only(right: 10),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            border: Border.all(color: AppColor.white),
                                                          ),
                                                          child: Container(
                                                            height: 35,
                                                            width: 35,
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
                                                                          height: 28,
                                                                          width: 28,
                                                                          alignment: Alignment.center,
                                                                          padding: EdgeInsets.only(bottom: 16),
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
                  CommentTextFieldWidget(),
                ],
              ),
            )
          : Offstage(),
    );
  }
}

class LiveCameraWidget extends StatelessWidget {
  const LiveCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveController>(
      id: AppConstant.onEventHandler,
      builder: (controller) => controller.liveModel?.isChannelMediaRelay == false
          ? SizedBox(
              height: Get.height,
              width: Get.width,
              child: SingleChildScrollView(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(color: AppColor.black),
                  child: controller.liveModel?.isHost == true ? H1CameraWidget() : U1CameraWidget(),
                ),
              ),
            )
          : Offstage(),
    );
  }
}

class H1CameraWidget extends GetView<LiveController> {
  const H1CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        controller.liveModel?.isChannelMediaRelay == true
            ? PreviewPostImageWidget(
                image: controller.liveModel?.host1Image,
                isBanned: controller.liveModel?.host1ProfilePicIsBanned,
                fit: BoxFit.cover,
              )
            : LoadingWidget(color: AppColor.white),
        // (controller.liveModel?.engine != null && controller.liveModel?.isLoading == false)
        //     ? AgoraVideoView(
        //         controller: VideoViewController(
        //           rtcEngine: controller.liveModel!.engine!,
        //           canvas: const VideoCanvas(uid: 0),
        //         ),
        //       )
        //     : Offstage(),
      ],
    );
  }
}

class H2CameraWidget extends GetView<LiveController> {
  const H2CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        controller.liveModel?.isChannelMediaRelay == true
            ? PreviewPostImageWidget(
                image: controller.liveModel?.host2Image,
                isBanned: controller.liveModel?.host2ProfilePicIsBanned,
                fit: BoxFit.cover,
              )
            : LoadingWidget(color: AppColor.white),
        // (controller.liveModel?.engine != null && controller.liveModel?.isLoading == false)
        //     ? AgoraVideoView(
        //         controller: VideoViewController.remote(
        //           rtcEngine: controller.liveModel!.engine!,
        //           connection: RtcConnection(channelId: controller.liveModel?.host1Channel ?? ""),
        //           canvas: VideoCanvas(uid: 1),
        //         ),
        //       )
        //     : Offstage(),
      ],
    );
  }
}

class U1CameraWidget extends GetView<LiveController> {
  const U1CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        controller.liveModel?.isChannelMediaRelay == true
            ? PreviewPostImageWidget(
                image: controller.liveModel?.host1Image,
                isBanned: controller.liveModel?.host1ProfilePicIsBanned,
                fit: BoxFit.cover,
              )
            : LoadingWidget(color: AppColor.white),
        // (controller.liveModel?.engine != null && controller.liveModel?.isLoading == false)
        //     ? AgoraVideoView(
        //         controller: VideoViewController.remote(
        //           rtcEngine: controller.liveModel!.engine!,
        //           connection: RtcConnection(channelId: controller.liveModel?.host1Channel ?? ""),
        //           canvas: VideoCanvas(uid: controller.liveModel?.host1Uid ?? 0),
        //         ),
        //       )
        //     : Offstage(),
      ],
    );
  }
}

// class UserCameraWidget extends StatelessWidget {
//   const UserCameraWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LiveController>(
//       id: AppConstant.onEventHandler,
//       builder: (controller) => Stack(
//         children: [
//           Positioned(
//             top: controller.liveModel?.isChannelMediaRelay == true ? 120 : 0,
//             child: Container(
//               height: controller.liveModel?.isChannelMediaRelay == true ? (Get.width / 1.8) : Get.height,
//               width: Get.width,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: U1CameraWidget(),
//                   ),
//                   Visibility(
//                     visible: controller.liveModel?.isChannelMediaRelay == true,
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
//     return GetBuilder<LiveController>(
//       id: AppConstant.onEventHandler,
//       builder: (controller) => Stack(
//         children: [
//           Positioned(
//             top: controller.liveModel?.isChannelMediaRelay == true ? 120 : 0,
//             child: Container(
//               height: controller.liveModel?.isChannelMediaRelay == true ? (Get.width / 1.8) : Get.height,
//               width: Get.width,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: H1CameraWidget(),
//                   ),
//                   Visibility(
//                     visible: controller.liveModel?.isChannelMediaRelay == true,
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
