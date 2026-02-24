import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OtherUserFollowChatWidget extends StatelessWidget {
  const OtherUserFollowChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 10,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Column(
          children: [
            5.height,
            Row(
              children: [
                20.width,
                Expanded(
                  child: !(OtherUserProfileBottomSheet.isFollowed)
                      ? GestureDetector(
                          onTap: () => OtherUserProfileBottomSheet.onClickFollow(),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.icFollow,
                                    height: 20,
                                    width: 20,
                                    color: AppColor.white,
                                  ),
                                  10.width,
                                  Text(
                                    EnumLocal.txtFollowMe.name.tr,
                                    style: AppFontStyle.styleW600(AppColor.white, 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => OtherUserProfileBottomSheet.onClickFollow(),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: AppColor.primary, width: 2),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.icFollowing,
                                    height: 20,
                                    width: 20,
                                    color: AppColor.primary,
                                  ),
                                  10.width,
                                  Text(
                                    EnumLocal.txtFollowing.name.tr,
                                    style: AppFontStyle.styleW600(AppColor.primary, 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed(
                        AppRoutes.chatPage,
                        arguments: {
                          ApiParams.roomId: "",
                          ApiParams.receiverUserId: OtherUserProfileBottomSheet.otherUserProfileModel?.user?.id ?? "",
                          ApiParams.name: OtherUserProfileBottomSheet.otherUserProfileModel?.user?.name ?? "",
                          ApiParams.image: OtherUserProfileBottomSheet.otherUserProfileModel?.user?.image ?? "",
                          ApiParams.isBanned: OtherUserProfileBottomSheet.otherUserProfileModel?.user?.isProfilePicBanned ?? false,
                          ApiParams.isVerify: OtherUserProfileBottomSheet.otherUserProfileModel?.user?.isVerified ?? false,
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: AppColor.coinPinkGradient,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.icHello,
                              height: 20,
                              width: 20,
                              color: AppColor.white,
                            ),
                            10.width,
                            Text(
                              EnumLocal.txtSayHello.name.tr,
                              style: AppFontStyle.styleW600(AppColor.white, 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                20.width,
              ],
            ),
            5.height,
          ],
        ),
      ),
    );
  }
}
