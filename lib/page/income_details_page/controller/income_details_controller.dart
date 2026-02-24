import 'package:get/get.dart';
import 'package:tingle/page/income_details_page/api/fetch_income_details_api.dart';
import 'package:tingle/page/income_details_page/model/fetch_income_details_model.dart';
import 'package:tingle/utils/constant.dart';

class IncomeDetailsController extends GetxController {
  bool isLoading = false;
  List<IncomeTransaction> transactions = [];
  String selectedFilter = "All";

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    await onFetchDetails();
  }

  Future<void> onFetchDetails() async {
    isLoading = true;
    update([AppConstant.onGetFeed]);
    final model = await FetchIncomeDetailsApi.callApi(filter: selectedFilter);
    transactions = model.data ?? [];
    isLoading = false;
    update([AppConstant.onGetFeed]);
  }

  Future<void> onChangeFilter(String filter) async {
    selectedFilter = filter;
    await onFetchDetails();
  }
}
