import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/feed_page/api/fetch_hashtag_wise_post_api.dart';
import 'package:tingle/page/feed_page/api/fetch_popular_hashtag_api.dart';
import 'package:tingle/page/feed_page/api/fetch_post_api.dart';
import 'package:tingle/page/feed_page/model/fetch_popular_hashtag_model.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/page/feed_square_page/widget/feed_square_moments_widget.dart';
import 'package:tingle/page/feed_square_page/widget/feed_square_topics_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class FeedSquareController extends GetxController {
  ScrollController momentScrollController = ScrollController();

  String uid = "";
  String token = "";

  // TAB BAR
  int selectedFeedType = 0;
  List feedTypes = [EnumLocal.txtMoments.name.tr, EnumLocal.txtTopics.name.tr];
  List feedPages = [const FeedSquareMomentsWidget(), const FeedSquareTopicsWidget()];

  // MOMENTS TAB
  List<Post> moments = [];
  bool isLoadingMoment = false;
  FetchPostModel? fetchMomentModel;
  bool isLoadingMomentPagination = false;

  // TOPICS TAB
  List<Post> topics = [];
  bool isLoadingTopic = false;
  FetchPostModel? fetchTopicModel;

  // POPULAR HASHTAG
  int selectedHashtagIndex = 0;
  bool isLoadingPopularHashtag = false;
  List<Hashtags> popularHashtag = [];
  FetchPopularHashtagModel? fetchPopularHashtagModel;

  @override
  void onInit() {
    onGetPopularHashtag();
    momentScrollController.addListener(onMomentPagination);
    super.onInit();
  }

  Future<void> init() async {
    final controller = Get.find<BottomBarController>();
    if (Get.currentRoute == AppRoutes.bottomBarPage && controller.selectedTabIndex == 2) {
      onChangeFeedType(0); // RESET TAB BAR
      onRefreshMoment();
    }
  }

  Future<void> onGetToken() async {
    uid = FirebaseUid.onGet() ?? "";
    token = await FirebaseAccessToken.onGet() ?? "";
  }

  // >>>>> >>>>> >>>>> TAB BAR <<<<< <<<<< <<<<<

  void onChangeFeedType(int value) {
    selectedFeedType = value;
    update([AppConstant.onChangeFeedType]);
  }

  // >>>>> >>>>> >>>>> POPULAR HASHTAG <<<<< <<<<< <<<<<

  Future<void> onGetPopularHashtag() async {
    isLoadingPopularHashtag = true;
    await onGetToken();
    fetchPopularHashtagModel = await FetchPopularHashtagApi.callApi();
    popularHashtag = fetchPopularHashtagModel?.hashtags ?? [];
    isLoadingPopularHashtag = false;
    update([AppConstant.onGetPopularHashtag]);
    await onGetTopics();
  }

  void onChangeHashtag(int index) async {
    selectedHashtagIndex = index;
    update([AppConstant.onChangeHashtag]);
    await onGetTopics();
  }

  // >>>>> >>>>> >>>>> TOPICS TAB <<<<< <<<<< <<<<<

  Future<void> onGetTopics() async {
    isLoadingTopic = true;
    update([AppConstant.onChangeHashtag]);
    await onGetToken();
    fetchTopicModel = await FetchHashtagWisePostApi.callApi(hashTagId: popularHashtag[selectedHashtagIndex].id ?? "");
    topics = (fetchTopicModel?.post ?? []);
    isLoadingTopic = false;
    update([AppConstant.onChangeHashtag]);
  }

  // >>>>> >>>>> >>>>> MOMENT TAB <<<<< <<<<< <<<<<

  Future<void> onRefreshMoment() async {
    isLoadingMoment = true;
    update([AppConstant.onGetMoment]);

    moments.clear();
    await onGetMoment();
  }

  Future<void> onGetMoment() async {
    await onGetToken();

    fetchMomentModel = await FetchPostApi.callApi();
    moments.addAll(fetchMomentModel?.post ?? []);

    isLoadingMoment = false;
    update([AppConstant.onGetMoment]);

    Utils.showLog("Moments List Length => ${moments.length}");
  }

  void onMomentPagination() async {
    if (momentScrollController.position.pixels == momentScrollController.position.maxScrollExtent && isLoadingMomentPagination == false) {
      isLoadingMomentPagination = true;
      update([AppConstant.onMomentPagination]);

      await onGetMoment();

      isLoadingMomentPagination = false;
      update([AppConstant.onMomentPagination]);
    }
  }
}
