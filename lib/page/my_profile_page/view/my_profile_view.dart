import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/my_profile_page/controller/my_profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(AppAssets.icArrowLeft, width: 10),
          ),
        ),
        centerTitle: true,
        title: Text(
          EnumLocal.txtMyProfile.name.tr,
          style: AppFontStyle.styleW700(AppColor.primary, 18),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _ProfileSection(
            children: [
              _ProfileRow(
                label: EnumLocal.txtMyAvatar.name.tr,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAvatar(),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, size: 12, color: AppColor.grayText),
                  ],
                ),
                onTap: () => Get.toNamed(AppRoutes.editProfilePage),
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtID.name.tr,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.userId,
                      style: AppFontStyle.styleW400(AppColor.grayText, 14),
                    ),
                    SizedBox(width: 8),
                    _CopyButton(onTap: controller.onCopyId),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, size: 12, color: AppColor.grayText),
                  ],
                ),
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtNickname.name.tr,
                value: controller.nickname,
                onTap: () => Get.toNamed(AppRoutes.editProfilePage),
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtGender.name.tr,
                value: controller.gender,
                onTap: controller.isGenderLocked ? null : () => Get.toNamed(AppRoutes.editProfilePage),
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtAge.name.tr,
                value: controller.age,
                onTap: () => Get.toNamed(AppRoutes.editProfilePage),
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtRegions.name.tr,
                value: "${controller.countryFlag} ${controller.country}",
                onTap: controller.isCountryLocked ? null : () => Get.toNamed(AppRoutes.editProfilePage),
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtLocation.name.tr,
                value: EnumLocal.txtHidden.name.tr,
                onTap: () {},
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtLanguage.name.tr,
                value: Database.selectedLanguage == "bn" ? "Bengali" : "English",
                onTap: () {},
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtSecondLanguage.name.tr,
                value: "",
                onTap: () {},
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtTags.name.tr,
                value: "",
                onTap: () {},
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtSelfIntroduction.name.tr,
                value: controller.bio.isNotEmpty ? controller.bio : "",
                onTap: () => Get.toNamed(AppRoutes.editProfilePage),
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtCosmetics.name.tr,
                value: "",
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.primary),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, size: 12, color: AppColor.grayText),
                  ],
                ),
                onTap: () => Get.toNamed(AppRoutes.backpackPage),
              ),
            ],
          ),
          16.height,
          _ProfileSection(
            title: EnumLocal.txtAccount.name.tr,
            children: [
              _ProfileRow(
                label: "Google",
                value: controller.googleName,
                onTap: () {},
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtPhone.name.tr,
                value: controller.phone,
                onTap: () {},
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtGmail.name.tr,
                value: controller.maskedEmail,
                onTap: () {},
              ),
              _divider(),
              _ProfileRow(
                label: EnumLocal.txtPassword.name.tr,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      EnumLocal.txtReset.name.tr,
                      style: AppFontStyle.styleW500(AppColor.grayText, 14),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, size: 12, color: AppColor.grayText),
                  ],
                ),
                onTap: controller.onResetPassword,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      height: 40,
      width: 40,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.colorBorder),
      ),
      child: PreviewProfileImageWidget(
        image: controller.image,
        isBanned: controller.isProfilePicBanned,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _divider() => Divider(height: 1, color: AppColor.colorBorder);
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({this.title, required this.children});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 16, 15, 8),
            child: Text(
              title!,
              style: AppFontStyle.styleW600(AppColor.darkGrey, 14),
            ),
          ),
        ],
        Container(
          color: AppColor.white,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.label,
    this.value = "",
    this.trailing,
    this.onTap,
  });

  final String label;
  final String value;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isEditable = onTap != null;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Row(
          children: [
            Text(
              label,
              style: AppFontStyle.styleW500(AppColor.darkGrey, 14),
            ),
            Spacer(),
            if (trailing != null)
              trailing!
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (value.isNotEmpty)
                    Text(
                      value,
                      style: AppFontStyle.styleW400(AppColor.grayText, 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  if (value.isNotEmpty) SizedBox(width: 8),
                  if (isEditable)
                    Icon(Icons.arrow_forward_ios, size: 12, color: AppColor.grayText),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  const _CopyButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColor.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          EnumLocal.txtCopy.name.tr,
          style: AppFontStyle.styleW500(AppColor.primary, 12),
        ),
      ),
    );
  }
}
