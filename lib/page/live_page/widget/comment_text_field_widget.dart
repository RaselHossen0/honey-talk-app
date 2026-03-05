import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tingle/page/audio_room_page/widget/game_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/icon_button_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/page/live_page/pk_battle_widget/invite_user_for_pk_battle_bottom_sheet.dart';
import 'package:tingle/common/widget/stop_live_dialog_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CommentTextFieldWidget extends GetView<LiveController> {
  const CommentTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    final isHost = controller.liveModel?.isHost ?? false;
    return Container(
      width: Get.width,
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: AppColor.black.withValues(alpha: 0.3),
      ),
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
                  Image.asset(AppAssets.icMessageBorder, height: 22, width: 22),
                  5.width,
                  VerticalDivider(
                    indent: 12,
                    endIndent: 12,
                    color: AppColor.white.withValues(alpha: 0.5),
                  ),
                  5.width,
                  Expanded(
                    child: TextFormField(
                      controller: controller.liveModel?.commentController,
                      cursorColor: AppColor.white,
                      maxLines: 1,
                      onChanged: (value) => controller.update([AppConstant.onChanged]),
                      style: AppFontStyle.styleW500(AppColor.white, 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(bottom: 8),
                        hintText: EnumLocal.txtTypeComment.name.tr,
                        hintStyle: AppFontStyle.styleW400(AppColor.white.withValues(alpha: 0.5), 11),
                      ),
                    ),
                  ),
                  5.width,
                  GetBuilder<LiveController>(
                    id: AppConstant.onChanged,
                    builder: (c) => Visibility(
                      visible: (c.liveModel?.commentController.text.trim().isNotEmpty ?? false),
                      child: GestureDetector(
                        onTap: c.onSendComment,
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          child: Image.asset(AppAssets.icSend, width: 22),
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
                onTap: () => controller.onClickGift(context),
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
                            "${CustomFormatNumber.onConvert(controller.liveModel?.host1Coin ?? 0)}/min",
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
            // 5. Mic (host)
            GetBuilder<LiveController>(
              id: AppConstant.onSwitchMic,
              builder: (c) => IconButtonWidget(
                icon: c.liveModel?.isMute == true ? AppAssets.icMicOff : AppAssets.icMicOn,
                iconColor: AppColor.white,
                iconSize: 20,
                circleSize: 40,
                circleColor: AppColor.white.withValues(alpha: 0.2),
                visible: isHost,
                callback: c.onSwitchMic,
              ),
            ),
            10.width,
            // 6. Camera (host)
            IconButtonWidget(
              icon: AppAssets.icCameraRotate,
              iconColor: AppColor.white,
              iconSize: 20,
              circleSize: 40,
              circleColor: AppColor.white.withValues(alpha: 0.2),
              visible: isHost,
              callback: controller.onSwitchCamera,
            ),
            GetBuilder<LiveController>(
              id: AppConstant.onEventHandler,
              builder: (c) => Visibility(
                visible: (c.liveModel?.isChannelMediaRelay ?? false) == false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButtonWidget(
                    icon: AppAssets.icPkUsers,
                    iconColor: AppColor.white,
                    iconSize: 18,
                    circleSize: 40,
                    circleColor: AppColor.white.withValues(alpha: 0.2),
                    visible: isHost,
                    callback: () => InviteUserForPkBattleBottomSheet.onShow(),
                  ),
                ),
              ),
            ),
            10.width,
            // 7. Close
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (isHost) {
                  StopLiveDialogWidget.onShow(
                    title: EnumLocal.txtAreYouSureYouWantToStopTheLiveBroadcast.name.tr,
                    callBack: () => Get.close(2),
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
