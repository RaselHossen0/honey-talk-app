import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/show_entry_ride.dart';
import 'package:tingle/common/function/show_received_gift.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_app_bar_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_bottom_bar_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_comment_widget.dart';

import 'package:tingle/page/audio_room_page/widget/audio_room_seat_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_viewer_drawer_widget.dart';

import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomView extends GetView<AudioRoomController> {
  const AudioRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: controller.audioRoomModel?.isHost == true ? AudioRoomViewerDrawerWidget() : null,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(gradient: AppColor.audioRoomGradient),
              child: GetBuilder<AudioRoomController>(
                id: AppConstant.onChangeTheme,
                builder: (controller) => Visibility(
                  visible: controller.audioRoomModel?.bgTheme != null && (controller.audioRoomModel?.bgTheme.trim().isNotEmpty ?? false),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PreviewPostImageWidget(
                        image: controller.audioRoomModel?.bgTheme,
                        fit: BoxFit.cover,
                        isShowPlaceHolder: false,
                      ),
                      Container(
                        height: Get.height,
                        width: Get.width,
                        color: AppColor.black.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        MediaQuery.of(context).viewPadding.top.height,
                        AudioRoomAppbarWidget(),
                        AudioRoomSeatWidget(),
                        Container(
                          height: (Get.height - (MediaQuery.of(context).viewPadding.top + 100 + (Get.width / 1.2) + 70)),
                          color: AppColor.transparent,
                          width: Get.width,
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            width: Get.width / 1.8,
                            color: AppColor.transparent,
                            alignment: Alignment.bottomCenter,
                            child: AudioRoomCommentWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AudioRoomBottomBarWidget(),
              ],
            ),
          ),

          ShowReceivedGift.onShowGift(),
          ShowReceivedGift.onShowSenderDetails(),
          ShowEntryRide.onShowRide(),

          // SingleChildScrollView(
          //   child: Container(
          //     color: AppColor.transparent,
          //     height: Get.height,
          //     child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: SingleChildScrollView(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             GetBuilder<AudioRoomController>(
          //               id: AppConstant.onToggleComment,
          //               builder: (controller) => GestureDetector(
          //                 onTap: () => controller.onToggleComment(),
          //                 child: Container(
          //                   color: AppColor.transparent,
          //                   height: Get.height / 3.3,
          //                   width: Get.width,
          //                   alignment: AlignmentDirectional.topStart,
          //                   child: Visibility(
          //                     visible: true,
          //                     child: Container(
          //                       height: Get.height / 3.3,
          //                       width: Get.width / 1.8,
          //                       color: AppColor.transparent,
          //                       child: AudioRoomCommentWidget(),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             70.height,
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: Get.height,
          //   width: Get.width,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       (MediaQuery.of(context).viewPadding.top).height,
          //       10.height,
          //       AudioRoomAppbarWidget(),
          //       AudioRoomSeatWidget(),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: Get.height,
          //   width: Get.width,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       AudioRoomBottomBarWidget(),
          //     ],
          //   ),
          // ),
          // ShowReceivedGift.onShowGift(),
          // ShowReceivedGift.onShowSenderDetails(),
        ],
      ),
    );
  }
}

// SizedBox(
//   height: Get.height,
//   width: Get.width,
//   child: Column(
//     children: [
//       (MediaQuery.of(context).viewPadding.top).height,
//       Expanded(
//         child: LayoutBuilder(builder: (context, box) {
//           double commentHeight = (Get.height - (MediaQuery.of(context).viewPadding.top + 70 + 450));
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 10.height,
//                 AudioRoomAppbarWidget(),
//                 10.height,
//                 AudioRoomSeatWidget(),
//                 // Container(
//                 //   height: commentHeight,
//                 //   width: Get.width / 1.8,
//                 //   color: AppColor.transparent,
//                 //   child: AudioRoomCommentWidget(),
//                 // ),
//               ],
//             ),
//           );
//         }),
//       ),
//       // AudioRoomBottomBarWidget(),
//     ],
//   ),
// ),

// class TypeWiseComment extends StatelessWidget {
//   const TypeWiseComment({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               // height: commentHeight - 45,
//               width: Get.width / 1.7,
//               color: AppColor.transparent,
//               child: TabWiseCommentWidget(),
//             ),
//             // CommentTabBar(),
//           ],
//         ),
//         Container(
//           height: 120,
//           width: 120,
//           margin: EdgeInsets.only(bottom: 10),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Image.asset(
//                 AppAssets.icTimerGift,
//                 width: 100,
//               ),
//               Positioned(
//                 bottom: 0,
//                 child: Container(
//                   height: 25,
//                   width: 90,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     gradient: AppColor.giftTimeGradient,
//                     borderRadius: BorderRadius.circular(100),
//                     border: Border.all(color: AppColor.white.withValues(alpha: 0.7)),
//                   ),
//                   child: Text(
//                     "2h 45m 26s",
//                     style: AppFontStyle.styleW600(AppColor.lightYellow, 10),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 right: 10,
//                 child: GestureDetector(
//                   onTap: () => Get.back(),
//                   child: Container(
//                     height: 30,
//                     width: 30,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: AppColor.black.withValues(alpha: 0.3),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Image.asset(AppAssets.icClose, color: AppColor.white, width: 15),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
