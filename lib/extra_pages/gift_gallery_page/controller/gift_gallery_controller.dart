import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/fans_ranking_page/api/fetch_fans_ranking_api.dart';
import 'package:tingle/page/fans_ranking_page/model/fetch_fans_ranking_model.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class FansRankingController extends GetxController {
  ScrollController scrollController = ScrollController();

  int selectedTabIndex = 0;

  bool isLoading = false;
  bool isPagination = false;
  List<List<DailyWeeklyMonthlyCommonModel>> fansRanking = [[], [], []]; // Daily, Weekly, Monthly
  FetchFansRankingModel? fetchFansRankingModel;

  @override
  Future<void> onInit() async {
    scrollController.addListener(onPagination);
    onRefresh();
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    scrollController.removeListener(onPagination);
    super.onClose();
  }

  void onChangeTabBar(int index) {
    selectedTabIndex = index;
    update([AppConstant.onChangeTabBar]);
  }

  void onRefresh() {
    isLoading = true;
    fansRanking = [[], [], []];
    update([AppConstant.onChangeTabBar]);
    onGetFansRanking();
  }

  Future<void> onGetFansRanking() async {
    fetchFansRankingModel = await FetchFansRankingApi.callApi();
    fansRanking[0].addAll(fetchFansRankingModel?.data?.daily ?? []);
    fansRanking[1].addAll(fetchFansRankingModel?.data?.weekly ?? []);
    fansRanking[2].addAll(fetchFansRankingModel?.data?.monthly ?? []);

    isLoading = false;

    Utils.showLog("Daily => ${fansRanking[0].length}");
    Utils.showLog("Weekly => ${fansRanking[1].length}");
    Utils.showLog("Monthly => ${fansRanking[2].length}");

    update([AppConstant.onChangeTabBar]);
  }

  void onPagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && isPagination == false) {
      isPagination = true;
      update([AppConstant.onPagination]);
      await onGetFansRanking();
      isPagination = false;
      update([AppConstant.onPagination]);
    }
  }
}
