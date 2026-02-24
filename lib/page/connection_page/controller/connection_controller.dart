import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/connection_page/api/fetch_visitor_api.dart';
import 'package:tingle/page/connection_page/api/fetch_getSocialLists_api.dart';
import 'package:tingle/page/connection_page/api/search_connection_api.dart';
import 'package:tingle/page/connection_page/model/fetch_following_follower_model.dart';
import 'package:tingle/page/connection_page/model/fetch_visitor_model.dart';
import 'package:tingle/page/connection_page/model/search_connection_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';

class ConnectionController extends GetxController with GetTickerProviderStateMixin {
  int currentIndex = 0;
  bool isLoading = false;
  bool isSearchLoading = false;
  TabController? tabController;
  TabController? visitTabController;
  FollowerFollowingModel? followerFollowingModel;
  SearchConnectionModel? searchConnectionModel;

  ScrollController searchScrollController = ScrollController();
  ScrollController connectionScrollController = ScrollController();
  VisitorModel? visitorModel;
  List<Follower> friends = [];
  List<Follower> following = [];
  List<Follower> followers = [];
  List<SearchData> searchData = [];
  List<ProfileVisitor> profileVisitors = [];
  List<ProfileVisitor> visitedProfiles = [];
  TextEditingController searchController = TextEditingController();
  RxString searchType = "".obs;

  var isTyping = false.obs;
  Timer? _debounce;
  void onSearchChanged(String value) {
    isTyping.value = true;

    // Cancel the previous timer if still active
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new timer (only triggers after user stops typing for 800ms)
    _debounce = Timer(Duration(milliseconds: 800), () {
      isTyping.value = false;

      onSearchData();
    });
  }

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

    update([AppConstant.onChangeFollowUpdate]);
  }

  onTabControl(index) {
    log("onTabControl index :: $index");
    if (index == 0) {
      searchType.value = ApiParams.friends;
      mainTitle.value = EnumLocal.txtFriends.name.tr;
      selectedCount.value = friends.length;
    } else if (index == 1) {
      searchType.value = ApiParams.followings;
      mainTitle.value = EnumLocal.txtFollow.name.tr;
      selectedCount.value = following.length;
    } else if (index == 2) {
      searchType.value = ApiParams.followers;

      mainTitle.value = EnumLocal.txtFollowers.name.tr;
      selectedCount.value = followers.length;
    } else if (index == 3) {
      searchType.value = ApiParams.visitors;
      mainTitle.value = EnumLocal.txtVisitors.name.tr;
      selectedCount.value = 0;
    }
  }

  Future<void> onSearchData() async {
    await onTabControl(tabController!.index);

    searchData.clear();
    searchConnectionModel = await SearchConnectionApi.callApi(
      searchString: searchController.text,
      type: searchType.value,
    );
    if (searchConnectionModel != null) {
      searchData.addAll(searchConnectionModel!.searchData!);
    }

    isSearchLoading = false;
    update([AppConstant.onSearchConnection]);
  }

  onSearchMoreData() async {
    await onTabControl(tabController!.index);

    searchConnectionModel = await SearchConnectionApi.callApi(
      searchString: searchController.text,
      type: searchType.value,
    );
    if (searchConnectionModel != null) {
      searchData.addAll(searchConnectionModel!.searchData!);
    }

    isSearchLoading = false;
    update([AppConstant.onSearchConnection]);
  }

  Future<void> onGetData() async {
    friends.clear();
    following.clear();
    followers.clear();
    profileVisitors.clear();
    visitedProfiles.clear();

    isLoading = true;

    final token = await FirebaseAccessToken.onGet() ?? "";
    final uid = FirebaseUid.onGet() ?? "";

    followerFollowingModel = await FetchGetSocialListsApi.callApi();
    visitorModel = await FetchVisitorApi.callApi(
      userId: uid,
      token: token,
    );

    friends.addAll(followerFollowingModel!.friends!);
    following.addAll(followerFollowingModel!.following!);
    followers.addAll(followerFollowingModel!.followers!);
    profileVisitors.addAll(visitorModel!.profileVisitors!);
    visitedProfiles.addAll(visitorModel!.visitedProfiles!);
    isLoading = false;
    update();
    update([AppConstant.onTabBarTap]);
    update([AppConstant.onChangeFollowUpdate]);
  }

  onGetMoreData() async {
    await onTabControl(tabController!.index);

    searchConnectionModel = await SearchConnectionApi.callApi(
      searchString: searchController.text,
      type: searchType.value,
    );
    if (searchConnectionModel != null) {
      searchData.addAll(searchConnectionModel!.searchData!);
    }

    isSearchLoading = false;
    update([AppConstant.onSearchConnection]);
  }

  bool isLoadingPagination = false;
  bool isLoadingConnectionPagination = false;

  Future<void> onPagination() async {
    if (connectionScrollController.position.pixels == connectionScrollController.position.maxScrollExtent && isLoadingPagination == false) {
      isLoadingConnectionPagination = true;
      update([AppConstant.onPagination]);
      await onSearchMoreData();
      isLoadingConnectionPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  Future<void> onConnectionPagination() async {
    if (searchScrollController.position.pixels == searchScrollController.position.maxScrollExtent && isLoadingConnectionPagination == false) {
      isLoadingConnectionPagination = true;
      update([AppConstant.onPagination]);
      await onGetMoreData();
      isLoadingConnectionPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  Future<void> init() async {
    tabController = TabController(length: 4, vsync: this, initialIndex: Get.arguments[ApiParams.tabIndex] ?? 0);
    visitTabController = TabController(length: 2, vsync: this);
    tabController!.addListener(
      () {
        onTabChange(tabController!.index);
      },
    );
    searchScrollController.addListener(onPagination);
    connectionScrollController.addListener(onConnectionPagination);
    onGetData();
  }
}
