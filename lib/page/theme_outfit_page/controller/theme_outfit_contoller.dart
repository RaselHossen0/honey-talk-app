import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tingle/page/connection_page/model/fetch_following_follower_model.dart';
import 'package:tingle/page/connection_page/model/fetch_visitor_model.dart';
import 'package:tingle/page/connection_page/model/search_connection_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';

class ThemeOutfitController extends GetxController with GetTickerProviderStateMixin {
  int currentIndex = 0;
  RxBool isLoading = false.obs;
  TabController? outfitTabController;

  FollowerFollowingModel? followerFollowingModel;
  SearchConnectionModel? searchConnectionModel;

  ScrollController connectionScrollController = ScrollController();
  VisitorModel? visitorModel;
  List<Follower> friends = [];
  List<Follower> following = [];
  List<Follower> followers = [];

  List<ProfileVisitor> profileVisitors = [];
  List<ProfileVisitor> visitedProfiles = [];
  TextEditingController searchController = TextEditingController();
  RxString searchType = "".obs;

  var isTyping = false.obs;

  @override
  void onInit() {
    init();

    super.onInit();
  }

  RxString mainTitle = EnumLocal.txtFriends.name.tr.obs;
  RxInt selectedCount = 0.obs;
  onTabChange(int index) async {
    currentIndex = index;
    update();
    update([AppConstant.onTabBarTap]);
  }

  int tabIndex = 0;
  Future<void> onGetData() async {
    friends.clear();
    following.clear();
    followers.clear();

    isLoading.value = true;

    isLoading.value = false;
    update();
  }

  bool isLoadingPagination = false;

  Future<void> onPagination() async {
    if (connectionScrollController.position.pixels == connectionScrollController.position.maxScrollExtent && isLoadingPagination == false) {
      isLoadingPagination = true;
      update([AppConstant.onPagination]);

      isLoadingPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  Future<void> init() async {
    isLoading.value = true;
    update([ApiParams.outfitUpdate]);
    tabIndex = Get.arguments[ApiParams.tabIndex] ?? 0;
    outfitTabController = TabController(length: 3, vsync: this, initialIndex: tabIndex);

    outfitTabController!.addListener(
      () {
        onTabChange(outfitTabController!.index);
      },
    );

    connectionScrollController.addListener(onPagination);
    onGetData();
    isLoading.value = false;
    update([ApiParams.outfitUpdate]);
  }
}
