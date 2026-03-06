import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

/// Verifies payment with backend and credits coins.
/// Response: { status, message, data: { totalCoins, credited } }
class VerifyRazorpayPaymentApi {
  static Future<Map<String, dynamic>> callApi({
    required String token,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    Utils.showLog("Verify Razorpay payment: $razorpayPaymentId");
    final res = await ApiClient.instance.post(
      '/payments/razorpay/verify',
      body: {
        'razorpay_order_id': razorpayOrderId,
        'razorpay_payment_id': razorpayPaymentId,
        'razorpay_signature': razorpaySignature,
      },
      token: token.isEmpty ? null : token,
    );
    return Map<String, dynamic>.from(res);
  }

  static String messageFromResponse(Map<String, dynamic> res, {String fallback = 'Verification failed'}) {
    final msg = res['message'];
    if (msg is String && msg.trim().isNotEmpty) return msg.trim();
    return fallback;
  }
}
