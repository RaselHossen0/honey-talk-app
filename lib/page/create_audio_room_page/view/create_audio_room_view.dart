import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tingle/page/create_audio_room_page/controller/create_audio_room_controller.dart';
import 'package:tingle/page/create_audio_room_page/widget/create_audio_room_app_bar_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CreateAudioRoomView extends StatelessWidget {
  const CreateAudioRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return GetBuilder<CreateAudioRoomController>(
      builder: (controller) => Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AppAssets.imgCreateLiveRoomBg,
              fit: BoxFit.cover,
              height: Get.height,
              width: Get.width,
            ),
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  CreateAudioRoomAppBarWidget(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.height,
                            Text(
                              EnumLocal.txtSelectRoomImage.name.tr,
                              style: AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.5), 15),
                            ),
                            10.height,
                            GetBuilder<CreateAudioRoomController>(
                              id: AppConstant.onPickImage,
                              builder: (controller) => GestureDetector(
                                onTap: () => controller.onPickImage(context),
                                child: Container(
                                  height: 150,
                                  width: 125,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: AppColor.white.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: controller.pickImage != null
                                      ? Container(
                                          height: 150,
                                          width: 125,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: AppColor.white.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(14),
                                          ),
                                          child: Image.file(File(controller.pickImage!), fit: BoxFit.cover))
                                      : Image.asset(AppAssets.icUploadLiveRoomImage, color: AppColor.white.withValues(alpha: 0.8), width: 40),
                                ),
                              ),
                            ),
                            15.height,
                            Text(
                              EnumLocal.txtRoomName.name.tr,
                              style: AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.5), 15),
                            ),
                            10.height,
                            TextFieldWidget(controller: controller.nameController),
                            15.height,
                            Text(
                              EnumLocal.txtRoomDescription.name.tr,
                              style: AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.5), 15),
                            ),
                            10.height,
                            MultiLineTextFieldWidget(
                              height: 120,
                              controller: controller.descriptionController,
                            ),
                            15.height,
                            Text(
                              EnumLocal.txtRoomType.name.tr,
                              style: AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.5), 15),
                            ),
                            10.height,
                            GetBuilder<CreateAudioRoomController>(
                              id: AppConstant.onChangeRoomType,
                              builder: (controller) => Row(
                                children: [
                                  ButtonWidget(
                                    icon: AppAssets.icPublicLive,
                                    title: EnumLocal.txtPublic.name.tr,
                                    isSelected: !controller.isPrivate,
                                    callback: () => controller.onChangeRoomType(false),
                                  ),
                                  15.width,
                                  ButtonWidget(
                                    icon: AppAssets.icPrivateLive,
                                    title: EnumLocal.txtPrivate.name.tr,
                                    isSelected: controller.isPrivate,
                                    callback: () => controller.onChangeRoomType(true),
                                  ),
                                ],
                              ),
                            ),
                            GetBuilder<CreateAudioRoomController>(
                              id: AppConstant.onChangeRoomType,
                              builder: (controller) => Visibility(
                                visible: controller.isPrivate,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    15.height,
                                    Text(
                                      EnumLocal.txtPassword.name.tr,
                                      style: AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.5), 15),
                                    ),
                                    10.height,
                                    Container(
                                      height: 55,
                                      padding: const EdgeInsets.only(left: 20, right: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        color: AppColor.white.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: AppColor.white.withValues(alpha: 0.2)),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${controller.privateCode}",
                                            style: AppFontStyle.styleW600(AppColor.white, 15),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(text: controller.privateCode.toString()));
                                              Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: AppColor.transparent,
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                AppAssets.icCopy,
                                                width: 20,
                                                color: AppColor.white,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(text: controller.privateCode.toString()));
                                              Utils.showToast(
                                                text: EnumLocal.txtCopiedOnClipboard.name.tr,
                                              );
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              color: AppColor.transparent,
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                AppAssets.icShareText,
                                                width: 20,
                                                color: AppColor.white,
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
                            ),
                            // 50.height,
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.onClickGoLive,
                    child: Container(
                      height: 55,
                      width: Get.width,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: AppColor.coinPinkGradient,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        EnumLocal.txtStartAudioRoom.name.tr,
                        style: AppFontStyle.styleW700(AppColor.white, 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.callback,
  });

  final String icon;
  final String title;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.white : AppColor.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? null : Border.all(color: AppColor.white.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Image.asset(icon, color: isSelected ? AppColor.primary : AppColor.white, width: 15),
            8.width,
            Text(
              title,
              style: AppFontStyle.styleW600(isSelected ? AppColor.primary : AppColor.white, 16),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.callback,
    this.controller,
    this.textInputFormatter,
    this.keyboardType,
  });

  final Callback? callback;
  final TextEditingController? controller;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 15, right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.white.withValues(alpha: 0.2)),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: textInputFormatter,
        controller: controller,
        cursorColor: AppColor.grayText,
        maxLines: 1,
        style: AppFontStyle.styleW700(AppColor.white, 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 3),
          hintText: EnumLocal.txtEnterYourRoomName.name.tr,
          hintStyle: AppFontStyle.styleW400(AppColor.white.withValues(alpha: 0.8), 15),
        ),
      ),
    );
  }
}

class MultiLineTextFieldWidget extends StatelessWidget {
  const MultiLineTextFieldWidget({
    super.key,
    this.callback,
    this.controller,
    required this.height,
  });

  final Callback? callback;
  final double height;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(left: 15, right: 5),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColor.white.withValues(alpha: 0.2)),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColor.grayText,
        style: AppFontStyle.styleW700(AppColor.white, 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 3),
          hintText: EnumLocal.txtTypeComment.name.tr,
          hintStyle: AppFontStyle.styleW400(AppColor.white.withValues(alpha: 0.8), 15),
        ),
      ),
    );
  }
}
