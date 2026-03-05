import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_gift_gallery_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_private_album_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_review_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class PreviewProfileDataTabWidget extends StatelessWidget {
  const PreviewProfileDataTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PreviewProfileCallRateWidget(),
        PreviewProfilePrivateAlbumWidget(),
        PreviewProfileReviewWidget(),
        PreviewProfileGiftGalleryWidget(),
      ],
    );
  }
}

/// Call rate row - shows coins per minute from settings API (when viewing other user).
class PreviewProfileCallRateWidget extends StatelessWidget {
  const PreviewProfileCallRateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) {
        if (controller.isOwnProfile) return const SizedBox.shrink();
        final rate = FetchSettingApi.fetchSettingModel?.data?.privateCallRate ?? 25;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            children: [
              Text(
                "${EnumLocal.txtVideoCallPrice.name.tr}: ",
                style: AppFontStyle.styleW600(AppColor.grayText, 14),
              ),
              Text(
                "$rate ${EnumLocal.txtCoins.name.tr}${EnumLocal.txtPerMinute.name.tr}",
                style: AppFontStyle.styleW700(AppColor.primary, 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
