import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_text_fade.dart';
import 'package:tingle/page/fake_audio_room_page/controller/fake_audio_room_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeAudioRoomSeatWidget extends GetView<FakeAudioRoomController> {
  const FakeAudioRoomSeatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.transparent,
      child: GetBuilder<FakeAudioRoomController>(
        id: AppConstant.onSeatUpdate,
        builder: (controller) => GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: controller.fakeAudioRoomModel?.audioRoomSeats.length ?? 0,
          itemBuilder: (context, index) {
            final indexData = controller.fakeAudioRoomModel?.audioRoomSeats[index];
            return GetBuilder<FakeAudioRoomController>(
              id: AppConstant.onUpdateParticularSeat,
              builder: (controller) => indexData?.userId != null
                  ? UserSeatWidget(index: index)
                  : indexData?.lock == true && index != 14
                      ? LockSeatWidget(index: index)
                      : BlankSeatWidget(index: index),
            );
          },
        ),
      ),
    );
  }
}

class BlankSeatWidget extends GetView<FakeAudioRoomController> {
  const BlankSeatWidget({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onClickSeat(position: index, context: context, userId: ""),
      child: Container(
        decoration: BoxDecoration(
          color: index % 2 == 0 ? AppColor.seatColorOne : AppColor.seatColorSec,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 16,
                  width: 18,
                ),
                Center(
                  child: controller.fakeAudioRoomModel?.loadingSeatIndex == index ? LoadingWidget(size: 35, color: AppColor.white) : Image.asset(AppAssets.icSeat, width: 35),
                ),
                18.height,
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Visibility(
                visible: controller.fakeAudioRoomModel?.audioRoomSeats[index].mute == 3,
                child: MicWidget(
                  height: 12,
                  width: 12,
                  color: AppColor.red,
                  image: controller.fakeAudioRoomModel?.audioRoomSeats[index].mute == 2 ? AppAssets.icMicOn : AppAssets.icMicOff,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LockSeatWidget extends GetView<FakeAudioRoomController> {
  const LockSeatWidget({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onClickSeat(position: index, context: context, userId: ""),
      child: Container(
        decoration: BoxDecoration(
          color: index % 2 == 0 ? AppColor.seatColorOne : AppColor.seatColorSec,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                  width: 18,
                ),
                Center(child: controller.fakeAudioRoomModel?.loadingSeatIndex == index ? LoadingWidget(size: 35, color: AppColor.white) : Image.asset(AppAssets.icLock, width: 32)),
                18.height,
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Visibility(
                visible: controller.fakeAudioRoomModel?.audioRoomSeats[index].mute == 3,
                child: MicWidget(
                  height: 12,
                  width: 12,
                  color: AppColor.red,
                  image: controller.fakeAudioRoomModel?.audioRoomSeats[index].mute == 2 ? AppAssets.icMicOn : AppAssets.icMicOff,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserSeatWidget extends GetView<FakeAudioRoomController> {
  const UserSeatWidget({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return GestureDetector(
          onTap: () => controller.onClickSeat(position: index, context: context, userId: controller.fakeAudioRoomModel?.audioRoomSeats[index].userId),
          child: Container(
            height: box.maxHeight,
            width: box.maxWidth,
            decoration: BoxDecoration(
              color: index % 2 == 0 ? AppColor.seatColorOne : AppColor.seatColorSec,
            ),
            child: controller.fakeAudioRoomModel?.loadingSeatIndex == index
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.fakeAudioRoomModel?.audioRoomSeats[index].userId == Database.loginUserId
                          ? Container(
                              height: 16,
                              width: 18,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 2, bottom: 2),
                              decoration: BoxDecoration(
                                gradient: AppColor.lightYellowOrangeGradient,
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                              ),
                              child: Image.asset(AppAssets.icSmallHomeIcon, width: 10),
                            )
                          : SizedBox(),
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
                            height: 16,
                            width: 18,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 2, bottom: 2),
                            decoration: controller.fakeAudioRoomModel?.audioRoomSeats[index].userId == Database.loginUserId
                                ? BoxDecoration(
                                    gradient: AppColor.lightYellowOrangeGradient,
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                  )
                                : BoxDecoration(color: AppColor.transparent),
                            child: controller.fakeAudioRoomModel?.audioRoomSeats[index].userId == Database.loginUserId
                                ? Image.asset(AppAssets.icSmallHomeIcon, width: 10)
                                : SizedBox(),
                          ),
                        ],
                      ),
                      controller.fakeAudioRoomModel?.reactions[index] != null
                          ? SizedBox(
                              height: box.maxHeight / 2.5,
                              width: box.maxHeight / 2.5,
                              child: Center(child: PreviewPostImageWidget(image: controller.fakeAudioRoomModel?.reactions[index]?.image)),
                            )
                          : Container(
                              height: box.maxHeight / 2.5,
                              width: box.maxHeight / 2.5,
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.white),
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
                                      gradient: AppColor.lightYellowOrangeGradient,
                                      shape: BoxShape.circle,
                                    ),
                                    child: PreviewProfileImageWidget(
                                      image: controller.fakeAudioRoomModel?.audioRoomSeats[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -3,
                                    right: -3,
                                    child: Visibility(
                                      visible: controller.fakeAudioRoomModel?.audioRoomSeats[index].mute != 0,
                                      child: MicWidget(
                                        height: box.maxHeight / 6,
                                        width: box.maxHeight / 6,
                                        color: controller.fakeAudioRoomModel?.audioRoomSeats[index].mute == 1
                                            ? AppColor.primary // Mic Mute
                                            : controller.fakeAudioRoomModel?.audioRoomSeats[index].mute == 2
                                                ? AppColor.primary // Mic Un_mute
                                                : AppColor.red, // Mic Mute By Admin
                                        image: controller.fakeAudioRoomModel?.audioRoomSeats[index].mute == 2 ? AppAssets.icMicOn : AppAssets.icMicOff,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
                          child: FadingAutoScrollText(text: controller.fakeAudioRoomModel?.audioRoomSeats[index].name ?? "", style: AppFontStyle.styleW600(AppColor.white, 10))
                          // CustomTextScrolling(text: controller.fakeAudioRoomModel?.roomName ?? "", style: AppFontStyle.styleW700(AppColor.white, 12)),
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
