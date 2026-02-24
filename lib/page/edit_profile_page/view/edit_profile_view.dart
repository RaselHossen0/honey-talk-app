import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/bio_text_field_widget.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/widget/custom_text_field_widget.dart';
import 'package:tingle/page/edit_profile_page/controller/edit_profile_controller.dart';
import 'package:tingle/common/widget/country_text_field_widget.dart';
import 'package:tingle/page/edit_profile_page/widget/edit_profile_app_bar_widget.dart';
import 'package:tingle/page/fill_profile_page/widget/gender_button_widget.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const EditProfileAppBarWidget(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.height,
                          GestureDetector(
                            onTap: () => controller.onPickImage(context: context),
                            child: Center(
                              child: Container(
                                height: 124,
                                width: 124,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.white,
                                  border: Border.all(color: AppColor.secondary, width: 1.5),
                                ),
                                child: Stack(
                                  children: [
                                    GetBuilder<EditProfileController>(
                                      id: AppConstant.onPickImage,
                                      builder: (controller) => Container(
                                        height: 124,
                                        width: 124,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.transparent,
                                        ),
                                        child: controller.pickImage != null
                                            ? Image.file(File(controller.pickImage ?? ""), fit: BoxFit.cover)
                                            : PreviewProfileImageWidget(
                                                image: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.image ?? "",
                                                isBanned: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.isProfilePicBanned ?? false,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 36,
                                        width: 36,
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: AppColor.primary,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: AppColor.lightGray, width: 1.5),
                                        ),
                                        alignment: Alignment.center,
                                        child: Image.asset(AppAssets.icEditProfileCamera),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          30.height,
                          CustomTextFieldWidget(
                            title: EnumLocal.txtEnterYourName.name.tr,
                            hintText: EnumLocal.txtEnterYourName.name.tr,
                            keyboardType: TextInputType.name,
                            controller: controller.nameController,
                          ),
                          20.height,
                          CustomTextFieldWidget(
                            title: EnumLocal.txtEnterUserName.name.tr,
                            hintText: EnumLocal.txtEnterUserName.name.tr,
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.userNameController,
                            onChange: (p0) => controller.onChangeUserName(),
                            suffixIcon: SizedBox(
                              height: 20,
                              width: 20,
                              child: Obx(
                                () => Center(
                                  child: controller.isCheckingUserName.value
                                      ? Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: CircularProgressIndicator(color: AppColor.primary, strokeWidth: 3),
                                        )
                                      : controller.isValidUserName == null
                                          ? Offstage()
                                          : controller.isValidUserName == true
                                              ? Icon(
                                                  Icons.done_all,
                                                  color: AppColor.green,
                                                )
                                              : Image.asset(AppAssets.icClose, color: Colors.red, height: 20, width: 20),
                                ),
                              ),
                            ),
                          ),
                          20.height,
                          CustomTextFieldWidget(
                            title: EnumLocal.txtEnterAge.name.tr,
                            hintText: EnumLocal.txtEnterAge.name.tr,
                            keyboardType: TextInputType.number,
                            controller: controller.ageController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                          ),
                          20.height,
                          Text(
                            EnumLocal.txtCountry.name.tr,
                            style: AppFontStyle.styleW500(AppColor.grayText, 14),
                          ),
                          5.height,
                          GetBuilder<EditProfileController>(
                            id: AppConstant.onChangeCountry,
                            builder: (controller) => CountryTextFieldWidget(
                              flag: controller.countryFlagController.text,
                              country: controller.countryNameController.text,
                              callback: () => controller.onChangeCountry(context),
                            ),
                          ),
                          20.height,
                          Text(
                            EnumLocal.txtSelectGender.name.tr,
                            style: AppFontStyle.styleW500(AppColor.grayText, 14),
                          ),
                          5.height,
                          GetBuilder<EditProfileController>(
                            id: AppConstant.onChangeGender,
                            builder: (controller) => Row(
                              children: [
                                GenderButtonWidget(
                                  title: EnumLocal.txtMale.name.tr,
                                  image: AppAssets.imgMale,
                                  isSelected: controller.isMale,
                                  callback: () => controller.onChangeGender(true),
                                ),
                                15.width,
                                GenderButtonWidget(
                                  title: EnumLocal.txtFemale.name.tr,
                                  image: AppAssets.imgFemale,
                                  isSelected: !controller.isMale,
                                  callback: () => controller.onChangeGender(false),
                                ),
                              ],
                            ),
                          ),
                          20.height,
                          BioTextFieldWidget(
                            title: EnumLocal.txtBioDetails.name.tr,
                            controller: controller.bioController,
                            hintText: EnumLocal.txtEnterYourBioDetails.name.tr,
                          ),
                          20.height,
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.onSaveProfile(),
                  child: Container(
                    height: 60,
                    width: Get.width,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      EnumLocal.txtSaveChanges.name.tr,
                      style: AppFontStyle.styleW600(AppColor.white, 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
