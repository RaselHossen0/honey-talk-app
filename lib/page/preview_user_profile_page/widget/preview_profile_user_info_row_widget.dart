import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/country_flag_icon.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

/// Compact user info row: mini avatar | name + icons | age/verified/ID | Follow up button
class PreviewProfileUserInfoRowWidget extends StatelessWidget {
  const PreviewProfileUserInfoRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) {
        final user = controller.fetchUserProfileModel?.user;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mini profile picture
              controller.fetchUserProfileModel?.user?.activeAvtarFrame?.image == null
                  ? Container(
                      height: 44,
                      width: 44,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.lightGray, width: 1),
                      ),
                      child: PreviewProfileImageWidget(
                        image: user?.image ?? "",
                        isBanned: user?.isProfilePicBanned ?? false,
                      ),
                    )
                  : SizedBox(
                      height: 44,
                      width: 44,
                      child: PreviewProfileImageWithFrameWidget(
                        image: user?.image,
                        isBanned: user?.isProfilePicBanned ?? false,
                        fit: BoxFit.cover,
                        frame: user?.activeAvtarFrame?.image ?? "",
                        type: user?.activeAvtarFrame?.type ?? 1,
                        margin: EdgeInsets.all(4),
                      ),
                    ),
              12.width,
              // Name, status icons, age/verified/ID
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user?.name ?? "",
                          style: AppFontStyle.styleW700(AppColor.black, 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        5.width,
                        if (user?.isVerified ?? false)
                          Image.asset(AppAssets.icAuthoriseIcon, width: 14),
                        5.width,
                        Text(
                          CountryFlagIcon.onShow(user?.countryFlagImage ?? ""),
                          style: AppFontStyle.styleW700(AppColor.black, 14),
                        ),
                      ],
                    ),
                    4.height,
                    Row(
                      children: [
                        Text(
                          CustomFormatNumber.onConvert((user?.age ?? 0).toInt()),
                          style: AppFontStyle.styleW600(AppColor.grayText, 12),
                        ),
                        Text(
                          " • ",
                          style: AppFontStyle.styleW500(AppColor.grayText, 12),
                        ),
                        if (user?.isVerified ?? false)
                          Row(
                            children: [
                              Image.asset(AppAssets.icAuthoriseIcon, width: 12),
                              2.width,
                              Text("100%", style: AppFontStyle.styleW600(AppColor.grayText, 12)),
                              Text(" • ", style: AppFontStyle.styleW500(AppColor.grayText, 12)),
                            ],
                          ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: (user?.uniqueId).toString()));
                            Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
                          },
                          child: Text(
                            "ID:${user?.uniqueId ?? 0}",
                            style: AppFontStyle.styleW600(AppColor.grayText, 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Follow up button - only when visiting another user's profile
              if (!controller.isOwnProfile)
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 1})?.then((value) {
                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: AppColor.coinPinkGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      EnumLocal.txtFollowUp.name.tr,
                      style: AppFontStyle.styleW600(AppColor.white, 13),
                    ),
                  ),
                ),
              // Edit Profile button - only when viewing own profile
              if (controller.isOwnProfile)
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.editProfilePage),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: AppColor.coinPinkGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      EnumLocal.txtEdit.name.tr,
                      style: AppFontStyle.styleW600(AppColor.white, 13),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
