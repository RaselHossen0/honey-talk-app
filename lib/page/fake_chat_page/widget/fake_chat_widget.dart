import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/fake_chat_page/controller/fake_chat_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewChatImageUi extends GetView<FakeChatController> {
  const PreviewChatImageUi({super.key, required this.image, required this.time});

  final String image;
  final String time;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: AppColor.black,
            statusBarColor: AppColor.black,
            statusBarBrightness: Brightness.light,
          ),
        );
      },
    );
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.black,
          surfaceTintColor: AppColor.transparent,
          shadowColor: AppColor.black.withAlpha(102),
          flexibleSpace: SafeArea(
            bottom: false,
            child: Container(
              color: AppColor.transparent,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: AppColor.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Image.asset(AppAssets.icArrowLeft, color: AppColor.white, width: 25)),
                      ),
                    ),
                    2.width,
                    Container(
                      height: 46,
                      width: 46,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColor.colorBorder,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.white,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: PreviewPostImageWidget(
                          // image: controller.receiverImage,
                          ),
                    ),
                    10.width,
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Text(
                          "controller.receiverName",
                          style: AppFontStyle.styleW700(AppColor.white, 16.5),
                        ).paddingOnly(bottom: 16),
                        Text(
                          "controller.receiverUserName",
                          style: AppFontStyle.styleW500(AppColor.white.withAlpha(204), 12),
                        ).paddingOnly(top: 22),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(height: Get.height, width: Get.width, child: PreviewPostImageWidget(image: image)),
    );
  }
}
