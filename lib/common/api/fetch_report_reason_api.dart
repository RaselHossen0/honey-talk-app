import 'package:tingle/common/model/fetch_report_reason_model.dart';
import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

class FetchReportReasonApi {
  static Future<FetchReportReasonModel?> callApi({
    required String uid,
    required String token,
  }) async {
    Utils.showLog("Fetch Report Reason API Called...");
    try {
      final res = await ApiClient.instance.get('/report/reasons');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final items = list.map((m) {
        final x = Map<String, dynamic>.from(m);
        x['_id'] ??= x['id'];
        x['title'] ??= x['reason'];
        return Data.fromJson(x);
      }).toList();
      return FetchReportReasonModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: items,
      );
    } catch (e) {
      Utils.showLog("Fetch Report Reason API Error: $e");
      return null;
    }
  }
}
