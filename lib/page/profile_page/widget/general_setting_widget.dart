import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/log_out_dialog_widget.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class GeneralSettingWidget extends StatelessWidget {
  const GeneralSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withValues(alpha: 0.08),
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: GetBuilder<ProfileController>(builder: (controller) {
        final gender = (Database.fetchLoginUserProfile()?.user?.gender ?? controller.fetchUserProfileModel?.user?.gender ?? '').toLowerCase();
        final isFemale = gender == 'female';
        final isMale = gender == 'male';

        final items = <_SettingItem>[
          _SettingItem(EnumLocal.txtLiveData.name.tr, AppAssets.icLiveDataIcon, () {}),
          _SettingItem(EnumLocal.txtTasks.name.tr, AppAssets.icClock, () => Get.toNamed(AppRoutes.taskPage)?.then((value) {
            Utils.onChangeStatusBar(brightness: Brightness.dark);
            controller.scrollController.jumpTo(0.0);
          })),
          _SettingItem(EnumLocal.txtMyIncome.name.tr, AppAssets.icMyCoin, () => Get.toNamed(AppRoutes.myIncomePage)?.then((value) {
            Utils.onChangeStatusBar(brightness: Brightness.dark);
            controller.scrollController.jumpTo(0.0);
          })),
          _SettingItem(EnumLocal.txtBackpack.name.tr, AppAssets.icBackpackIcon, () => Get.toNamed(AppRoutes.backpackPage)?.then((value) {
            Utils.onChangeStatusBar(brightness: Brightness.dark);
            controller.scrollController.jumpTo(0.0);
          })),
          _SettingItem(EnumLocal.txtHelp.name.tr, AppAssets.icHelpIcon, () => Get.toNamed(AppRoutes.helpPage)?.then((value) {
            Utils.onChangeStatusBar(brightness: Brightness.dark);
            controller.scrollController.jumpTo(0.0);
          })),
          _SettingItem(EnumLocal.txtMyAgency.name.tr, AppAssets.icMyAgencyIcon, () {}),
          _SettingItem(EnumLocal.txtMyProfile.name.tr, AppAssets.icProfile, () => Get.toNamed(AppRoutes.myProfilePage)?.then((value) {
            Utils.onChangeStatusBar(brightness: Brightness.dark);
            controller.scrollController.jumpTo(0.0);
          })),
          _SettingItem(EnumLocal.txtAboutUs.name.tr, AppAssets.icAboutUsIcon, () {}),
          _SettingItem(EnumLocal.txtSettings.name.tr, AppAssets.icSettingIcon, () {}),
          _SettingItem(EnumLocal.txtMyChatPrice.name.tr, AppAssets.icVideoCallBorder, () => Get.toNamed(AppRoutes.myChatPricePage)?.then((value) {
            Utils.onChangeStatusBar(brightness: Brightness.dark);
            controller.scrollController.jumpTo(0.0);
          })),
          _SettingItem(EnumLocal.txtMyLivePictures.name.tr, AppAssets.icUploadLiveRoomImage, () => Get.toNamed(AppRoutes.myLivePicturesPage)?.then((value) {
            Utils.onChangeStatusBar(brightness: Brightness.dark);
            controller.scrollController.jumpTo(0.0);
          })),
          if (isFemale)
            _SettingItem(EnumLocal.txtCharmingLevel.name.tr, AppAssets.icLevelIcon, () => Get.toNamed(AppRoutes.charmingLevelPage)?.then((value) {
              Utils.onChangeStatusBar(brightness: Brightness.dark);
              controller.scrollController.jumpTo(0.0);
            })),
          if (isMale)
            _SettingItem(EnumLocal.txtWealthLevel.name.tr, AppAssets.icWealthLevel, () => Get.toNamed(AppRoutes.wealthLevelPage)?.then((value) {
              Utils.onChangeStatusBar(brightness: Brightness.dark);
              controller.scrollController.jumpTo(0.0);
            })),
          _SettingItem(EnumLocal.txtLogOut.name.tr, AppAssets.icLogOut, () => LogOutDialogWidget.onShow(), isDestructive: true),
        ];
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          separatorBuilder: (_, __) => Divider(height: 1, color: AppColor.secondary.withValues(alpha: 0.08)),
          itemBuilder: (context, index) {
            final item = items[index];
            return _SettingListTile(
              title: item.title,
              image: item.image,
              callback: item.callback,
              isDestructive: item.isDestructive,
            );
          },
        );
      }),
    );
  }
}

class _SettingItem {
  final String title;
  final String image;
  final Callback callback;
  final bool isDestructive;
  _SettingItem(this.title, this.image, this.callback, {this.isDestructive = false});
}

class _SettingListTile extends StatelessWidget {
  const _SettingListTile({
    required this.title,
    required this.image,
    required this.callback,
    this.isDestructive = false,
  });

  final String title;
  final String image;
  final Callback callback;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callback,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      leading: Container(
        height: 44,
        width: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDestructive ? AppColor.red.withValues(alpha: 0.08) : AppColor.secondary.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(image, width: 22, color: isDestructive ? AppColor.red : null),
      ),
      title: Text(
        title,
        style: AppFontStyle.styleW500(isDestructive ? AppColor.red : AppColor.lightGreyPurple, 14),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColor.secondary.withValues(alpha: 0.5), size: 24),
    );
  }
}
