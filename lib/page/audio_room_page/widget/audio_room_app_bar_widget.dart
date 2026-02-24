import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/custom_text_scrolling.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/stop_live_dialog_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_setting_bottom_sheet_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/routes/app_routes.dart';

import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomAppbarWidget extends GetView<AudioRoomController> {
  const AudioRoomAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width,
      color: AppColor.transparent,
      child: Column(
        children: [
          Container(
            height: 50,
            width: Get.width,
            color: AppColor.transparent,
            child: Row(
              children: [
                10.width,
                GetBuilder<AudioRoomController>(
                  id: AppConstant.onSeatUpdate,
                  builder: (controller) => Container(
                    width: (controller.audioRoomModel?.isHost == true) ? 170 : 170,
                    padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (Database.loginUserId != controller.audioRoomModel?.hostUserId) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                OtherUserProfileBottomSheet.show(context: context, userId: controller.audioRoomModel?.hostUserId ?? "");
                              } else {
                                // GOTO OWN PROFILE PAGE
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.toNamed(AppRoutes.previewUserProfilePage, arguments: controller.audioRoomModel?.hostUserId ?? "");
                              }
                            },
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
                                      image: controller.audioRoomModel?.roomImage ?? "",
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
                                      CustomTextScrolling(
                                        text: controller.audioRoomModel?.roomName ?? "",
                                        style: AppFontStyle.styleW700(AppColor.white, 10),
                                      ),
                                      3.height,
                                      GetBuilder<AudioRoomController>(
                                        id: AppConstant.onChangeViewCount,
                                        builder: (controller) => Row(
                                          children: [
                                            Image.asset(AppAssets.icShow, color: AppColor.white, width: 14),
                                            5.width,
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                CustomFormatNumber.onConvert(controller.audioRoomModel?.viewCount ?? 0),
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
                              ],
                            ),
                          ),
                        ),
                        5.width,
                        (controller.audioRoomModel?.isHost == true)
                            ? GestureDetector(
                                onTap: () => controller.scaffoldKey.currentState?.openEndDrawer(),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(AppAssets.icManyUser, color: AppColor.white, width: 16),
                                ),
                              )
                            : GetBuilder<AudioRoomController>(
                                id: AppConstant.onClickFollow,
                                builder: (controller) => GestureDetector(
                                  onTap: controller.onClickFollow,
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: controller.audioRoomModel?.isFollow == true ? AppColor.white : AppColor.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      controller.audioRoomModel?.isFollow == true ? AppAssets.icFollowing : AppAssets.icFollow,
                                      color: controller.audioRoomModel?.isFollow == true ? AppColor.primary : AppColor.white,
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GetBuilder<AudioRoomController>(
                      id: AppConstant.onUpdateTopGiftUser,
                      builder: (controller) => ListView.builder(
                          itemCount: controller.audioRoomModel?.liveTopGiftUsers.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final indexData = controller.audioRoomModel?.liveTopGiftUsers[index];
                            return GestureDetector(
                              onTap: () {
                                if (Database.loginUserId != indexData?.userId?.id) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  OtherUserProfileBottomSheet.show(context: context, userId: indexData?.userId?.id ?? "");
                                } else {
                                  // GOTO OWN PROFILE PAGE
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Get.toNamed(AppRoutes.previewUserProfilePage, arguments: indexData?.userId?.id ?? "");
                                }
                              },
                              child: Container(
                                height: 38,
                                width: 38,
                                padding: EdgeInsets.only(left: 5),
                                child: PreviewProfileImageWithFrameWidget(
                                  image: indexData?.userId?.image,
                                  isBanned: indexData?.userId?.isProfilePicBanned,
                                  fit: BoxFit.cover,
                                  frame: indexData?.userId?.activeAvtarFrameImage,
                                  type: indexData?.userId?.activeAvtarFrameType,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                10.width,
                Visibility(
                  visible: controller.audioRoomModel?.isHost == true,
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      AudioRoomSettingBottomSheetWidget.onShow();
                    },
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
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (controller.audioRoomModel?.isHost == true) {
                      StopLiveDialogWidget.onShow(
                        title: EnumLocal.txtAreYouSureYouWantToStopTheAudioBroadcast.name.tr,
                        callBack: () => Get.close(2),
                      );
                    } else {
                      Get.back();
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(controller.audioRoomModel?.isHost == true ? AppAssets.icPowerOnOff : AppAssets.icClose, color: AppColor.white, width: 20),
                  ),
                ),
                10.width,
              ],
            ),
          ),
          10.height,
          Row(
            children: [
              10.width,
              // Container(
              //   height: 30,
              //   padding: EdgeInsets.only(left: 5, right: 8, top: 5, bottom: 5),
              //   decoration: BoxDecoration(
              //     color: AppColor.white.withValues(alpha: 0.3),
              //     borderRadius: BorderRadius.circular(100),
              //   ),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 50,
              //         padding: EdgeInsets.only(left: 5, right: 8),
              //         decoration: BoxDecoration(
              //           gradient: AppColor.lightOrangeYellowGradient,
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: Row(
              //           children: [
              //             Image.asset(AppAssets.icRedYellowColorFire, width: 12),
              //             3.width,
              //             Text(
              //               "Hours",
              //               style: AppFontStyle.styleW700(AppColor.white, 12),
              //             ),
              //           ],
              //         ),
              //       ),
              //       5.width,
              //       Text(
              //         "No.4",
              //         style: AppFontStyle.styleW700(AppColor.lightYellow, 12),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                height: 25,
                padding: EdgeInsets.only(left: 5, right: 8),
                decoration: BoxDecoration(
                  color: AppColor.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Image.asset(AppAssets.icCoinStar, width: 18),
                    5.width,
                    GetBuilder<AudioRoomController>(
                      id: AppConstant.onUpdateCoin,
                      builder: (controller) => Text(
                        CustomFormatNumber.onConvert(controller.audioRoomModel?.audioRoomEarnedCoin ?? 0),
                        style: AppFontStyle.styleW700(AppColor.lightYellow, 12),
                      ),
                    ),
                    5.width,
                  ],
                ),
              ),
              10.width,
              // Container(
              //   height: 30,
              //   padding: EdgeInsets.only(left: 5, right: 8, top: 4, bottom: 4),
              //   decoration: BoxDecoration(
              //     color: AppColor.bluePurple,
              //     borderRadius: BorderRadius.circular(100),
              //   ),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 50,
              //         padding: EdgeInsets.only(left: 5, right: 8),
              //         decoration: BoxDecoration(
              //           color: AppColor.white,
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: Row(
              //           children: [
              //             Image.asset(AppAssets.icLotus, width: 15),
              //             3.width,
              //             Text(
              //               "16",
              //               style: AppFontStyle.styleW700(AppColor.darkBlue, 12),
              //             ),
              //           ],
              //         ),
              //       ),
              //       5.width,
              //       Text(
              //         "2560.45k",
              //         style: AppFontStyle.styleW700(AppColor.white, 10),
              //       ),
              //     ],
              //   ),
              // ),
              Spacer(),
              Text(
                "ID:${controller.audioRoomModel?.hostUniqueId ?? ""}",
                style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.5), 10),
              ),
              10.width,
            ],
          ),
          10.height,
        ],
      ),
    );
  }
}
