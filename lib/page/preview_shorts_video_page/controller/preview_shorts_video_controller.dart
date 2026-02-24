import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
import 'package:tingle/utils/constant.dart';

class PreviewShortsVideoController extends GetxController {
  PageController pageController = PageController();

  bool isLoading = false;
  int currentIndex = 0;

  List<VideoData> videos = [];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    isLoading = true;
    update([AppConstant.onGetVideo]);

    final index = Get.arguments["index"] ?? 0;
    pageController = PageController(initialPage: index);
    onChangePage(index);

    if (Get.arguments["videos"] != null) {
      videos.addAll(Get.arguments["videos"]);
    }

    isLoading = false;
    update([AppConstant.onGetVideo]);
  }

  void onChangePage(int index) async {
    currentIndex = index;
    update([AppConstant.onChangePage]);
  }
}
