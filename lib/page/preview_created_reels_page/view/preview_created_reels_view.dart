import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/preview_created_reels_page/controller/preview_created_reels_controller.dart';
import 'package:tingle/page/preview_created_reels_page/widget/preview_created_reels_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class PreviewCreatedReelsView extends GetView<PreviewCreatedReelsController> {
  const PreviewCreatedReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 300),
      () {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: AppColor.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        );
      },
    );
    return Scaffold(
      body: GetBuilder<PreviewCreatedReelsController>(
        id: "onChangeLoading",
        builder: (controller) => SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: controller.onClickVideo,
                child: Container(
                  color: AppColor.black,
                  height: Get.height,
                  width: Get.width,
                  child: controller.isVideoLoading
                      ? LoadingWidget()
                      : SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: controller.videoPlayerController?.value.size.width ?? 0,
                              height: controller.videoPlayerController?.value.size.height ?? 0,
                              child: Chewie(controller: controller.chewieController!),
                            ),
                          ),
                        ),
                ),
              ),
              GetBuilder<PreviewCreatedReelsController>(
                id: "onShowPlayPauseIcon",
                builder: (controller) => controller.isShowPlayPauseIcon
                    ? Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: controller.onClickPlayPause,
                          child: GetBuilder<PreviewCreatedReelsController>(
                            id: "onChangePlayPauseIcon",
                            builder: (controller) => Container(
                              height: 70,
                              width: 70,
                              padding: EdgeInsets.only(left: controller.isPlaying ? 0 : 2),
                              decoration: BoxDecoration(color: AppColor.black.withAlpha(50), shape: BoxShape.circle),
                              child: Center(
                                child: Image.asset(
                                  controller.isPlaying ? AppAssets.icPause : AppAssets.icPlay,
                                  width: 30,
                                  height: 30,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Offstage(),
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: 150,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.black.withAlpha(179), AppColor.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 150,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.transparent, AppColor.black.withAlpha(179)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 0,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.transparent,
                        ),
                        child: Center(
                          child: Image.asset(
                            AppAssets.icArrowLeft,
                            width: 10,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      EnumLocal.txtPreview.name.tr,
                      style: AppFontStyle.styleW700(AppColor.white, 20),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 40,
                child: SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                    child: AppButtonUi(
                      fontSize: 18,
                      gradient: AppColor.primaryGradient,
                      title: EnumLocal.txtNext.name.tr,
                      callback: () {
                        controller.onClickNext();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
