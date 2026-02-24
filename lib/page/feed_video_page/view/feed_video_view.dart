import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/feed_video_page/controller/feed_video_controller.dart';
import 'package:tingle/page/feed_video_page/shimmer/video_shimmer_widget.dart';
import 'package:tingle/page/feed_video_page/widget/feed_video_item_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class FeedVideoView extends GetView<FeedVideoController> {
  const FeedVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.init();
    Future.delayed(Duration(milliseconds: 100), () => controller.onChangePage(0));
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColor.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: AppColor.black,
      body: GetBuilder<FeedVideoController>(
        id: AppConstant.onGetVideo,
        builder: (controller) => controller.isLoading
            ? VideoShimmerWidget()
            : controller.videos.isEmpty
                ? RefreshIndicator(
                    color: AppColor.primary,
                    onRefresh: () async => await controller.init(),
                    child: LayoutBuilder(builder: (context, box) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: box.maxHeight + 1,
                          child: NoDataFoundWidget(),
                        ),
                      );
                    }),
                  )
                : RefreshIndicator(
                    color: AppColor.primary,
                    onRefresh: () async => await controller.init(),
                    child: PageView.builder(
                      itemCount: controller.videos.length,
                      scrollDirection: Axis.vertical,
                      onPageChanged: (value) {
                        controller.onPagination(value);
                        controller.onChangePage(value);
                      },
                      itemBuilder: (context, index) {
                        return GetBuilder<FeedVideoController>(
                          id: AppConstant.onChangePage,
                          builder: (controller) => FeedVideoItemWidget(
                            index: index,
                            currentIndex: controller.currentIndex,
                            videoData: controller.videos[index],
                            isInsertBottomBarSpace: true,
                          ),
                        );
                      },
                    ),
                  ),
      ),
      bottomNavigationBar: GetBuilder<FeedVideoController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
