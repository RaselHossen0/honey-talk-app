import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/feed_video_page/widget/feed_video_item_widget.dart';
import 'package:tingle/page/preview_shorts_video_page/controller/preview_shorts_video_controller.dart';
import 'package:tingle/page/preview_shorts_video_page/shimmer/preview_shorts_video_shimmer_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class PreviewShortsVideoView extends GetView<PreviewShortsVideoController> {
  const PreviewShortsVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 100),
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
      body: GetBuilder<PreviewShortsVideoController>(
        id: AppConstant.onGetVideo,
        builder: (controller) => controller.isLoading
            ? PreviewShortsVideoShimmerWidget()
            : controller.videos.isEmpty
                ? NoDataFoundWidget()
                : PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.videos.length,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) {
                      controller.onChangePage(value);
                    },
                    itemBuilder: (context, index) {
                      return GetBuilder<PreviewShortsVideoController>(
                        id: AppConstant.onChangePage,
                        builder: (controller) => FeedVideoItemWidget(
                          index: index,
                          currentIndex: controller.currentIndex,
                          videoData: controller.videos[index],
                          isInsertBottomBarSpace: false,
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
