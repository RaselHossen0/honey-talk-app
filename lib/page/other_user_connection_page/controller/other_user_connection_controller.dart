import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/other_user_connection_page/api/other_user_connection_api.dart';
import 'package:tingle/page/other_user_connection_page/model/other_user_connection_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';

class OtherUserConnectionController extends GetxController with GetTickerProviderStateMixin {
  int currentIndex = 0;
  bool isLoading = false;
  TabController? tabController;

  ScrollController connectionScrollController = ScrollController();
  List<Follower> friends = [];
  List<Follower> following = [];
  List<Follower> followers = [];
  FetchOtherUserConnectionModel? fetchOtherUserConnectionModel;

  var isTyping = false.obs;

  @override
  void onInit() {
    init();
    // TODO: implement onInit
    super.onInit();
  }

  RxString mainTitle = EnumLocal.txtFriends.name.tr.obs;
  RxInt selectedCount = 0.obs;
  onTabChange(int index) async {
    log("onTabControl onTabChange :: $index");
    await onTabControl(index);
    currentIndex = index;
    update([AppConstant.onTabBarTap]);
    update([AppConstant.onChangeFollowUpdate]);
  }

  onTabControl(index) {
    if (index == 0) {
      mainTitle.value = EnumLocal.txtFriends.name.tr;
      selectedCount.value = friends.length;
    } else if (index == 1) {
      mainTitle.value = EnumLocal.txtFollow.name.tr;
      selectedCount.value = following.length;
    } else if (index == 2) {
      mainTitle.value = EnumLocal.txtFollowers.name.tr;
      selectedCount.value = followers.length;
    }
  }

  Future<void> onGetData() async {
    friends.clear();
    following.clear();
    followers.clear();

    isLoading = true;

    final token = await FirebaseAccessToken.onGet() ?? "";
    final uid = FirebaseUid.onGet() ?? "";

    fetchOtherUserConnectionModel = await FetchOtherUserConnectionApi.callApi(uid: uid, token: token, userId: userId);

    friends.addAll(fetchOtherUserConnectionModel!.friends!);
    following.addAll(fetchOtherUserConnectionModel!.following!);
    followers.addAll(fetchOtherUserConnectionModel!.followers!);

    isLoading = false;
    update([AppConstant.onTabBarTap]);
    update([AppConstant.onChangeFollowUpdate]);
  }

  onGetMoreData() async {
    FetchOtherUserConnectionApi.startPagination++;
    await onTabControl(tabController!.index);

    update([AppConstant.onSearchConnection]);
  }

  bool isLoadingPagination = false;
  bool isLoadingConnectionPagination = false;

  Future<void> onConnectionPagination() async {
    if (connectionScrollController.position.pixels == connectionScrollController.position.maxScrollExtent && isLoadingConnectionPagination == false) {
      isLoadingConnectionPagination = true;
      update([AppConstant.onPagination]);
      await onGetMoreData();
      isLoadingConnectionPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  String userId = "";
  Future<void> init() async {
    userId = Get.arguments[ApiParams.userId] ?? "";
    tabController = TabController(length: 3, vsync: this, initialIndex: Get.arguments[ApiParams.tabIndex] ?? 0);
    onTabChange(tabController!.index);
    tabController!.addListener(
      () {
        onTabChange(tabController!.index);
      },
    );
    connectionScrollController.addListener(onConnectionPagination);
    onGetData();
  }
}
