import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/party_page/tabs/party_follow_tab_widget.dart';
import 'package:tingle/page/party_page/tabs/party_party_tab_widget.dart';
import 'package:tingle/page/stream_page/api/fetch_live_user_api.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class PartyController extends GetxController {
  List tabTitles = [EnumLocal.txtParty.name.tr, EnumLocal.txtFollow.name.tr];
  List<Widget> pages = [PartyPartyTabWidget(), PartyFollowTabWidget()];

  ScrollController partyScrollController = ScrollController();
  ScrollController followScrollController = ScrollController();

  int partyStartPagination = 0;
  int followStartPagination = 0;

  int selectedTabIndex = 0;
  String? selectedCountry;

  bool isLoadingParty = false;
  bool isLoadingFollow = false;

  bool isLoadingPagination = false;
  FetchLiveUserModel? fetchLiveUserModel;

  List<LiveUserList> partyLiveUsers = [];
  List<LiveUserList> followLiveUsers = [];

  @override
  void onInit() {
    partyScrollController.addListener(onPartyPagination);
    followScrollController.addListener(onFollowPagination);

    super.onInit();
  }

  @override
  void onClose() {
    partyScrollController.removeListener(onPartyPagination);
    followScrollController.removeListener(onFollowPagination);
    super.onClose();
  }

  void init() {
    final bottomBarController = Get.find<BottomBarController>();
    if (Get.currentRoute == AppRoutes.bottomBarPage && bottomBarController.selectedTabIndex == 1) {
      onChangeTab(0);
    }
  }

  void onChangeTab(int value) {
    selectedTabIndex = value;
    update([AppConstant.onChangeTab]);
    onRefresh(delay: 0);
  }

  void onChangeCountry({required String value}) {
    selectedCountry = selectedCountry == value ? null : value;
    update([AppConstant.onChangeCountry]);
    onRefresh(delay: 0);
  }

  Future<void> onRefresh({required int delay}) async {
    switch (selectedTabIndex) {
      case 0:
        {
          isLoadingParty = true;
          partyStartPagination = 0;
          partyLiveUsers.clear();
          update([AppConstant.onGetPartyLiveUser]);
          await delay.milliseconds.delay();
          onGetPartyLiveUser();
        }

      case 1:
        {
          isLoadingFollow = true;
          followStartPagination = 0;
          followLiveUsers.clear();
          update([AppConstant.onGetFollowLiveUser]);
          await delay.milliseconds.delay();
          onGetFollowLiveUser();
        }

      default:
    }
  }

  Future<void> onGetPartyLiveUser() async {
    partyStartPagination++;
    final List<LiveUserList> data = await onGetLiveUser(startPagination: partyStartPagination, liveType: ApiParams.audio);

    partyLiveUsers.addAll(data);
    if (data.isEmpty) partyStartPagination--;
    isLoadingParty = false;
    update([AppConstant.onGetPartyLiveUser]);
  }

  Future<void> onGetFollowLiveUser() async {
    followStartPagination++;
    final List<LiveUserList> data = await onGetLiveUser(startPagination: followStartPagination, liveType: ApiParams.followLiveAudio);
    followLiveUsers.addAll(data);
    if (data.isEmpty) followStartPagination--;
    isLoadingFollow = false;
    update([AppConstant.onGetFollowLiveUser]);
  }

  void onPartyPagination() async {
    if (partyScrollController.position.pixels == partyScrollController.position.maxScrollExtent && isLoadingPagination == false) {
      isLoadingPagination = true;
      update([AppConstant.onPagination]);
      await onGetPartyLiveUser();
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
}
