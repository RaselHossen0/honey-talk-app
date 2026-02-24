import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/feed_video_page/api/fetch_video_api.dart';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class FeedVideoController extends GetxController {
  PageController pageController = PageController();

  int currentIndex = 0;

  List<VideoData> videos = [];
  bool isLoading = false;
  FetchVideoModel? fetchVideoModel;
  bool isLoadingPagination = false;

  @override
  void onInit() {
    Utils.showLog("Feed Video Controller Init Success");
    super.onInit();
  }

  Future<void> init() async {
    final controller = Get.find<BottomBarController>();
    if (Get.currentRoute == AppRoutes.bottomBarPage && controller.selectedTabIndex == 2) {
      // await 100.milliseconds.delay(); // Use For Extend Body...
      await onRefreshVideos();
    }
  }

  Future<void> onRefreshVideos() async {
    onChangePage(0);
    videos.clear();
    isLoading = true;
    update([AppConstant.onGetVideo]);
    await onGetVideo();
  }

  Future<void> onGetVideo() async {
    fetchVideoModel = await FetchVideoApi.callApi();
    videos.addAll(fetchVideoModel?.data ?? []);

    isLoading = false;
    update([AppConstant.onGetVideo]);
  }

  void onPagination(int value) async {
    if ((videos.length - 1) == value) {
      if (isLoadingPagination == false) {
        isLoadingPagination = true;
        update([AppConstant.onPagination]);
        await onGetVideo();
        isLoadingPagination = false;
        update([AppConstant.onPagination]);
      }
    }
  }

  void onChangePage(int index) async {
    currentIndex = index;
    update([AppConstant.onChangePage]);
  }
}
