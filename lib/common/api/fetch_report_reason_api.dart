import 'package:tingle/common/model/fetch_report_reason_model.dart';
import 'package:tingle/utils/utils.dart';
import 'dart:async';

class FetchReportReasonApi {
  static Future<FetchReportReasonModel?> callApi({
    required String uid,
    required String token,
  }) async {
    Utils.showLog("Mock Fetch Report Reason API Called...");

    await Future.delayed(const Duration(milliseconds: 100)); // simulate network delay

    return FetchReportReasonModel(
      status: true,
      message: "Report reasons fetched successfully",
      data: [
        Data(
          id: "rep_01",
          title: "Inappropriate Content",
          createdAt: "2025-04-01T12:00:00Z",
          updatedAt: "2025-04-01T12:00:00Z",
        ),
        Data(
          id: "rep_02",
          title: "Harassment or Bullying",
          createdAt: "2025-04-01T12:10:00Z",
          updatedAt: "2025-04-01T12:10:00Z",
        ),
        Data(
          id: "rep_03",
          title: "Fake Profile",
          createdAt: "2025-04-01T12:20:00Z",
          updatedAt: "2025-04-01T12:20:00Z",
        ),
        Data(
          id: "rep_04",
          title: "Spam or Scam",
          createdAt: "2025-04-01T12:30:00Z",
          updatedAt: "2025-04-01T12:30:00Z",
        ),
        Data(
          id: "rep_05",
          title: "Hate Speech",
          createdAt: "2025-04-01T12:40:00Z",
          updatedAt: "2025-04-01T12:40:00Z",
        ),
      ],
    );
  }
}
