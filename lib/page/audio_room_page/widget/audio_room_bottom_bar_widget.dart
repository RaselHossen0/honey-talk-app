import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_gift_bottom_sheet_widget.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_text_field_widget.dart';
import 'package:tingle/page/audio_room_page/widget/emoji_bottom_sheet_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomBottomBarWidget extends GetView<AudioRoomController> {
  const AudioRoomBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Container(
        height: 50,
        width: Get.width,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            GetBuilder<AudioRoomController>(
                id: AppConstant.onChangeTextField,
                builder: (controller) =>
                    // controller.isShowTextField
                    AudioRoomTextFieldWidget()),
            10.width,
            // GestureDetector(
            //   onTap: () => GameBottomSheetWidget.onShow(),
            //   child: Container(
            //     height: 40,
            //     width: 40,
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       color: AppColor.white.withValues(alpha: 0.2),
            //       shape: BoxShape.circle,
            //     ),
            //     child: Image.asset(AppAssets.icGame, width: 26),
            //   ),
            // ),
            10.width,
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                EmojiBottomSheetWidget.onShow();
              },
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppAssets.icAudioRoomEmoji, width: 35),
              ),
            ),
            10.width,
            GetBuilder<AudioRoomController>(
              id: AppConstant.onSwitchMic,
              builder: (controller) => Visibility(
                visible: (controller.audioRoomModel?.audioRoomSeats.any((element) => element.userId == Database.loginUserId) ?? false),
                child: GestureDetector(
                  onTap: controller.onSwitchMic,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: controller.audioRoomModel?.mute == 3 ? AppColor.white.withValues(alpha: 0.5) : AppColor.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      controller.audioRoomModel?.mute == 2 ? AppAssets.icMicOn : AppAssets.icMicOff,
                      color: AppColor.white,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<AudioRoomController>(
              id: AppConstant.onSeatUserUpdate,
              builder: (controller) => Visibility(
                visible: controller.audioRoomModel?.seatUsers.isNotEmpty ?? false,
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    AudioRoomGiftBottomSheetWidget.onShow(context: context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(AppAssets.icLightPinkGift, width: 24),
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
