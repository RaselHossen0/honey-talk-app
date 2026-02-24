import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/custom_text_scrolling.dart';
import 'package:tingle/common/widget/icon_button_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/stop_live_dialog_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class LiveAppBarWidget extends StatelessWidget {
  const LiveAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).viewPadding.top + 15,
      child: GetBuilder<LiveController>(
        id: AppConstant.onChangeViewCount,
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: AppColor.transparent,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: controller.liveModel?.isHost == true ? 150 : 180,
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (Database.loginUserId != controller.liveModel?.host1UserId) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              OtherUserProfileBottomSheet.show(context: context, userId: controller.liveModel?.host1UserId ?? "");
                            } else {
                              // GOTO OWN PROFILE PAGE
                              FocusManager.instance.primaryFocus?.unfocus();
                              Get.toNamed(AppRoutes.previewUserProfilePage, arguments: controller.liveModel?.host1UserId ?? "");
                            }
                          },
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.white),
                            ),
                            child: Container(
                              height: 38,
                              width: 38,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: PreviewProfileImageWidget(
                                image: controller.liveModel?.host1Image ?? "",
                                isBanned: controller.liveModel?.host1ProfilePicIsBanned ?? false,
                              ),
                            ),
                          ),
                        ),
                        10.width,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextScrolling(
                                text: controller.liveModel?.host1Name ?? "",
                                style: AppFontStyle.styleW700(AppColor.white, 10),
                              ),
                              3.height,
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Image.asset(AppAssets.icShow, width: 16),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      CustomFormatNumber.onConvert(controller.liveModel?.host1ViewCount ?? 0),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFontStyle.styleW700(AppColor.white, 10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        5.width,
                        controller.liveModel?.isHost == true
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
                            : GetBuilder<LiveController>(
                                id: AppConstant.onClickFollow,
                                builder: (controller) => GestureDetector(
                                  onTap: controller.onClickFollow,
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    margin: EdgeInsets.only(left: 3),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: controller.liveModel?.isFollow == true ? AppColor.white : AppColor.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      controller.liveModel?.isFollow == true ? AppAssets.icFollowing : AppAssets.icFollow,
                                      color: controller.liveModel?.isFollow == true ? AppColor.primary : AppColor.white,
                                      width: 22,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  5.width,
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GetBuilder<LiveController>(
                        id: AppConstant.onUpdateTopGiftUser,
                        builder: (controller) => ListView.builder(
                            itemCount: controller.liveModel?.liveTopGiftUsers.length ?? 0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final indexData = controller.liveModel?.liveTopGiftUsers[index];
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
                  IconButtonWidget(
                    icon: controller.liveModel?.isHost == true ? AppAssets.icPowerOnOff : AppAssets.icClose,
                    iconColor: AppColor.white,
                    iconSize: 22,
                    circleSize: 40,
                    circleColor: AppColor.white.withValues(alpha: 0.2),
                    visible: true,
                    callback: () {
                      FocusManager.instance.primaryFocus?.unfocus();

                      if (controller.liveModel?.isHost == true) {
                        StopLiveDialogWidget.onShow(
                          title: EnumLocal.txtAreYouSureYouWantToStopTheLiveBroadcast.name.tr,
                          callBack: () => Get.close(2),
                        );
                      } else {
                        Get.back();
                      }
                    },
                  ),
                ],
              ),
            ),
            10.height,
            SizedBox(
              width: Get.width / 2,
              child: Row(
                children: [
                  15.width,
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
                        GetBuilder<LiveController>(
                          id: AppConstant.onUpdateCoin,
                          builder: (controller) => Text(
                            CustomFormatNumber.onConvert(controller.liveModel?.liveEarnedCoin ?? 0),
                            style: AppFontStyle.styleW700(AppColor.lightYellow, 12),
                          ),
                        ),
                        5.width,
                      ],
                    ),
                  ),
                  10.width,
                  Text(
                    "${EnumLocal.txtID.name.tr} ${controller.liveModel?.host1UniqueId ?? ""}",
                    style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.5), 10),
                  ),
                  10.width,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
