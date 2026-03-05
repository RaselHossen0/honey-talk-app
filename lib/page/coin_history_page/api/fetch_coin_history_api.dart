import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/coin_history_page/model/fetch_coin_history_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchCoinHistoryApi {
  static Future<FetchCoinHistoryModel?> callApi({
    required String startDate,
    required String endDate,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final params = <String, String>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };
      if (startDate.isNotEmpty) params['startDate'] = startDate;
      if (endDate.isNotEmpty) params['endDate'] = endDate;

      final res = await ApiClient.instance.get('/transactions/history', queryParameters: params);
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final data = list.map((m) => Data.fromJson(Map<String, dynamic>.from(m))).toList();
      return FetchCoinHistoryModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: data,
      );
    } catch (e) {
      Utils.showLog('FetchCoinHistoryApi error: $e');
      return null;
    }
  }
}
