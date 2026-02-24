import 'package:tingle/page/report_page/model/fetch_report_model.dart';

class FetchReportApi {
  static Future<FetchReportModel> callApi() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return FetchReportModel(
      status: true,
      message: "Success",
      data: ReportData(
        thisWeek: [
          DailyReport(
            date: "02-17",
            liveTime: "02:08:21",
            callDurationLiveMins: 27,
            callDurationMins: 3,
            negativeReview: 0,
            complaint: 0,
            partyDuration: 0,
            subsidyRevenue: 8118,
            payingRevenue: 16569,
            partyRevenue: 0,
            benefitsOfPrivateChat: 0,
            totalRevenues: 24687,
            estimatedSettlementAmount: 2,
          ),
          DailyReport(
            date: "02-16",
            liveTime: "00:00:00",
            callDurationLiveMins: 0,
            callDurationMins: 0,
            negativeReview: 0,
            complaint: 0,
            partyDuration: 0,
            subsidyRevenue: 0,
            payingRevenue: 0,
            partyRevenue: 0,
            benefitsOfPrivateChat: 0,
            totalRevenues: 0,
            estimatedSettlementAmount: 0,
          ),
          DailyReport(
            date: "02-15",
            liveTime: "01:30:00",
            callDurationLiveMins: 15,
            callDurationMins: 5,
            negativeReview: 0,
            complaint: 0,
            partyDuration: 120,
            subsidyRevenue: 5000,
            payingRevenue: 8000,
            partyRevenue: 500,
            benefitsOfPrivateChat: 200,
            totalRevenues: 13700,
            estimatedSettlementAmount: 1,
          ),
        ],
        lastWeek: [
          DailyReport(
            date: "02-10",
            liveTime: "03:00:00",
            callDurationLiveMins: 45,
            callDurationMins: 10,
            negativeReview: 0,
            complaint: 0,
            partyDuration: 0,
            subsidyRevenue: 12000,
            payingRevenue: 20000,
            partyRevenue: 0,
            benefitsOfPrivateChat: 0,
            totalRevenues: 32000,
            estimatedSettlementAmount: 3,
          ),
          DailyReport(
            date: "02-09",
            liveTime: "00:00:00",
            callDurationLiveMins: 0,
            callDurationMins: 0,
            negativeReview: 0,
            complaint: 0,
            partyDuration: 0,
            subsidyRevenue: 0,
            payingRevenue: 0,
            partyRevenue: 0,
            benefitsOfPrivateChat: 0,
            totalRevenues: 0,
            estimatedSettlementAmount: 0,
          ),
        ],
      ),
    );
  }
}
