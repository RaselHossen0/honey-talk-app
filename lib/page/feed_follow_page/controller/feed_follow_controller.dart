import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/feed_follow_page/api/fetch_follow_post_api.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';

class FeedFollowController extends GetxController {
  ScrollController scrollController = ScrollController();

  bool isLoading = false;
  bool isLoadingPagination = false;

  List<Post> followPost = [];
  FetchPostModel? fetchPostModel;

  @override
  void onInit() {
    scrollController.addListener(onPagination);
    super.onInit();
  }

  Future<void> init() async {
    final controller = Get.find<BottomBarController>();
    if (Get.currentRoute == AppRoutes.bottomBarPage && controller.selectedTabIndex == 2) {
      onRefreshFollowPost();
    }
  }

  Future<void> onRefreshFollowPost() async {
    followPost.clear();
    isLoading = true;
    update([AppConstant.onGetFollowPost]);
    await onGetFollowPost();
  }

  Future<void> onGetFollowPost() async {
    fetchPostModel = await FetchFollowPostApi.callApi();
    followPost.addAll(fetchPostModel?.post ?? []);

    isLoading = false;
    update([AppConstant.onGetFollowPost]);

    if (fetchPostModel?.post?.isEmpty ?? true) {}
  }

  Future<void> onPagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && isLoadingPagination == false) {
      isLoadingPagination = true;
      update([AppConstant.onPagination]);
      await onGetFollowPost();
      isLoadingPagination = false;
      update([AppConstant.onPagination]);
    }
  }
}
