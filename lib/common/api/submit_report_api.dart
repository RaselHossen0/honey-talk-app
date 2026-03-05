import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/common/model/send_report_model.dart';
import 'package:tingle/utils/utils.dart';

class SubmitReportApi {
  static Future<SendReportModel> callApi({
    required String type,
    required String id,
    required String reportReasonId,
    String? reportReasonText,
  }) async {
    try {
      final body = <String, dynamic>{
        'reportReasonId': reportReasonId,
        if (reportReasonText != null && reportReasonText.isNotEmpty) 'reportReasonText': reportReasonText,
      };
      if (type == 'user') {
        body['reportedUserId'] = id;
      } else if (type == 'post') {
        body['reportedPostId'] = id;
      } else if (type == 'video') {
        body['reportedVideoId'] = id;
      }
      final res = await ApiClient.instance.post('/report', body: body);
      return SendReportModel(
        status: res['status'] as bool? ?? false,
        message: res['message'] as String? ?? '',
      );
    } catch (e) {
      Utils.showLog("Submit Report API Error: $e");
      return SendReportModel(status: false, message: e.toString());
    }
  }
}
