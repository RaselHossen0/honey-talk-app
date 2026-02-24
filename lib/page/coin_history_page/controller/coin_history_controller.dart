import 'package:get/get.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';

import 'package:tingle/page/coin_history_page/api/fetch_coin_history_api.dart';
import 'package:tingle/page/coin_history_page/model/fetch_coin_history_model.dart';
import 'package:tingle/utils/constant.dart';

class CoinHistoryController extends GetxController {
  bool isLoading = false;
  List<Data> coinHistory = [];
  FetchCoinHistoryModel? fetchCoinHistoryModel;

  String startDate = DateTime.now().toString();
  String endDate = DateTime.now().toString(); // This is Send on Api....

  String rangeDate = "All"; // This is Show on UI....

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    onGetCoinHistory();
    FetchUserCoin.init();
  }

  Future<void> onGetCoinHistory() async {
    isLoading = true;
    update([AppConstant.onGetCoinHistory]);

    fetchCoinHistoryModel = await FetchCoinHistoryApi.callApi(startDate: "2025-02-23", endDate: "2025-04-23");

    coinHistory = fetchCoinHistoryModel?.data ?? [];

    isLoading = false;
    update([AppConstant.onGetCoinHistory]);
  }

  Future<void> onChangeDate({required String startDate, required String endDate, required String rangeDate}) async {
    this.startDate = startDate;
    this.endDate = endDate;
    this.rangeDate = rangeDate;
    update([AppConstant.onChangeDate]);
  }
}
