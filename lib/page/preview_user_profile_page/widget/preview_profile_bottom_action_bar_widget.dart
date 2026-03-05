import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileBottomActionBarWidget extends StatelessWidget {
  const PreviewProfileBottomActionBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) {
        final user = controller.fetchUserProfileModel?.user;
        final isOwnProfile = controller.isOwnProfile;
        final callPricePerMin = FetchSettingApi.fetchSettingModel?.data?.privateCallRate ?? 25;

        return Container(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 12,
            bottom: 12 + MediaQuery.of(context).padding.bottom,
          ),
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: isOwnProfile
              ? _buildOwnProfileBar(context)
              : Row(
                  children: [
                    // Message button - circular pink (other user only)
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.chatPage,
                          arguments: {
                            ApiParams.roomId: "",
                            ApiParams.receiverUserId: user?.id ?? "",
                            ApiParams.name: user?.name ?? "",
                            ApiParams.image: user?.image ?? "",
                            ApiParams.isBanned: user?.isProfilePicBanned ?? false,
                            ApiParams.isVerify: user?.isVerified ?? false,
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.pink.withValues(alpha: 0.2),
                        ),
                        child: Center(
                          child: Image.asset(
                            AppAssets.icMessageBorder,
                            width: 24,
                            color: AppColor.pink,
                          ),
                        ),
                      ),
                    ),
                    12.width,
                    // Call button - gradient with token/min (other user only)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Initiate video call
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: AppColor.coinPinkGradient,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.icCallReceive,
                                width: 22,
                                color: AppColor.white,
                              ),
                              10.width,
                              Text(
                                "$callPricePerMin Token${EnumLocal.txtPerMinute.name.tr}",
                                style: AppFontStyle.styleW600(AppColor.white, 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildOwnProfileBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.editProfilePage),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: AppColor.coinPinkGradient,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.icEditPen,
                    width: 22,
                    color: AppColor.white,
                  ),
                  10.width,
                  Text(
                    EnumLocal.txtEdit.name.tr,
                    style: AppFontStyle.styleW600(AppColor.white, 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
