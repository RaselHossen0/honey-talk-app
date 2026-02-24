import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/page/help_page/controller/help_controller.dart';
import 'package:tingle/page/help_page/widget/help_app_bar_widget.dart';
import 'package:tingle/page/help_page/widget/help_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      appBar: HelpAppBarWidget.onShow(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HelpTextFieldUi(
                height: 250,
                maxLines: 10,
                title: EnumLocal.txtComplaintOrSuggestion.name.tr,
                keyboardType: TextInputType.text,
                controller: controller.complaintController,
              ),
              15.height,
              HelpTextFieldUi(
                maxLines: 1,
                title: EnumLocal.txtContact.name.tr,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                controller: controller.contactController,
              ),
              30.height,
              RichText(
                text: TextSpan(
                  text: EnumLocal.txtAttachYourImageOrScreenshot.name.tr,
                  style: AppFontStyle.styleW500(AppColor.grayText, 15),
                  children: [
                    TextSpan(
                      text: " ${EnumLocal.txtOptionalInBrackets.name.tr}",
                      style: AppFontStyle.styleW400(AppColor.grayText, 12),
                    ),
                  ],
                ),
              ),
              15.height,
              GestureDetector(
                onTap: () => controller.onPickImage(context),
                child: GradiantBorderContainer(
                  height: 40,
                  width: 130,
                  radius: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.icLink,
                        width: 24,
                        color: AppColor.primary,
                      ),
                      10.width,
                      Container(
                        width: 1.5,
                        height: 25,
                        decoration: BoxDecoration(
                          color: AppColor.secondary.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      10.width,
                      Text(
                        EnumLocal.txtBrowse.name.tr,
                        style: AppFontStyle.styleW600(AppColor.black, 15),
                      ),
                    ],
                  ),
                ),
              ),
              20.height,
              GetBuilder<HelpController>(
                id: AppConstant.onPickImage,
                builder: (controller) => Visibility(
                  visible: controller.pickImage != null,
                  child: SizedBox(
                    width: 150,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.file(File(controller.pickImage ?? ""), fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: -8,
                          right: -8,
                          child: GestureDetector(
                            onTap: controller.onCancelImage,
                            child: Container(
                              height: 60,
                              width: 60,
                              color: AppColor.transparent,
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.black,
                                  border: Border.all(color: AppColor.colorBorder.withValues(alpha: 0.3), width: 2),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AppAssets.icClose,
                                    color: AppColor.white,
                                    width: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: GestureDetector(
          onTap: controller.onSendComplaint,
          child: Container(
            height: 55,
            width: Get.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: AppColor.primaryGradient,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              EnumLocal.txtSubmit.name.tr,
              style: AppFontStyle.styleW700(AppColor.white, 17),
            ),
          ),
        ),
      ),
    );
  }
}

class GradiantBorderContainer extends StatelessWidget {
  const GradiantBorderContainer({super.key, required this.height, this.width, required this.radius, this.child});

  final double height;
  final double? width;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: const [3, 6],
          color: AppColor.colorScaffold,
          radius: Radius.circular(radius),
          padding: const EdgeInsets.all(1.3),
          strokeWidth: 5,
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColor.colorScaffold,
            borderRadius: BorderRadius.circular(radius - 1),
          ),
          child: child,
        ),
      ),
    );
  }
}
