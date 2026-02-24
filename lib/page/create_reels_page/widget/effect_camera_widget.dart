import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/circle_icon_button_ui.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/create_reels_page/controller/create_reels_controller.dart';
import 'package:tingle/page/create_reels_page/widget/add_music_bottom_sheet_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class EffectCameraWidget extends GetView<CreateReelsController> {
  const EffectCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: AppColor.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GetBuilder<CreateReelsController>(
            id: "onInitializeEffect",
            builder: (controller) => controller.isInitializeEffect
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    color: AppColor.transparent,
                    child: Transform.scale(
                      scale: (Get.width / Get.height) * 4,
                      child: Offstage(),
                      // child: DeepArPreview(controller.deepArController),
                    ),
                  )
                : Container(
                    height: Get.height,
                    width: Get.width,
                    color: AppColor.black,
                    child: const LoadingWidget(),
                  ),
          ),
          Positioned(
            top: 0,
            child: Container(
              height: 100,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.black.withValues(alpha: 0.7), AppColor.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 350,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.6), AppColor.black.withValues(alpha: 0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 35,
            child: GetBuilder<CreateReelsController>(
              id: "onChangeRecordingEvent",
              builder: (controller) => Visibility(
                visible: controller.isRecording != "stop",
                child: SizedBox(
                  width: Get.width,
                  child: GetBuilder<CreateReelsController>(
                    id: "onChangeTimer",
                    builder: (controller) => Container(
                      height: 6,
                      width: Get.width,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.white.withValues(alpha: 0.6),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 6,
                          width: controller.countTime * ((Get.width - 30) / controller.selectedDuration),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: AppColor.primaryGradient,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            child: GetBuilder<CreateReelsController>(
              id: "onChangeSound",
              builder: (controller) => Visibility(
                visible: controller.selectedSound != null,
                child: SizedBox(
                  width: Get.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColor.white,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(AppAssets.icImagePlaceHolder, height: 25),
                            AspectRatio(
                              aspectRatio: 1,
                              child: PreviewPostImageWidget(image: controller.selectedSound?["image"]),
                            ),
                          ],
                        ),
                      ),
                      10.width,
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          controller.selectedSound?["name"] ?? "",
                          maxLines: 2,
                          style: AppFontStyle.styleW500(AppColor.white, 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 65,
            child: SizedBox(
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleIconButtonUi(
                      circleSize: 40,
                      iconSize: 20,
                      color: AppColor.white.withValues(alpha: 0.15),
                      icon: AppAssets.icClose,
                      iconColor: AppColor.white,
                      callback: () {
                        Get.back();
                      },
                    ),
                    20.height,
                    GetBuilder<CreateReelsController>(
                      id: "onSwitchEffectFlash",
                      builder: (controller) => CircleIconButtonUi(
                        circleSize: 40,
                        iconSize: 20,
                        gradient: AppColor.primaryGradient,
                        icon: controller.isFlashOn ? AppAssets.icFlashOn : AppAssets.icFlashOff,
                        iconColor: AppColor.white,
                        callback: controller.onSwitchEffectFlash,
                      ),
                    ),
                    20.height,
                    GetBuilder<CreateReelsController>(
                      builder: (controller) => CircleIconButtonUi(
                        circleSize: 40,
                        iconSize: 20,
                        gradient: AppColor.primaryGradient,
                        icon: AppAssets.icCameraRotate,
                        iconColor: AppColor.white,
                        callback: controller.onSwitchEffectCamera,
                      ),
                    ),
                    20.height,
                    CircleIconButtonUi(
                      circleSize: 40,
                      iconSize: 17,
                      gradient: AppColor.primaryGradient,
                      padding: const EdgeInsets.only(right: 2),
                      icon: AppAssets.icMusic,
                      iconColor: AppColor.white,
                      callback: () {
                        AddMusicBottomSheetWidget.show(context: context);
                      },
                    ),
                    20.height,
                    GetBuilder<CreateReelsController>(
                      builder: (controller) => CircleIconButtonUi(
                        circleSize: 40,
                        iconSize: 20,
                        gradient: AppColor.primaryGradient,
                        icon: AppAssets.icEffect,
                        iconColor: AppColor.white,
                        callback: () {
                          controller.onToggleEffect();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 185,
            child: GetBuilder<CreateReelsController>(
              id: "onToggleEffect",
              builder: (controller) => Visibility(
                visible: controller.isShowEffects,
                child: Container(
                  height: 100,
                  width: Get.width,
                  color: AppColor.transparent,
                  child: Center(
                    child: GetBuilder<CreateReelsController>(
                      builder: (logic) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.effectsCollection.length,
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GetBuilder<CreateReelsController>(
                              id: "onChangeEffect",
                              builder: (controller) => index == 0
                                  ? GestureDetector(
                                      onTap: () => controller.onClearEffect(index),
                                      child: SizedBox(
                                        width: 90,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(1.2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.transparent,
                                                border: Border.all(color: controller.selectedEffectIndex == index ? AppColor.primary : AppColor.white, width: 1),
                                              ),
                                              child: Container(
                                                height: 60,
                                                alignment: Alignment.center,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.black,
                                                ),
                                                child: Image.asset(AppAssets.icNone, color: AppColor.white, width: 30),
                                              ),
                                            ),
                                            8.height,
                                            SizedBox(
                                              width: 90,
                                              child: Text(
                                                EnumLocal.txtNone.name.tr,
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                                style: AppFontStyle.styleW400(controller.selectedEffectIndex == index ? AppColor.primary : AppColor.white, 14.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () => controller.onChangeEffect(index),
                                      child: SizedBox(
                                        width: 90,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.transparent,
                                                border: Border.all(color: controller.selectedEffectIndex == index ? AppColor.primary : AppColor.white, width: 1),
                                              ),
                                              child: Container(
                                                height: 60,
                                                alignment: Alignment.center,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.transparent,
                                                ),
                                                child: Image.asset(controller.effectImages[index], fit: BoxFit.cover),
                                              ),
                                            ),
                                            8.height,
                                            SizedBox(
                                              width: 90,
                                              child: Text(
                                                controller.effectNames[index],
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                                style: AppFontStyle.styleW400(
                                                  controller.selectedEffectIndex == index ? AppColor.primary : AppColor.white,
                                                  14.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 125,
            child: GetBuilder<CreateReelsController>(
              id: "onChangeRecordingEvent",
              builder: (controller) => Visibility(
                visible: controller.isRecording == "stop",
                child: Container(
                  height: 43,
                  width: Get.width,
                  color: AppColor.transparent,
                  child: Center(
                    child: GetBuilder<CreateReelsController>(
                      id: "onChangeRecordingDuration",
                      builder: (logic) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: logic.recordingDurations.length,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () => logic.onChangeRecordingDuration(index),
                                child: Container(
                                  height: 20,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    color: logic.selectedDuration == logic.recordingDurations[index] ? null : AppColor.white.withValues(alpha: 0.1),
                                    gradient: logic.selectedDuration == logic.recordingDurations[index] ? AppColor.primaryGradient : null,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${logic.recordingDurations[index]}s",
                                      style: AppFontStyle.styleW500(AppColor.white, 14.5),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              width: Get.width,
              color: AppColor.transparent,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  const Expanded(child: Offstage()),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Utils.showToast(text: EnumLocal.txtPleasePressAndHoldTheButtonToProceed.name.tr),
                      onLongPressStart: controller.onLongPressStart,
                      onLongPressEnd: controller.onLongPressEnd,
                      child: Container(
                        height: 100,
                        width: 100,
                        color: AppColor.transparent,
                        child: Center(
                          child: GetBuilder<CreateReelsController>(
                            id: "onChangeRecordingEvent",
                            builder: (controller) => Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 73,
                                  width: 73,
                                  child: CircularProgressIndicator(
                                    value: controller.isRecording == "stop" ? 1 : controller.countTime * (1 / controller.selectedDuration),
                                    backgroundColor: AppColor.white.withValues(alpha: 0.2),
                                    color: controller.isRecording == "stop" ? AppColor.white : AppColor.primary,
                                    strokeWidth: 8,
                                    strokeCap: StrokeCap.round,
                                  ),
                                ),
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.white,
                                    gradient: controller.isRecording == "stop" ? AppColor.primaryGradient : null,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      AppAssets.icPause,
                                      height: 30,
                                      width: 30,
                                      color: AppColor.transparent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Offstage()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
