import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

/// Response: { status, message, data: { orderId, keyId, amount, currency, coin } }
/// On 4xx/5xx backend returns { statusCode, message }; we return body as-is so caller can read message.
class CreateRazorpayOrderApi {
  static Future<Map<String, dynamic>> callApi({
    required String token,
    required String coinPlanId,
  }) async {
    Utils.showLog("Create Razorpay order for plan: $coinPlanId");
    final res = await ApiClient.instance.post(
      '/payments/razorpay/create-order',
      body: {'coinPlanId': coinPlanId},
      token: token.isEmpty ? null : token,
    );
    return Map<String, dynamic>.from(res);
  }

  /// Extract user-facing message from create-order or verify response (Nest sends 'message').
  static String messageFromResponse(Map<String, dynamic> res, {String fallback = 'Something went wrong'}) {
    final msg = res['message'];
    if (msg is String && msg.trim().isNotEmpty) return msg.trim();
    return fallback;
  }
}
