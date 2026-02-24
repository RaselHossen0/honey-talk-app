import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/ranking_page/api/fetch_ranking_gift_user_api.dart';
import 'package:tingle/page/ranking_page/api/fetch_ranking_rich_user_api.dart';
import 'package:tingle/page/ranking_page/model/fetch_ranking_gift_user_model.dart';
import 'package:tingle/page/ranking_page/model/fetch_ranking_rich_user_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class RankingController extends GetxController with GetTickerProviderStateMixin {
  ScrollController richScrollController = ScrollController();

  TabController? tabController;
  bool isChangingTab = false; // This is use to fixing two time api calling...

  // ********************************************** RICH TAB BAR **********************************************

  int selectedRichTabIndex = 0;

  bool isLoadingRankingRichUser = false;
  bool isPaginationRankingRichUser = false;
  List<List<Daily>> rankingRichUser = [[], [], []]; // Daily, Weekly, Monthly
  FetchRankingRichUserModel? fetchRankingRichUserModel;

  // ********************************************** GIFT TAB BAR **********************************************

  int selectedGiftTabIndex = 0;
  int selectedGiftSubTabIndex = 0;
  String selectedGiftFilter = ApiParams.today;

  bool isLoadingRankingGiftUser = false;
  bool isPaginationRankingGiftUser = false;
  List<List<List<UserStats>>> rankingGiftUser = [
    [[], []],
    [[], []],
    [[], []],
  ];

  FetchRankingGiftUserModel? fetchRankingGiftUserModel;
  ScrollController giftScrollController = ScrollController();

  @override
  Future<void> onInit() async {
    richScrollController.addListener(onRichPagination);
    giftScrollController.addListener(onGiftPagination);
    tabController = TabController(length: 2, vsync: this);
    tabController?.addListener(onChangeTabBar);
    onRefreshRichUser();
    onRefreshGiftUser();
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    richScrollController.removeListener(onRichPagination);
    giftScrollController.removeListener(onGiftPagination);
    super.onClose();
  }

  // ********************************************** MAIN TAB BAR **********************************************

  Future<void> onChangeTabBar() async {
    isChangingTab = true;

    await 400.milliseconds.delay();

    if (isChangingTab) {
      isChangingTab = false;

      if (tabController?.index == 0) {
      } else if (tabController?.index == 1) {}
    }
  }

  // ********************************************** RICH TAB BAR **********************************************

  void onChangeRichTabBar(int index) {
    selectedRichTabIndex = index;
    update([AppConstant.onChangeRichTabBar]);
  }

  void onRefreshRichUser() {
    isLoadingRankingRichUser = true;
    rankingRichUser = [[], [], []];
    update([AppConstant.onChangeRichTabBar]);
    onGetRichUser();
  }

  Future<void> onGetRichUser() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";
    fetchRankingRichUserModel = await FetchRankingRichUserApi.callApi(uid: uid, token: token);
    rankingRichUser[0].addAll(fetchRankingRichUserModel?.data?.daily ?? []);
    rankingRichUser[1].addAll(fetchRankingRichUserModel?.data?.weekly ?? []);
    rankingRichUser[2].addAll(fetchRankingRichUserModel?.data?.monthly ?? []);

    isLoadingRankingRichUser = false;

    Utils.showLog("Daily => ${rankingRichUser[0].length}");
    Utils.showLog("Weekly => ${rankingRichUser[1].length}");
    Utils.showLog("Monthly => ${rankingRichUser[2].length}");

    update([AppConstant.onChangeRichTabBar]);
  }

  void onRichPagination() async {
    if (richScrollController.position.pixels == richScrollController.position.maxScrollExtent && isPaginationRankingRichUser == false) {
      isPaginationRankingRichUser = true;
      update([AppConstant.onPagination]);
      await onGetRichUser();
      isPaginationRankingRichUser = false;
      update([AppConstant.onPagination]);
    }
  }

  // ********************************************** GIFT TAB BAR **********************************************

  void onChangeGiftTabBar(int index) {
    selectedGiftTabIndex = index;
    update([AppConstant.onChangeGiftTabBar]);
  }

  void onChangeGiftSubTabBar(int index) {
    selectedGiftSubTabIndex = index;
    update([AppConstant.onChangeGiftTabBar]);
  }

  void onGiftFilter() {
    selectedGiftFilter = selectedGiftFilter == ApiParams.today ? ApiParams.yesterday : ApiParams.today;
    update([AppConstant.onGiftFilter]);
    onRefreshGiftUser();
  }

  void onRefreshGiftUser() {
    rankingGiftUser = [
      [[], []],
      [[], []],
      [[], []],
    ];
    isLoadingRankingGiftUser = true;
    update([AppConstant.onChangeGiftTabBar]);
    onGetGiftUser();
  }

  Future<void> onGetGiftUser() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchRankingGiftUserModel = await FetchRankingGiftUserApi.callApi(uid: uid, token: token, date: selectedGiftFilter);

    rankingGiftUser[0][0].addAll(fetchRankingGiftUserModel?.data?.daily?.topSenders ?? []);
    rankingGiftUser[0][1].addAll(fetchRankingGiftUserModel?.data?.daily?.topReceivers ?? []);

    rankingGiftUser[1][0].addAll(fetchRankingGiftUserModel?.data?.weekly?.topSenders ?? []);
    rankingGiftUser[1][1].addAll(fetchRankingGiftUserModel?.data?.weekly?.topReceivers ?? []);

    rankingGiftUser[2][0].addAll(fetchRankingGiftUserModel?.data?.monthly?.topSenders ?? []);
    rankingGiftUser[2][1].addAll(fetchRankingGiftUserModel?.data?.monthly?.topReceivers ?? []);

    Utils.showLog("Sender => ${rankingGiftUser[0].length}");
    Utils.showLog("Receiver => ${rankingGiftUser[1].length}");

    isLoadingRankingGiftUser = false;
    update([AppConstant.onChangeGiftTabBar]);
  }

  void onGiftPagination() async {
    if (giftScrollController.position.pixels == giftScrollController.position.maxScrollExtent && isPaginationRankingGiftUser == false) {
      isPaginationRankingGiftUser = true;
      update([AppConstant.onPagination]);
      await 3.seconds.delay();
      await onGetGiftUser();
      isPaginationRankingGiftUser = false;
      update([AppConstant.onPagination]);
    }
  }
}
