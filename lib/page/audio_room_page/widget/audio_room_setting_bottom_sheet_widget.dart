import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingle/common/function/common_share.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_image_picker.dart';
import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_bloc_bottom_sheet_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_change_bg_bottom_sheet_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_wheat_bottom_sheet_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomSettingBottomSheetWidget {
  static final controller = Get.find<AudioRoomController>();

  static RxString pickImage = "".obs;
  static TextEditingController nameController = TextEditingController();
  static TextEditingController welcomeController = TextEditingController();

  static void onClickSave() {
    if (nameController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterRoomName.name.tr);
    } else {
      controller.onEditAudioRoom(
        roomName: nameController.text.trim(),
        roomWelcome: welcomeController.text.trim(),
        roomImage: pickImage.value,
      );
    }
  }

  static Future<void> onShow() async {
    pickImage.value = "";
    nameController = TextEditingController(text: controller.audioRoomModel?.roomName ?? "");
    welcomeController = TextEditingController(text: controller.audioRoomModel?.roomWelcome ?? "");

    await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 50,
              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            ),
            child: Container(
              height: Get.height / 1.2,
              width: Get.width,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 65,
                    color: AppColor.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 4,
                              width: 35,
                              decoration: BoxDecoration(
                                color: AppColor.secondary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            10.height,
                            Text(
                              EnumLocal.txtRoomSetting.name.tr,
                              style: AppFontStyle.styleW700(AppColor.black, 17),
                            ),
                          ],
                        ).paddingOnly(left: 50),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.transparent,
                              border: Border.all(color: AppColor.black),
                            ),
                            child: Center(
                              child: Image.asset(
                                width: 18,
                                AppAssets.icClose,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            color: AppColor.secondary.withValues(alpha: 0.08),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                15.height,
                                Text(
                                  EnumLocal.txtChangeRoomImage.name.tr,
                                  style: AppFontStyle.styleW700(AppColor.black, 15),
                                ),
                                8.height,
                                GestureDetector(
                                  onTap: () async {
                                    await CustomImagePickerBottomSheetWidget.show(
                                      context: context,
                                      onClickCamera: () async {
                                        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);
                                        if (imagePath != null) {
                                          pickImage.value = imagePath;
                                        }
                                      },
                                      onClickGallery: () async {
                                        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);
                                        if (imagePath != null) {
                                          pickImage.value = imagePath;
                                        }
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 125,
                                    clipBehavior: Clip.antiAlias,
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.white,
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Obx(
                                          () => pickImage.value != ""
                                              ? Image.file(File(pickImage.value), fit: BoxFit.cover)
                                              : PreviewPostImageWidget(
                                                  image: controller.audioRoomModel?.roomImage ?? "",
                                                  fit: BoxFit.cover,
                                                  size: 60,
                                                ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColor.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.asset(
                                              AppAssets.icCamera,
                                              width: 18,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                15.height,
                                Text(
                                  EnumLocal.txtRoomName.name.tr,
                                  style: AppFontStyle.styleW700(AppColor.black, 15),
                                ),
                                8.height,
                                TextFieldUi(
                                  hintText: EnumLocal.txtEnterYourName.name.tr,
                                  controller: nameController,
                                ),
                                15.height,
                                Text(
                                  EnumLocal.txtRoomWelcomeMessage.name.tr,
                                  style: AppFontStyle.styleW700(AppColor.black, 15),
                                ),
                                8.height,
                                TextFieldUi(
                                  hintText: EnumLocal.txtEnterRoomWelcomeMessage.name.tr,
                                  controller: welcomeController,
                                ),
                                15.height,
                                Visibility(
                                  visible: controller.audioRoomModel?.audioLiveType == 1, // IF PRIVATE LIVE
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        EnumLocal.txtPrivateCode.name.tr,
                                        style: AppFontStyle.styleW700(AppColor.black, 15),
                                      ),
                                      8.height,
                                      Container(
                                        height: 50,
                                        width: Get.width,
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${controller.audioRoomModel?.audioRoomPrivateCode}",
                                              style: AppFontStyle.styleW600(AppColor.black, 15),
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(text: (controller.audioRoomModel?.audioRoomPrivateCode ?? "").toString()));
                                                Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                color: AppColor.transparent,
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  AppAssets.icCopy,
                                                  width: 18,
                                                  color: AppColor.primary,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await CommonShare.onShare(title: (controller.audioRoomModel?.audioRoomPrivateCode).toString());
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                color: AppColor.transparent,
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  AppAssets.icShareText,
                                                  width: 18,
                                                  color: AppColor.primary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      15.height,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                8.height,
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    AudioRoomWheatBottomSheetWidget.onShow();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: Get.width,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          EnumLocal.txtWheatMode.name.tr,
                                          style: AppFontStyle.styleW700(AppColor.black, 15),
                                        ),
                                        Image.asset(
                                          AppAssets.icArrowRight,
                                          width: 8,
                                          color: AppColor.secondary.withValues(alpha: 0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: AppColor.secondary.withValues(alpha: 0.1)),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    AudioRoomBlocBottomSheetWidget.onShow();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: Get.width,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          EnumLocal.txtBlockedList.name.tr,
                                          style: AppFontStyle.styleW700(AppColor.black, 15),
                                        ),
                                        Image.asset(
                                          AppAssets.icArrowRight,
                                          width: 8,
                                          color: AppColor.secondary.withValues(alpha: 0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: AppColor.secondary.withValues(alpha: 0.1)),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    AudioRoomChangeBgBottomSheetWidget.onShow();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: Get.width,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          EnumLocal.txtChangeBackground.name.tr,
                                          style: AppFontStyle.styleW700(AppColor.black, 15),
                                        ),
                                        Image.asset(
                                          AppAssets.icArrowRight,
                                          width: 8,
                                          color: AppColor.secondary.withValues(alpha: 0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onClickSave,
                    child: Container(
                      width: Get.width,
                      color: AppColor.white,
                      alignment: Alignment.center,
                      child: Container(
                        height: 55,
                        width: Get.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          EnumLocal.txtChangesSave.name.tr,
                          style: AppFontStyle.styleW700(AppColor.white, 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldUi extends StatelessWidget {
  const TextFieldUi({super.key, this.controller, required this.hintText});

  final TextEditingController? controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 20, right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: AppFontStyle.styleW700(AppColor.black, 15),
        controller: controller,
        cursorColor: AppColor.grayText,
        maxLines: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 3),
          hintText: hintText,
          hintStyle: AppFontStyle.styleW500(AppColor.grayText.withValues(alpha: 0.7), 15),
        ),
      ),
    );
  }
}
