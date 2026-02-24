import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
import 'package:tingle/page/preview_user_profile_page/api/fetch_user_wise_post_api.dart';
import 'package:tingle/page/preview_user_profile_page/api/fetch_user_wise_video_api.dart';
import 'package:tingle/page/profile_page/api/fetch_user_profile_api.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class PreviewUserProfileController extends GetxController {
  // GET ARGUMENTS...
  String userId = "";

  bool isLoading = false;
  FetchUserProfileModel? fetchUserProfileModel;

  int selectedTabIndex = 0;
  bool isShowAppBar = false;
  ScrollController scrollController = ScrollController();

  ScrollController postScrollController = ScrollController();
  ScrollController videoScrollController = ScrollController();

  FetchPostModel? fetchPostModel;
  List<Post> userPosts = [];
  bool isLoadingPost = false;
  bool isPostPagination = false;

  FetchVideoModel? fetchVideoModel;
  List<VideoData> userVideos = [];
  bool isLoadingVideo = false;
  bool isVideoPagination = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      userId = Get.arguments;
    }

    scrollController.addListener(onScroll);
    postScrollController.addListener(onPostPagination);
    videoScrollController.addListener(onVideoPagination);

    init();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(onScroll);
    postScrollController.removeListener(onPostPagination);
    videoScrollController.removeListener(onVideoPagination);
    super.onClose();
  }

  void init() async {
    onGetProfile();
    onRefreshPost();
    onRefreshVideo();
    onVisitProfile();
  }

  void onVisitProfile() async {
    if (userId != Database.loginUserId) {}
  }

  void onScroll() {
    onToggleAppBar(scrollController.position.pixels != scrollController.position.minScrollExtent);
  }

  void onToggleAppBar(bool value) async {
    isShowAppBar = value;
    await 10.milliseconds.delay();
    update([AppConstant.onToggleAppBar]);
    Utils.onChangeStatusBar(brightness: isShowAppBar ? Brightness.dark : Brightness.light, delay: 0);
  }

  Future<void> onGetProfile() async {
    isLoading = true;
    update([AppConstant.onGetProfile]);

    fetchUserProfileModel = getDummyFetchUserProfile();

    isLoading = false;
    update([AppConstant.onGetProfile]);
  }

  void onChangeTab(int value) {
    selectedTabIndex = value;
    update([AppConstant.onChangeTab]);
  }

  Future<void> onRefreshPost() async {
    isLoadingPost = true;
    userPosts.clear();
    update([AppConstant.onGetFeed]);
    FetchUserWisePostApi.startPagination = 0;
    await onFetchPost();
  }

  Future<void> onFetchPost() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchPostModel = await FetchUserWisePostApi.callApi(uid: uid, token: token, toUserId: userId);

    userPosts.addAll(fetchPostModel?.post ?? []);

    isLoadingPost = false;
    update([AppConstant.onFetchPost]);

    if (fetchPostModel?.post?.isEmpty ?? true) {
      FetchUserWisePostApi.startPagination--;
    }
  }

  void onPostPagination() async {
    if (postScrollController.position.pixels == postScrollController.position.maxScrollExtent && isPostPagination == false) {
      isPostPagination = true;
      update([AppConstant.onPagination]);
      await onFetchVideo();
      isPostPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  Future<void> onRefreshVideo() async {
    isLoadingVideo = true;
    userVideos.clear();
    update([AppConstant.onGetVideo]);
    FetchUserWiseVideoApi.startPagination = 0;
    await onFetchVideo();
  }

  Future<void> onFetchVideo() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchVideoModel = await FetchUserWiseVideoApi.callApi(uid: uid, token: token, toUserId: userId);
    userVideos.addAll(fetchVideoModel?.data ?? []);

    isLoadingVideo = false;
    update([AppConstant.onFetchVideo]);

    if (fetchVideoModel?.data?.isEmpty ?? true) {
      FetchUserWiseVideoApi.startPagination--;
    }
  }

  void onVideoPagination() async {
    if (videoScrollController.position.pixels == videoScrollController.position.maxScrollExtent && isVideoPagination == false) {
      isVideoPagination = true;
      update([AppConstant.onPagination]);
      await onFetchVideo();
      isVideoPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  void onClickVideo(int index) async {
    Get.toNamed(
      AppRoutes.previewShortsVideoPage,
      arguments: {"index": index, "videos": userVideos},
    );
  }
}
