import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

/// Razorpay payment service: create order on backend, open checkout with [orderId], then verify on success.
class RazorPayService {
  static late Razorpay _razorPay;
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _initialized = true;
  }

  static void _clearListeners() {
    if (!_initialized) return;
    _razorPay.clear();
    _initialized = false;
  }

  static void Function(PaymentSuccessResponse)? onPaymentSuccess;
  static void Function(String)? onPaymentError;

  static void _handlePaymentSuccess(PaymentSuccessResponse response) {
    onPaymentSuccess?.call(response);
  }

  static void _handlePaymentError(PaymentFailureResponse response) {
    Utils.showLog("RazorPay Payment Failed: ${response.message}");
    onPaymentError?.call(response.message ?? 'Payment failed');
  }

  static void _handleExternalWallet(ExternalWalletResponse response) {
    Utils.showLog("RazorPay External Wallet: ${response.walletName}");
  }

  /// Open Razorpay checkout with server-created [orderId]. [keyId] is Razorpay key from settings.
  static void openCheckout({
    required String orderId,
    required String keyId,
    String? userName,
    String? userEmail,
  }) {
    if (!_initialized) init();

    final options = <String, dynamic>{
      'key': keyId,
      'order_id': orderId,
      'name': EnumLocal.txtAppName.name.tr,
      'theme.color': _colorToHex(AppColor.primary),
      'description': EnumLocal.txtAppName.name,
      'prefill': {
        'name': userName ?? '',
        'email': userEmail ?? '',
        'contact': '',
      },
    };

    try {
      _razorPay.open(options);
    } catch (e) {
      debugPrint("Razorpay open error: $e");
      onPaymentError?.call(e.toString());
    }
  }

  static String _colorToHex(Color color) {
    return '#${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  /// Call when done with payment flow (success or dismiss) to avoid duplicate callbacks.
  static void dispose() {
    _clearListeners();
  }
}
