import 'dart:async';

import 'package:tingle/page/my_income_page/model/fetch_my_income_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchMyIncomeApi {
  static Future<FetchMyIncomeModel> callApi() async {
    Utils.showLog("Fetch My Income API Calling...");
    await Future.delayed(const Duration(milliseconds: 200));

    return FetchMyIncomeModel(
      status: true,
      message: "Success",
      data: MyIncomeData(
        totalBonus: 4739229,
        subsidyRevenue: 76940,
        payingRevenue: 4662289,
        todayReport: TodayReport(
          totalRevenues: 0,
          liveTime: "00:00:00",
          todaySubsidyRevenue: 0,
          todayPayingRevenue: 0,
          callDurationLiveMins: 0,
          callDurationMins: 0,
          todayPartyDuration: 0,
          effectiveDurationLive: 0,
          todayPartyRevenue: 0,
        ),
      ),
    );
  }
}
