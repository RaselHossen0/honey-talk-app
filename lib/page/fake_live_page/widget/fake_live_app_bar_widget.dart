import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/icon_button_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/scroll_fade_effect_widget.dart';
import 'package:tingle/common/widget/stop_live_dialog_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/custom/function/custom_text_fade.dart';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/fake_live_page/controller/fake_live_controller.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/view/fake_other_user_profile_bottom_sheet.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeLiveAppBarWidget extends StatelessWidget {
  const FakeLiveAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).viewPadding.top + 10,
      child: GetBuilder<FakeLiveController>(
        id: AppConstant.onChangeViewCount,
        builder: (controller) => Container(
          height: 85, // adjusted height to fit both rows
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 15),
          color: AppColor.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                width: Get.width,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        OtherUserProfileBottomSheet.show(
                          context: context,
                          userId: controller.fakeLiveModel?.host1UserId ?? "",
                        );
                      },
                      child: Container(
                        height: 45,
                        width: controller.fakeLiveModel?.isHost == true ? 150 : 180,
                        decoration: BoxDecoration(
                          color: AppColor.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColor.white),
                              ),
                              child: Container(
                                height: 35,
                                width: 35,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                child: PreviewProfileImageWidget(
                                  image: controller.fakeLiveModel?.liveType == 3 ? (controller.fakeLiveModel?.pkThumbnails[0] ?? "") : controller.fakeLiveModel?.host1Image ?? "",
                                  isBanned: controller.fakeLiveModel?.host1ProfilePicIsBanned ?? false,
                                ),
                              ),
                            ),
                            5.width,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: FadingAutoScrollText(
                                          text: controller.fakeLiveModel?.host1Name ?? "",
                                          style: AppFontStyle.styleW700(AppColor.white, 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Image.asset(AppAssets.icShow, width: 16),
                                      ),
                                      Flexible(
                                        child: Text(
                                          CustomFormatNumber.onConvert(controller.fakeLiveModel?.view ?? 0),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.styleW700(AppColor.white, 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: controller.fakeLiveModel?.isHost == false,
                              child: GetBuilder<FakeLiveController>(
                                id: AppConstant.onClickFollow,
                                builder: (controller) => GestureDetector(
                                  onTap: controller.onClickFollow,
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    margin: EdgeInsets.only(left: 8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: controller.fakeLiveModel?.isFollow == true ? AppColor.white : AppColor.primary,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: controller.fakeLiveModel?.isFollow == true ? AppColor.white : AppColor.primary)),
                                    child: Image.asset(
                                      controller.fakeLiveModel?.isFollow == true ? AppAssets.icFollowing : AppAssets.icFollow,
                                      color: controller.fakeLiveModel?.isFollow == false ? AppColor.white : AppColor.primary,
                                      width: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: HorizantalScrollFadeEffectWidget(
                        axis: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: GetBuilder<FakeLiveController>(
                            id: AppConstant.onChangeViewCount,
                            builder: (controller) => ListView.builder(
                              itemCount: controller.fakeLiveModel?.liveViewers.length ?? 0,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final indexData = controller.fakeLiveModel?.liveViewers[index];
                                final frameImage = FakeProfilesSet().rendomFrame().image!;
                                return GestureDetector(
                                  onTap: () => FakeOtherUserProfileBottomSheet.show(
                                    context: context,
                                    userId: controller.fakeLiveModel?.liveViewers[index].userId ?? "",
                                  ),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.only(left: 5),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(shape: BoxShape.circle),
                                          child: PreviewProfileImageWidget(
                                            image: indexData?.image,
                                            isBanned: indexData?.isProfilePicBanned,
                                          ),
                                        ),
                                        frameImage.isEmpty ? SizedBox() : Image.asset(frameImage, height: 40, width: 40),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 🔘 Close / Stop Button
                    IconButtonWidget(
                      icon: controller.fakeLiveModel?.isHost == true ? AppAssets.icPowerOnOff : AppAssets.icClose,
                      iconColor: AppColor.white,
                      iconSize: 22,
                      circleSize: 40,
                      circleColor: AppColor.white.withAlpha(51),
                      visible: true,
                      callback: () => controller.fakeLiveModel?.isHost == true
                          ? StopLiveDialogWidget.onShow(
                              title: "Are you sure you want to stop the live broadcast?",
                              callBack: () => Get.close(2),
                            )
                          : Get.back(),
                    ),
                  ],
                ),
              ),
              5.height,
              // 🪙 Coin + ID Row
              Row(
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 10, top: 2),
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
                    "${EnumLocal.txtID.name.tr}${Random.secure().nextInt(100000000)}",
                    style: AppFontStyle.styleW500(AppColor.white.withAlpha(128), 12),
                  ),
                  5.width,
                ],
              ),

              5.height,

              // 👤 Host Info + Viewers + Action Buttons
            ],
          ),
        ),
      ),
    );
  }
}
