import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/show_received_gift.dart';
import 'package:tingle/common/widget/stop_live_dialog_widget.dart';
import 'package:tingle/page/fake_audio_room_page/controller/fake_audio_room_controller.dart';
import 'package:tingle/page/fake_audio_room_page/widget/fake_audio_room_app_bar_widget.dart';
import 'package:tingle/page/fake_audio_room_page/widget/fake_audio_room_bottom_bar_widget.dart';
import 'package:tingle/page/fake_audio_room_page/widget/fake_audio_room_comment_widget.dart';
import 'package:tingle/page/fake_audio_room_page/widget/fake_audio_room_seat_widget.dart';

import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

import 'package:tingle/utils/utils.dart';

class FakeAudioRoomView extends GetView<FakeAudioRoomController> {
  const FakeAudioRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 300),
      () {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: AppColor.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        );
      },
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => controller.fakeAudioRoomModel?.isHost == true
          ? StopLiveDialogWidget.onShow(
              title: "Are you sure you want to stop the audio broadcast?",
              callBack: () => Get.close(2),
            )
          : Get.back(),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(gradient: AppColor.audioRoomGradient),
            ),
            SingleChildScrollView(
              child: Container(
                color: AppColor.transparent,
                height: Get.height,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GetBuilder<FakeAudioRoomController>(
                          id: AppConstant.onToggleComment,
                          builder: (controller) => GestureDetector(
                            onTap: () => controller.onToggleComment(),
                            child: Container(
                              color: AppColor.transparent,
                              height: Get.height / 3.3,
                              width: Get.width,
                              alignment: AlignmentDirectional.topStart,
                              child: Visibility(
                                visible: true,
                                child: Container(
                                  height: Get.height / 3.3,
                                  width: Get.width / 1.8,
                                  color: AppColor.transparent,
                                  child: FakeAudioRoomCommentWidget(),
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
            GestureDetector(
              onTap: () {
                log("FakeAudioRoomView: onTap");
              },
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (MediaQuery.of(context).viewPadding.top).height,
                    10.height,
                    FakeAudioRoomAppbarWidget(),
                    10.height,
                    FakeAudioRoomSeatWidget(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                log("FakeAudioRoomView: onTap");
              },
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FakeAudioRoomBottomBarWidget(),
                  ],
                ),
              ),
            ),
            ShowReceivedGift.onShowGift(),
            ShowReceivedGift.onShowSenderDetails(),
          ],
        ),
      ),
    );
  }
}
