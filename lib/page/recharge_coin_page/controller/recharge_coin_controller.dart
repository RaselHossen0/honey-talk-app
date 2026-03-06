import 'dart:developer';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/recharge_coin_page/api/create_razorpay_order_api.dart';
import 'package:tingle/page/recharge_coin_page/api/fetch_coin_plan_api.dart';
import 'package:tingle/page/recharge_coin_page/api/verify_razorpay_payment_api.dart';
import 'package:tingle/page/recharge_coin_page/model/fetch_coin_plan_model.dart';
import 'package:tingle/payment/razor_pay/razor_pay_view.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class RechargeCoinController extends GetxController {
  bool isLoading = false;
  List<Data> coinPlans = [];
  FetchCoinPlanModel? fetchCoinPlanModel;

  bool isAllowAgreement = false;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onClose() {
    RazorPayService.dispose();
    super.onClose();
  }

  Future<void> init() async {
    onGetCoinPlan();
    FetchUserCoin.coin;
    FetchUserCoin.init();
    Database.onSetMyCoins(FetchUserCoin.coin.value);
  }

  void onToggleAgreement() {
    isAllowAgreement = !isAllowAgreement;
    update([AppConstant.onToggleAgreement]);
  }

  Future<void> onGetCoinPlan() async {
    isLoading = true;
    update([AppConstant.onGetCoinPlan]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchCoinPlanModel = await FetchCoinPlanApi.callApi(token: token, uid: uid);
    coinPlans = fetchCoinPlanModel?.data ?? [];

    isLoading = false;
    update([AppConstant.onGetCoinPlan]);
  }

  Future<void> onClickPayNow(int index) async {
    if (coinPlans.isEmpty || index >= coinPlans.length) return;
    if (Utils.razorpayTestKey.isEmpty) {
      Utils.showToast(text: 'Razorpay is not configured. Please try later.');
      return;
    }

    final coinPlanId = coinPlans[index].id ?? "";
    if (coinPlanId.isEmpty) return;

    final token = await FirebaseAccessToken.onGet() ?? "";
    final profile = Database.fetchLoginUserProfile();
    final userName = profile?.user?.name ?? "";
    final userEmail = profile?.user?.email ?? "";

    try {
      Get.dialog(const LoadingWidget(), barrierDismissible: false);
      final orderRes = await CreateRazorpayOrderApi.callApi(
        token: token,
        coinPlanId: coinPlanId,
      );
      Get.back();

      final status = orderRes['status'] as bool?;
      final data = orderRes['data'] as Map<String, dynamic>?;
      final orderId = data?['orderId'] as String?;
      final keyId = data?['keyId'] as String?;

      if (status != true || orderId == null || keyId == null) {
        Utils.showToast(
          text: CreateRazorpayOrderApi.messageFromResponse(orderRes, fallback: 'Failed to create order'),
        );
        return;
      }

      RazorPayService.onPaymentSuccess = (PaymentSuccessResponse response) async {
        RazorPayService.onPaymentSuccess = null;
        RazorPayService.onPaymentError = null;
        Get.dialog(const LoadingWidget(), barrierDismissible: false);
        try {
          final verifyRes = await VerifyRazorpayPaymentApi.callApi(
            token: token,
            razorpayOrderId: response.orderId ?? '',
            razorpayPaymentId: response.paymentId ?? '',
            razorpaySignature: response.signature ?? '',
          );
          Get.back();
          final ok = verifyRes['status'] as bool? ?? false;
          final verifyData = verifyRes['data'] as Map<String, dynamic>?;
          final totalCoins = verifyData?['totalCoins'];
          if (ok && totalCoins != null) {
            Database.onSetMyCoins(totalCoins is int ? totalCoins : 0);
            FetchUserCoin.init();
            Utils.showToast(text: EnumLocal.txtDiamondRechargeSuccess.name.tr);
            update([AppConstant.onGetCoinPlan]);
          } else {
            Utils.showToast(
              text: VerifyRazorpayPaymentApi.messageFromResponse(
                verifyRes,
                fallback: EnumLocal.txtSomeThingWentWrong.name.tr,
              ),
            );
          }
        } catch (e) {
          Get.back();
          log("Verify Razorpay error: $e");
          Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
        }
      };

      RazorPayService.onPaymentError = (String message) {
        RazorPayService.onPaymentSuccess = null;
        RazorPayService.onPaymentError = null;
        Utils.showToast(text: message.isNotEmpty ? message : 'Payment failed');
      };

      RazorPayService.init();
      RazorPayService.openCheckout(
        orderId: orderId,
        keyId: keyId,
        userName: userName,
        userEmail: userEmail,
      );
    } catch (e) {
      Get.back();
      log("Razorpay order/payment error: $e");
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
    }
  }
}
