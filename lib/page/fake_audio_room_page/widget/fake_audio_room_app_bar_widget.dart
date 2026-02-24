import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/stop_live_dialog_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/custom/function/custom_text_fade.dart';

import 'package:tingle/page/fake_audio_room_page/controller/fake_audio_room_controller.dart';
import 'package:tingle/page/fake_audio_room_page/widget/fake_audio_room_setting_bottom_sheet_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeAudioRoomAppbarWidget extends GetView<FakeAudioRoomController> {
  const FakeAudioRoomAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: Get.width,
      color: AppColor.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: Get.width,
            color: AppColor.transparent,
            child: Row(
              children: [
                10.width,
                GetBuilder<FakeAudioRoomController>(
                  id: AppConstant.onSeatUpdate,
                  builder: (controller) => controller.fakeAudioRoomModel?.isHost == true
                      ? Container(
                          width: 170,
                          padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                          decoration: BoxDecoration(
                            color: AppColor.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 38,
                                width: 38,
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.white),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(shape: BoxShape.circle),
                                  child: PreviewProfileImageWidget(
                                    image: controller.fakeAudioRoomModel?.roomImage ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              8.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.fakeAudioRoomModel?.roomName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFontStyle.styleW700(AppColor.white, 10),
                                    ),
                                    2.height,
                                    GetBuilder<FakeAudioRoomController>(
                                      id: AppConstant.onChangeViewCount,
                                      builder: (controller) => Row(
                                        children: [
                                          Image.asset(AppAssets.icViewUser, color: AppColor.white, width: 14),
                                          5.width,
                                          Flexible(
                                            fit: FlexFit.loose,
                                            child: Text(
                                              CustomFormatNumber.onConvert(controller.fakeAudioRoomModel?.viewCount ?? 0),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppFontStyle.styleW700(AppColor.white, 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              5.width,
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            OtherUserProfileBottomSheet.show(context: context, userId: controller.fakeAudioRoomModel!.hostUserId);
                          },
                          child: Container(
                            height: 50,
                            width: 170,
                            padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColor.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 38,
                                  width: 38,
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.white),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      gradient: AppColor.lightYellowOrangeGradient,
                                      shape: BoxShape.circle,
                                    ),
                                    child: PreviewProfileImageWidget(
                                      image: controller.fakeAudioRoomModel?.roomImage ?? "",
                                    ),
                                  ),
                                ),
                                3.width,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FadingAutoScrollText(text: controller.fakeAudioRoomModel?.roomName ?? "", style: AppFontStyle.styleW700(AppColor.white, 10)),
                                      2.height,
                                      Row(
                                        children: [
                                          5.width,
                                          Image.asset(AppAssets.icShow, color: AppColor.white, width: 15),
                                          5.width,
                                          GetBuilder<FakeAudioRoomController>(
                                            id: AppConstant.onChangeViewCount,
                                            builder: (controller) => Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                CustomFormatNumber.onConvert(controller.fakeAudioRoomModel?.viewCount ?? 0),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppFontStyle.styleW700(AppColor.white, 10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                5.width,
                                GetBuilder<FakeAudioRoomController>(
                                  id: AppConstant.onClickFollow,
                                  builder: (controller) => GestureDetector(
                                    onTap: controller.onClickFollow,
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      margin: EdgeInsets.only(left: 8),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: controller.fakeAudioRoomModel?.isFollow == true ? AppColor.white : AppColor.primary,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: controller.fakeAudioRoomModel?.isFollow == true ? AppColor.white : AppColor.primary)),
                                      child: Image.asset(
                                        controller.fakeAudioRoomModel?.isFollow == true ? AppAssets.icFollowing : AppAssets.icFollow,
                                        color: controller.fakeAudioRoomModel?.isFollow == false ? AppColor.white : AppColor.primary,
                                        width: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GetBuilder<FakeAudioRoomController>(
                      id: AppConstant.onChangeViewCount,
                      builder: (controller) => ListView.builder(
                          itemCount: controller.fakeAudioRoomModel?.liveViewers.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final indexData = controller.fakeAudioRoomModel?.liveViewers[index];
                            return Container(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.only(left: 5),
                                child: PreviewProfileImageWithFrameWidget(
                                  image: indexData?.image,
                                  isBanned: indexData?.isProfilePicBanned,
                                  frame: indexData?.avatarFrame,
                                  type: indexData?.avtarFrameType,
                                ));
                          }),
                    ),
                  ),
                ),
                10.width,
                // Container(
                //   height: 40,
                //   width: 40,
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //     color: AppColor.black.withValues(alpha: 0.3),
                //     shape: BoxShape.circle,
                //   ),
                //   child: Image.asset(AppAssets.icManyUser, color: AppColor.white, width: 16),
                // ),
                // 10.width,

                Visibility(
                  visible: controller.fakeAudioRoomModel?.isHost == true,
                  child: GestureDetector(
                    onTap: () => FakeAudioRoomSettingBottomSheetWidget.onShow(),
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AppAssets.icSetting, color: AppColor.white, width: 22),
                    ),
                  ),
                ),
                10.width,
                GestureDetector(
                  onTap: () => controller.fakeAudioRoomModel?.isHost == true
                      ? StopLiveDialogWidget.onShow(
                          title: "Are you sure you want to stop the audio broadcast?",
                          callBack: () => Get.close(2),
                        )
                      : Get.back(),
                  child: Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(controller.fakeAudioRoomModel?.isHost == true ? AppAssets.icPowerOnOff : AppAssets.icClose, color: AppColor.white, width: 20),
                  ),
                ),
                10.width,
              ],
            ),
          ),
          5.height,
          // 🪙 Coin + ID Row
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 2),
                padding: EdgeInsets.only(left: 3, right: 8, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: AppColor.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Image.asset(AppAssets.icCoinStar, width: 18),
                    3.width,
                    Text(
                      CustomFormatNumber.onConvert(Random.secure().nextInt(100000)),
                      style: AppFontStyle.styleW600(AppColor.white, 12),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                "ID:${Random.secure().nextInt(100000000)}",
                style: AppFontStyle.styleW500(AppColor.white.withAlpha(128), 12),
              ),
              15.width,
            ],
          ),

          // 5.height,
          // 5.height,
        ],
      ),
    );
  }
}
