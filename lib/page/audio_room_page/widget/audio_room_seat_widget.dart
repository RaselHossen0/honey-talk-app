import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/custom_text_scrolling.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomSeatWidget extends GetView<AudioRoomController> {
  const AudioRoomSeatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width / 1.2,
      color: AppColor.transparent,
      child: GetBuilder<AudioRoomController>(
        id: AppConstant.onSeatUpdate,
        builder: (controller) => GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: controller.audioRoomModel?.audioRoomSeats.length == 15 ? 5 : 4,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: controller.audioRoomModel?.audioRoomSeats.length ?? 0,
          itemBuilder: (context, index) {
            final indexData = controller.audioRoomModel?.audioRoomSeats[index];
            return GetBuilder<AudioRoomController>(
              id: AppConstant.onUpdateParticularSeat,
              builder: (controller) => indexData?.userId != null
                  ? UserSeatWidget(index: index)
                  : indexData?.lock == true
                      ? LockSeatWidget(index: indexData?.position ?? 0)
                      : BlankSeatWidget(index: index),
            );
          },
        ),
      ),
    );
  }
}

class BlankSeatWidget extends GetView<AudioRoomController> {
  const BlankSeatWidget({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      return GestureDetector(
        onTap: () => controller.onClickSeat(position: index, context: context),
        child: Container(
          decoration: BoxDecoration(
            color: index % 2 == 0 ? AppColor.seatColorSec : AppColor.seatColorOne,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: (box.maxHeight) * 0.15,
                    width: (box.maxHeight) * 0.15,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: 2, bottom: 2),
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular((box.maxHeight) * 0.09)),
                    ),
                    child: Text(
                      "${index + 1}",
                      style: AppFontStyle.styleW600(AppColor.white, (box.maxHeight) * 0.08),
                    ),
                  ),
                  Center(
                    child: controller.audioRoomModel?.loadingSeatIndex == index
                        ? LoadingWidget(size: 35, color: AppColor.white)
                        : Image.asset(
                            AppAssets.icSeatPlus,
                            width: (box.maxHeight) * 0.35,
                          ),
                  ),
                  18.height,
                ],
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Visibility(
                  visible: controller.audioRoomModel?.audioRoomSeats[index].mute == 3,
                  child: MicWidget(
                    height: 12,
                    width: 12,
                    color: AppColor.red,
                    image: controller.audioRoomModel?.audioRoomSeats[index].mute == 2 ? AppAssets.icMicOn : AppAssets.icMicOff,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LockSeatWidget extends GetView<AudioRoomController> {
  const LockSeatWidget({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      return GestureDetector(
        onTap: () => controller.onClickSeat(position: index, context: context),
        child: Container(
          decoration: BoxDecoration(
            color: index % 2 == 0 ? AppColor.seatColorSec : AppColor.seatColorOne,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: (box.maxHeight) * 0.15,
                    width: (box.maxHeight) * 0.15,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: 2, bottom: 2),
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular((box.maxHeight) * 0.09)),
                    ),
                    child: Text(
                      (index + 1).toString(),
                      style: AppFontStyle.styleW600(AppColor.white, (box.maxHeight) * 0.08),
                    ),
                  ),
                  Center(
                    child: controller.audioRoomModel?.loadingSeatIndex == index
                        ? LoadingWidget(size: 35, color: AppColor.white)
                        : Image.asset(
                            AppAssets.icLock,
                            width: (box.maxHeight) * 0.35,
                          ),
                  ),
                  18.height,
                ],
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Visibility(
                  visible: controller.audioRoomModel?.audioRoomSeats[index].mute == 3,
                  child: MicWidget(
                    height: 12,
                    width: 12,
                    color: AppColor.red,
                    image: controller.audioRoomModel?.audioRoomSeats[index].mute == 2 ? AppAssets.icMicOn : AppAssets.icMicOff,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class UserSeatWidget extends GetView<AudioRoomController> {
  const UserSeatWidget({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return GestureDetector(
          onTap: () => controller.onClickSeat(position: index, context: context),
          child: Container(
            height: box.maxHeight,
            width: box.maxWidth,
            decoration: BoxDecoration(
              color: AppColor.white.withValues(alpha: 0.1),
            ),
            child: controller.audioRoomModel?.loadingSeatIndex == index
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: (box.maxHeight) * 0.15,
                        width: (box.maxHeight) * 0.15,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 2, bottom: 2),
                        decoration: BoxDecoration(
                          color: AppColor.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular((box.maxHeight) * 0.09)),
                        ),
                        child: Text(
                          "${index + 1}",
                          style: AppFontStyle.styleW600(AppColor.white, (box.maxHeight) * 0.08),
                        ),
                      ),
                      Container(
                        height: (box.maxHeight) * 0.15,
                        width: (box.maxHeight) * 0.15,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 2, bottom: 2),
                        decoration: BoxDecoration(
                          color: AppColor.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular((box.maxHeight) * 0.09)),
                        ),
                        child: Text(
                          "${index + 1}",
                          style: AppFontStyle.styleW600(AppColor.white, (box.maxHeight) * 0.08),
                        ),
                      ),
                      Center(child: LoadingWidget(size: 35, color: AppColor.white)),
                      18.height,
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: (box.maxHeight) * 0.15,
                            width: (box.maxHeight) * 0.15,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 2, bottom: 2),
                            decoration: BoxDecoration(
                              color:
                                  controller.audioRoomModel?.hostUserId == controller.audioRoomModel?.audioRoomSeats[index].userId ? null : AppColor.white.withValues(alpha: 0.3),
                              gradient:
                                  controller.audioRoomModel?.hostUserId == controller.audioRoomModel?.audioRoomSeats[index].userId ? AppColor.lightYellowOrangeGradient : null,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                            ),
                            child: controller.audioRoomModel?.hostUserId == controller.audioRoomModel?.audioRoomSeats[index].userId
                                ? Image.asset(AppAssets.icSmallHomeIcon, width: (box.maxHeight) * 0.08)
                                : Text(
                                    (index + 1).toString(),
                                    style: AppFontStyle.styleW600(AppColor.white, (box.maxHeight) * 0.08),
                                  ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(right: 2, top: 2),
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.only(left: 3, right: 5, top: 2, bottom: 2),
                          //   decoration: BoxDecoration(
                          //     color: AppColor.black.withValues(alpha: 0.3),
                          //     borderRadius: BorderRadius.circular(100),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       Image.asset(AppAssets.icCoinStar, width: 12),
                          //       3.width,
                          //       Text(
                          //         CustomFormatNumber.onConvert(controller.audioRoomModel?.audioRoomSeats[index].coin ?? 0),
                          //         style: AppFontStyle.styleW600(AppColor.white, 8),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      controller.audioRoomModel?.reactions[index] != null
                          ? SizedBox(
                              height: box.maxHeight / 2.5,
                              width: box.maxHeight / 2.5,
                              child: Center(child: PreviewPostImageWidget(image: controller.audioRoomModel?.reactions[index]?.image)),
                            )
                          : Container(
                              height: box.maxHeight / 2.5,
                              width: box.maxHeight / 2.5,
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                border: Border.all(color: controller.audioRoomModel?.audioRoomSeats[index].avtarFrame == null ? AppColor.white : AppColor.transparent),
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: box.maxHeight / 2.5,
                                    width: box.maxHeight / 2.5,
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: AppColor.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: PreviewProfileImageWithFrameWidget(
                                      image: controller.audioRoomModel?.audioRoomSeats[index].image,
                                      isBanned: controller.audioRoomModel?.audioRoomSeats[index].isProfilePicBanned,
                                      frame: controller.audioRoomModel?.audioRoomSeats[index].avtarFrame,
                                      type: controller.audioRoomModel?.audioRoomSeats[index].avtarFrameType,
                                      margin: EdgeInsets.all(5),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -3,
                                    right: -3,
                                    child: Visibility(
                                      visible: controller.audioRoomModel?.audioRoomSeats[index].mute != 0,
                                      child: MicWidget(
                                        height: box.maxHeight / 6,
                                        width: box.maxHeight / 6,
                                        color: controller.audioRoomModel?.audioRoomSeats[index].mute == 1
                                            ? AppColor.grayText // Mic Mute
                                            : controller.audioRoomModel?.audioRoomSeats[index].mute == 2
                                                ? AppColor.primary // Mic Un_mute
                                                : AppColor.red, // Mic Mute By Admin
                                        image: controller.audioRoomModel?.audioRoomSeats[index].mute == 2 ? AppAssets.icMicOn : AppAssets.icMicOff,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: CustomTextScrolling(
                          text: controller.audioRoomModel?.audioRoomSeats[index].name ?? "",
                          style: AppFontStyle.styleW600(AppColor.white, (box.maxHeight) * 0.09),
                        ),
                        //
                        // Text(
                        //   controller.audioRoomModel?.audioRoomSeats[index].name ?? "",
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: AppFontStyle.styleW600(AppColor.white, 11),
                        // ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class MicWidget extends StatelessWidget {
  const MicWidget({super.key, required this.height, required this.width, required this.color, required this.image});

  final double height;
  final double width;
  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        image,
        color: AppColor.white,
      ),
    );
  }
}
