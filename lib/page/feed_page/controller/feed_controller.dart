import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/page/feed_follow_page/view/feed_follow_view.dart';
import 'package:tingle/page/feed_square_page/view/feed_square_view.dart';
import 'package:tingle/page/feed_video_page/view/feed_video_view.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class FeedController extends GetxController {
  PageController pageController = PageController();
  int selectedTab = 0;
  List tabs = [
    EnumLocal.txtSquare.name.tr,
    EnumLocal.txtVideo.name.tr,
    EnumLocal.txtFollow.name.tr,
  ];

  List tabPages = [
    FeedSquareView(),
    FeedVideoView(),
    FeedFollowView(),
  ];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    onChangeTab(0);
  }

  void onChangeTab(int value) {
    selectedTab = value;
    selectedTab == 1 ? Utils.onChangeExtendBody(true) : Utils.onChangeExtendBody(false);
    update([AppConstant.onChangeTab]);
  }

  bool isShowUploadButton = false;
  void onToggleUploadButton() {
    isShowUploadButton = !isShowUploadButton;
    update([AppConstant.onToggleUploadButton]);
  }
}
