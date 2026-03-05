import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_user_info_row_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileDetailsWidget extends StatelessWidget {
  const PreviewProfileDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Large profile header image with overlays
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: Get.height * 0.48,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.imgCreateLiveRoomBg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: PreviewProfileImageWidget(
                  image: controller.fetchUserProfileModel?.user?.image ?? "",
                  isBanned: controller.fetchUserProfileModel?.user?.isProfilePicBanned ?? false,
                  fit: BoxFit.cover,
                  isShowPlaceHolder: false,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.5)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Level badge and engagement (bottom-left)
              Positioned(
                left: 15,
                bottom: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.fetchUserProfileModel?.user?.wealthLevel != null)
                      SizedBox(
                        height: 28,
                        child: PreviewWealthLevelImage(
                          height: 28,
                          width: 60,
                          image: controller.fetchUserProfileModel?.user?.wealthLevel?.levelImage,
                        ),
                      ),
                    6.height,
                    Row(
                      children: [
                        Text(
                          "${CustomFormatNumber.onConvert((controller.fetchUserProfileModel?.user?.totalFollowers ?? 0).toInt())} ${EnumLocal.txtFans.name.tr}",
                          style: AppFontStyle.styleW600(AppColor.white, 13),
                        ),
                        12.width,
                        Text(
                          "${CustomFormatNumber.onConvert((controller.fetchUserProfileModel?.user?.totalFollowing ?? 0).toInt())} ${EnumLocal.txtFollowUp.name.tr}",
                          style: AppFontStyle.styleW600(AppColor.white, 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Circular video/call preview (bottom-right) - only when visiting other user
              if (!controller.isOwnProfile)
                Positioned(
                  right: 15,
                  bottom: 15,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          PreviewProfileImageWidget(
                            image: controller.fetchUserProfileModel?.user?.image ?? "",
                            isBanned: controller.fetchUserProfileModel?.user?.isProfilePicBanned ?? false,
                            fit: BoxFit.cover,
                            isShowPlaceHolder: false,
                          ),
                          Container(
                            color: AppColor.black.withValues(alpha: 0.4),
                            child: Center(
                              child: Image.asset(
                                AppAssets.icCallReceive,
                                width: 24,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          PreviewProfileUserInfoRowWidget(),
        ],
      ),
    );
  }
}

