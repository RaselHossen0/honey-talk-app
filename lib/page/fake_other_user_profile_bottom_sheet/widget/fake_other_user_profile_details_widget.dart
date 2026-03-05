import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/country_flag_icon.dart';
import 'package:tingle/common/model/fatch_other_user_profile_model.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

/// Large profile header + user info row matching preview profile layout.
class FakeOtherUserProfileDetailsWidget extends StatelessWidget {
  const FakeOtherUserProfileDetailsWidget({
    super.key,
    required this.otherUserProfileModel,
    required this.onClose,
  });

  final OtherUserProfileModel? otherUserProfileModel;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final user = otherUserProfileModel?.user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: Get.height * 0.35,
              width: Get.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.imgCreateLiveRoomBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: PreviewProfileImageWidget(
                image: user?.image ?? "",
                isBanned: user?.isProfilePicBanned ?? false,
                fit: BoxFit.cover,
                isShowPlaceHolder: false,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.6)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              bottom: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user?.wealthLevel != null)
                    SizedBox(
                      height: 28,
                      child: PreviewWealthLevelImage(
                        height: 28,
                        width: 60,
                        image: user?.wealthLevel?.levelImage,
                      ),
                    ),
                  if (user?.wealthLevel != null) 6.height,
                  Row(
                    children: [
                      Text(
                        "${CustomFormatNumber.onConvert((user?.totalFollowers ?? 0).toInt())} ${EnumLocal.txtFans.name.tr}",
                        style: AppFontStyle.styleW600(AppColor.white, 13),
                      ),
                      12.width,
                      Text(
                        "${CustomFormatNumber.onConvert((user?.totalFollowing ?? 0).toInt())} ${EnumLocal.txtFollowUp.name.tr}",
                        style: AppFontStyle.styleW600(AppColor.white, 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                          image: user?.image ?? "",
                          isBanned: user?.isProfilePicBanned ?? false,
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
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 8,
              right: 12,
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.black.withValues(alpha: 0.5),
                  ),
                  child: Icon(Icons.close, color: AppColor.white, size: 22),
                ),
              ),
            ),
          ],
        ),
        _UserInfoRow(user: user),
      ],
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  const _UserInfoRow({this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        user?.name ?? "",
                        style: AppFontStyle.styleW700(AppColor.black, 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    5.width,
                    if (user?.isVerified ?? false)
                      Image.asset(AppAssets.icAuthoriseIcon, width: 14),
                    5.width,
                    Flexible(
                      child: Text(
                        CountryFlagIcon.onShow(user?.countryFlagImage ?? ""),
                        style: AppFontStyle.styleW700(AppColor.black, 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                    Text(" • ", style: AppFontStyle.styleW500(AppColor.grayText, 12)),
                    if (user?.isVerified ?? false)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppAssets.icAuthoriseIcon, width: 12),
                          2.width,
                          Text("100%", style: AppFontStyle.styleW600(AppColor.grayText, 12)),
                          Text(" • ", style: AppFontStyle.styleW500(AppColor.grayText, 12)),
                        ],
                      ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: (user?.uniqueId).toString()));
                          Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
                        },
                        child: Text(
                          "ID:${user?.uniqueId ?? 0}",
                          style: AppFontStyle.styleW600(AppColor.grayText, 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 1})?.then((_) {
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
        ],
      ),
    );
  }
}
