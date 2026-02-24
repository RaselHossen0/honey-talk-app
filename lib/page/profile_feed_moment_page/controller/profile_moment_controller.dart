import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/utils/constant.dart';

class ProfileMomentController extends GetxController {
  ScrollController momentScrollController = ScrollController();

  String uid = "";
  String token = "";
  void scrollToIndex(int index) {
    final offset = index * 250; // Approximate height of one item
    momentScrollController.animateTo(
      offset.toDouble(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    log("Scroll to index: $index, offset: $offset");
  }

  // TAB BAR
  int selectedFeedType = 0;

  // MOMENTS TAB
  List<Post> moments = [];
  bool isLoadingMoment = false;
  FetchPostModel? fetchMomentModel;
  bool isLoadingMomentPagination = false;

  // TOPICS TAB
  List<Post> topics = [];
  bool isLoadingTopic = false;
  FetchPostModel? fetchTopicModel;

  @override
  void onInit() {
    momentScrollController.addListener(onMomentPagination);
    init();
    super.onInit();
  }

  String selectedPostId = "";
  Future<void> init() async {
    Get.arguments != null ? selectedPostId = Get.arguments[AppConstant.postId] : selectedPostId = "";
    Get.arguments != null ? moments = Get.arguments[AppConstant.onFetchPost] : moments = [];
    log("Selected Post ID => $selectedPostId");
    log("Selected Post Moments => $moments");
    onRefreshMoment();
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

  // >>>>> >>>>> >>>>> MOMENT TAB <<<<< <<<<< <<<<<

  Future<void> onRefreshMoment() async {
    if (selectedPostId != "") {
      final index = moments.indexWhere((e) => e.id == selectedPostId);
      if (index != -1) {
        // Move the selected item to the start of the list
        final selectedItem = moments.removeAt(index);
        moments.insert(0, selectedItem); // Insert the item at the beginning

        // Trigger a rebuild to update the UI
      }
    }
    update([AppConstant.onGetMoment]);
  }

  void onMomentPagination() async {
    if (momentScrollController.position.pixels == momentScrollController.position.maxScrollExtent && isLoadingMomentPagination == false) {
      isLoadingMomentPagination = true;
      update([AppConstant.onMomentPagination]);

      // await onGetMoment();

      isLoadingMomentPagination = false;
      update([AppConstant.onMomentPagination]);
    }
  }
}
