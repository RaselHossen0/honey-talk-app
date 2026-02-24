import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/video_picker_bottom_sheet_ui.dart';
import 'package:tingle/custom/function/custom_thumbnail.dart';
import 'package:tingle/custom/function/custom_video_picker.dart';
import 'package:tingle/custom/function/custom_video_time.dart';
import 'package:tingle/page/feed_page/controller/feed_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/internet_connection.dart';
import 'package:tingle/utils/utils.dart';

class FeedAppBarWidget extends StatelessWidget {
  const FeedAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.transparent,
      height: MediaQuery.of(context).viewPadding.top + 55,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: 15, left: 10, top: MediaQuery.of(context).viewPadding.top),
      child: GetBuilder<FeedController>(
        id: AppConstant.onChangeTab,
        builder: (controller) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 32,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.tabs.length,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => controller.onChangeTab(index),
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 24,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    controller.tabs[index],
                                    style: controller.selectedTab == index ? AppFontStyle.styleW700(AppColor.white, 18) : AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.6), 15),
                                  ),
                                ),
                              ),
                              2.height,
                              Visibility(
                                visible: controller.selectedTab == index,
                                child: Container(
                                  height: 3,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            10.width,
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.searchPage)?.then(
                (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
              ),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 5),
                decoration: const BoxDecoration(
                  color: AppColor.transparent,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppAssets.icSearch, width: 28),
              ),
            ),
            5.width,
            GestureDetector(
              onTap: () async {
                if (controller.selectedTab == 1) {
                  Utils.isCurrentlyVideoPage.value = false;
                  VideoPickerBottomSheetUi.show(
                    context: context,
                    cameraCallback: () {
                      Get.back();
                      Get.toNamed(AppRoutes.createReelsPage)?.then(
                        (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
                      );
                    },
                    galleryCallback: () {
                      Get.back();
                      onClickVideoUpload();
                    },
                  );
                } else {
                  Get.toNamed(AppRoutes.uploadFeedPage)?.then(
                    (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
                  );
                }
              },
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 5),
                decoration: const BoxDecoration(
                  color: AppColor.transparent,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppAssets.icBoxPlus, width: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void onClickVideoUpload() async {
  if (InternetConnection.isConnect.value) {
    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

    final videoPath = await CustomVideoPicker.pickVideo(); // Pick Video...

    Utils.showLog("Picked Video Path => $videoPath");

    if (videoPath != null) {
      final videoTime = await CustomVideoTime.onGet(videoPath); // Pick Video Time...

      Utils.showLog("Picked Video Time => $videoTime");

      if (videoTime != null) {
        final String? videoImage = await CustomThumbnail.onGet(videoPath); // Pick Video Image...

        Get.back(); // Stop Loading...

        if (videoImage != null) {
          Utils.showLog("Video Path => $videoPath");
          Utils.showLog("Video Image => $videoImage");
          Utils.showLog("Video Time => $videoTime");

          Get.toNamed(
            AppRoutes.previewUploadVideoPage,
            arguments: {
              ApiParams.video: videoPath,
              ApiParams.image: videoImage,
              ApiParams.time: videoTime,
              ApiParams.songId: "",
            },
          );
        } else {
          Utils.showLog("Get Video Image Failed !!");
          Get.back(); // Stop Loading...
        }
      } else {
        Utils.showLog("Get Video Time Failed !!");
        Get.back(); // Stop Loading...
      }
    } else {
      Utils.showLog("Video Not Selected !!");
      Get.back(); // Stop Loading...
    }
  } else {
    Utils.showToast(text: EnumLocal.txtNoInternetConnection.name.tr);
    Utils.showLog("Internet Connection Lost !!");
  }
}
