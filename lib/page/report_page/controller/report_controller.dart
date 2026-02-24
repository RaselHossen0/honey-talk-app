import 'package:get/get.dart';
import 'package:tingle/page/report_page/api/fetch_report_api.dart';
import 'package:tingle/page/report_page/model/fetch_report_model.dart';
import 'package:tingle/utils/constant.dart';

class ReportController extends GetxController {
  bool isLoading = true;
  FetchReportModel? model;

  bool isThisWeek = true;

  List<DailyReport> get dailyReports =>
      isThisWeek ? (model?.data?.thisWeek ?? []) : (model?.data?.lastWeek ?? []);

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    isLoading = true;
    update([AppConstant.onGetFeed]);
    model = await FetchReportApi.callApi();
    isLoading = false;
    update([AppConstant.onGetFeed]);
  }

  void selectThisWeek() {
    if (!isThisWeek) {
      isThisWeek = true;
      update([AppConstant.onGetFeed]);
    }
  }

  void selectLastWeek() {
    if (isThisWeek) {
      isThisWeek = false;
      update([AppConstant.onGetFeed]);
    }
  }
}
