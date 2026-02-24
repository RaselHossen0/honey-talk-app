import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/stream_page/api/fetch_live_user_api.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/page/stream_page/tabs/stream_explore_tab_widget.dart';
import 'package:tingle/page/stream_page/tabs/stream_follow_tab_widget.dart';
import 'package:tingle/page/stream_page/tabs/stream_new_tab_widget.dart';
import 'package:tingle/page/stream_page/tabs/stream_pk_tab_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class StreamController extends GetxController {
  final List tabTitles = [EnumLocal.txtExplore.name.tr, EnumLocal.txtNew.name.tr, EnumLocal.txtPk.name.tr, EnumLocal.txtFollow.name.tr];

  final List<Widget> pages = [
    StreamExploreTabWidget(),
    StreamNewTabWidget(),
    StreamPkTabWidget(),
    StreamFollowTabWidget(),
  ];

  ScrollController exploreScrollController = ScrollController();
  ScrollController newScrollController = ScrollController();
  ScrollController pkScrollController = ScrollController();
  ScrollController followScrollController = ScrollController();

  int exploreStartPagination = 0;
  int newStartPagination = 0;
  int pkStartPagination = 0;
  int followStartPagination = 0;

  int selectedTabIndex = 0;
  String? selectedCountry;

  bool isLoadingExplore = false;
  bool isLoadingNew = false;
  bool isLoadingPk = false;
  bool isLoadingFollow = false;

  bool isLoadingPagination = false;
  FetchLiveUserModel? fetchLiveUserModel;

  List<LiveUserList> exploreLiveUsers = [];
  List<LiveUserList> newLiveUsers = [];
  List<LiveUserList> pkLiveUsers = [];
  List<LiveUserList> followLiveUsers = [];

  @override
  void onInit() {
    exploreScrollController.addListener(onExplorePagination);
    newScrollController.addListener(onNewPagination);
    pkScrollController.addListener(onPkPagination);
    followScrollController.addListener(onFollowPagination);

    super.onInit();
  }

  @override
  void onClose() {
    exploreScrollController.removeListener(onExplorePagination);
    newScrollController.removeListener(onNewPagination);
    pkScrollController.removeListener(onPkPagination);
    followScrollController.removeListener(onFollowPagination);

    super.onClose();
  }

  void init() {
    final bottomBarController = Get.find<BottomBarController>();
    if (Get.currentRoute == AppRoutes.bottomBarPage && bottomBarController.selectedTabIndex == 0) {
      onChangeTab(0);
    }
  }

  void onChangeTab(int value) {
    selectedTabIndex = value;
    update([AppConstant.onChangeTab]);
    onRefresh();
  }

  void onChangeCountry(String value) {
    selectedCountry = selectedCountry == value ? null : value;
    update([AppConstant.onChangeCountry]);
    onRefresh();
  }

  Future<void> onRefresh() async {
    switch (selectedTabIndex) {
      case 0:
        {
          isLoadingExplore = true;
          exploreStartPagination = 0;
          exploreLiveUsers.clear();
          onGetExploreLiveUser();
          update([AppConstant.onGetExploreLiveUser]);
        }
      case 1:
        {
          isLoadingNew = true;
          newStartPagination = 0;
          newLiveUsers.clear();
          onGetNewLiveUser();
          update([AppConstant.onGetNewLiveUser]);
        }
      case 2:
        {
          isLoadingPk = true;
          pkStartPagination = 0;
          pkLiveUsers.clear();
          onGetPkLiveUser();
          update([AppConstant.onGetPkLiveUser]);
        }
      case 3:
        {
          isLoadingFollow = true;
          followStartPagination = 0;
          followLiveUsers.clear();
          onGetFollowLiveUser();
          update([AppConstant.onGetFollowLiveUser]);
        }

      default:
    }
  }

  Future<void> onGetExploreLiveUser() async {
    exploreStartPagination++;
    final List<LiveUserList> data = await onGetLiveUser(startPagination: exploreStartPagination, liveType: ApiParams.explore);
    if (exploreStartPagination == 1) exploreLiveUsers.clear();
    exploreLiveUsers.addAll(data);
    if (data.isEmpty) exploreStartPagination--;
    isLoadingExplore = false;
    update([AppConstant.onGetExploreLiveUser]);
  }

  Future<void> onGetNewLiveUser() async {
    newStartPagination++;
    final List<LiveUserList> data = await onGetLiveUser(startPagination: newStartPagination, liveType: ApiParams.new_);
    if (newStartPagination == 1) newLiveUsers.clear();
    newLiveUsers.addAll(data);
    if (data.isEmpty) newStartPagination--;
    isLoadingNew = false;
    update([AppConstant.onGetNewLiveUser]);
  }

  Future<void> onGetPkLiveUser() async {
    pkStartPagination++;
    final List<LiveUserList> data = await onGetLiveUser(startPagination: pkStartPagination, liveType: ApiParams.pk);
    if (pkStartPagination == 1) pkLiveUsers.clear();
    pkLiveUsers.addAll(data);
    if (data.isEmpty) pkStartPagination--;
    isLoadingPk = false;
    update([AppConstant.onGetPkLiveUser]);
  }

  Future<void> onGetFollowLiveUser() async {
    followStartPagination++;
    final List<LiveUserList> data = await onGetLiveUser(startPagination: followStartPagination, liveType: ApiParams.follow);
    if (followStartPagination == 1) followLiveUsers.clear();
    followLiveUsers.addAll(data);
    if (data.isEmpty) followStartPagination--;
    isLoadingFollow = false;
    update([AppConstant.onGetFollowLiveUser]);
  }

  void onExplorePagination() async {
    if (exploreScrollController.position.pixels == exploreScrollController.position.maxScrollExtent && isLoadingPagination == false) {
      isLoadingPagination = true;
      update([AppConstant.onPagination]);
      await onGetExploreLiveUser();
      isLoadingPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  void onNewPagination() async {
    if (newScrollController.position.pixels == newScrollController.position.maxScrollExtent && isLoadingPagination == false) {
      isLoadingPagination = true;
      update([AppConstant.onPagination]);
      await onGetNewLiveUser();
      isLoadingPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  void onPkPagination() async {
    if (pkScrollController.position.pixels == pkScrollController.position.maxScrollExtent && isLoadingPagination == false) {
      isLoadingPagination = true;
      update([AppConstant.onPagination]);
      await onGetPkLiveUser();
      isLoadingPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  void onFollowPagination() async {
    if (followScrollController.position.pixels == followScrollController.position.maxScrollExtent && isLoadingPagination == false) {
      isLoadingPagination = true;
      update([AppConstant.onPagination]);
      await onGetFollowLiveUser();
      isLoadingPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  Future<List<LiveUserList>> onGetLiveUser({required int startPagination, required String liveType}) async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchLiveUserModel = await FetchLiveUserApi.callApi(
      token: token,
      uid: uid,
      liveType: liveType,
      country: selectedCountry,
      startPage: startPagination,
    );

    List<LiveUserList> data = fetchLiveUserModel?.liveUserList ?? [];

    Utils.showLog("Live User Pagination Data Length Type => $liveType => ${data.length}");

    return fetchLiveUserModel?.liveUserList ?? [];
  }

  String onGetLiveType() {
    switch (selectedTabIndex) {
      case 0:
        return ApiParams.explore;
      case 1:
        return ApiParams.new_;
      case 2:
        return ApiParams.pk;
      case 3:
        return ApiParams.follow;
      default:
        return "";
    }
  }
}
