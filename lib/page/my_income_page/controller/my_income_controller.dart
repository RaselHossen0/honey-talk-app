import 'package:get/get.dart';
import 'package:tingle/page/my_income_page/api/fetch_my_income_api.dart';
import 'package:tingle/page/my_income_page/model/fetch_my_income_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';

class MyIncomeController extends GetxController {
  bool isLoading = true;
  FetchMyIncomeModel? fetchMyIncomeModel;

  int get totalBonus => fetchMyIncomeModel?.data?.totalBonus ?? 0;
  int get subsidyRevenue => fetchMyIncomeModel?.data?.subsidyRevenue ?? 0;
  int get payingRevenue => fetchMyIncomeModel?.data?.payingRevenue ?? 0;
  TodayReport? get todayReport => fetchMyIncomeModel?.data?.todayReport;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    isLoading = true;
    update([AppConstant.onGetFeed]);
    fetchMyIncomeModel = await FetchMyIncomeApi.callApi();
    isLoading = false;
    update([AppConstant.onGetFeed]);
  }

  void onNavigateToDetails() {
    Get.toNamed(AppRoutes.incomeDetailsPage);
  }

  void onNavigateToReport() {
    Get.toNamed(AppRoutes.reportPage);
  }
}
