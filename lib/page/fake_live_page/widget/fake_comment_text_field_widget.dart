import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tingle/common/widget/stop_live_dialog_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/audio_room_page/widget/game_bottom_sheet_widget.dart';
import 'package:tingle/page/fake_live_page/controller/fake_live_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

//ignore: must_be_immutable
class FakeCommentTextFieldWidget extends GetView<FakeLiveController> {
  FakeCommentTextFieldWidget({super.key, this.ispklive});
  bool? ispklive = false;
  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    final isHost = controller.fakeLiveModel?.isHost ?? false;

    return Container(
      width: Get.width,
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8 + MediaQuery.of(context).padding.bottom),
      decoration: ispklive == false
          ? BoxDecoration(color: AppColor.black.withValues(alpha: 0.3))
          : BoxDecoration(gradient: AppColor.audioRoomGradient),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Upper row: Comment input only
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 15, right: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    height: 22,
                    width: 22,
                    AppAssets.icMessageBorder,
                  ),
                  5.width,
                  VerticalDivider(
                    indent: 12,
                    endIndent: 12,
                    color: AppColor.white.withValues(alpha: 0.5),
                  ),
                  5.width,
                  Expanded(
                    child: TextFormField(
                      controller: controller.fakeLiveModel?.commentController,
                      cursorColor: AppColor.white,
                      maxLines: 1,
                      onChanged: (value) => controller.update([AppConstant.onChanged]),
                      style: AppFontStyle.styleW500(AppColor.white, 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(bottom: 3),
                        hintText: EnumLocal.txtTypeComment.name.tr,
                        hintStyle: AppFontStyle.styleW400(AppColor.white.withValues(alpha: 0.5), 12),
                      ),
                    ),
                  ),
                  5.width,
                  GetBuilder<FakeLiveController>(
                    id: AppConstant.onChanged,
                    builder: (controller) => Visibility(
                      visible: controller.fakeLiveModel?.commentController.text.trim().isNotEmpty ?? false,
                      child: GestureDetector(
                        onTap: controller.onSendComment,
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.only(bottom: 3),
                          color: AppColor.transparent,
                          child: Center(
                            child: Image.asset(width: 22, AppAssets.icSend),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            6.height,
            // Lower row: Action buttons - Call button centered
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gift (left)
                if (!isHost)
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      controller.onClickGift(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Lottie.asset(
                        AppAssets.lottieCup,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        repeat: true,
                        errorBuilder: (_, __, ___) => Image.asset(AppAssets.icLightPinkGift, width: 20, color: AppColor.white),
                      ),
                    ),
                  ),
                // Call button (center) - viewers only
                if (!isHost)
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: controller.onClickVideoCall,
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            gradient: AppColor.coinPinkGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 26,
                                height: 26,
                                child: Lottie.asset(
                                  AppAssets.lottieCallReceive,
                                  width: 26,
                                  height: 26,
                                  fit: BoxFit.contain,
                                  repeat: true,
                                  errorBuilder: (_, __, ___) => Image.asset(AppAssets.icCallReceive, width: 18, color: AppColor.white),
                                ),
                              ),
                              6.width,
                              Text(
                                "${CustomFormatNumber.onConvert(controller.fakeLiveModel?.host1Coin ?? 0)}/min",
                                style: AppFontStyle.styleW600(AppColor.white, 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                // Game button (host)
                if (isHost)
                  GestureDetector(
                    onTap: () => GameBottomSheetWidget.onShow(),
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Lottie.asset(
                        AppAssets.lottieGameController,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        repeat: true,
                        errorBuilder: (_, __, ___) => Image.asset(AppAssets.icGame, width: 24, color: AppColor.white),
                      ),
                    ),
                  ),
                if (isHost) 10.width,
                10.width,
                // Close button
                GestureDetector(
                  onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (isHost) {
                StopLiveDialogWidget.onShow(
                  title: EnumLocal.txtAreYouSureYouWantToStopTheLiveBroadcast.name.tr,
                  callBack: () => Get.back(),
                );
              } else {
                Get.back();
              }
            },
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                isHost ? AppAssets.icPowerOnOff : AppAssets.icClose,
                width: 22,
                color: AppColor.white,
              ),
            ),
          ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
