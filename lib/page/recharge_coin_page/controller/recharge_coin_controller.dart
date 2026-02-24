import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/recharge_coin_page/api/create_coin_plan_history_api.dart';
import 'package:tingle/page/recharge_coin_page/api/fetch_coin_plan_api.dart';
import 'package:tingle/page/recharge_coin_page/model/create_coin_plan_history_model.dart';
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

  int selectedPaymentIndex = 0;
  bool isAllowAgreement = false;

  CreateCoinPlanHistoryModel? createCoinPlanHistoryModel;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    onGetCoinPlan();
    FetchUserCoin.coin;
    FetchUserCoin.init();
    Database.onSetMyCoins(FetchUserCoin.coin.value);
  }

  void onChangePayment(int value) {
    selectedPaymentIndex = value;
    update([AppConstant.onChangePayment]);
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

  void onClickPayNow(int index) async {
    if (selectedPaymentIndex == 0) {
    } else if (selectedPaymentIndex == 1) {
      log("message>>>>$selectedPaymentIndex>>>>> Razor Pay");

      Utils.showLog("Razorpay Payment Working....");

      try {
        Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
        // RazorPayService().init(
        //   razorKey: Utils.razorpayTestKey,
        //   callback: () async {
        //     Utils.showLog("Stripe Payment Success Method Called....");
        //
        //     Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
        //
        //     final uid = FirebaseUid.onGet() ?? "";
        //     final token = await FirebaseAccessToken.onGet() ?? "";
        //
        //     final isSuccess = await CreateCoinPlanHistoryApi.callApi(
        //       token: token,
        //       uid: uid,
        //       coinPlanId: coinPlans[index].id ?? "",
        //       paymentGateway: "Stripe",
        //     );
        //
        //     Get.back(); // Stop Loading...
        //
        //     if (isSuccess.status != null) {
        //       Utils.showToast(text: EnumLocal.txtCoinRechargeSuccess.name.tr);
        //     } else {
        //       Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
        //     }
        //   },
        // );
        await 1.seconds.delay();

        Get.back(); // Stop Loading...
      } catch (e) {
        Get.back(); // Stop Loading...
        Utils.showLog("RazorPay Payment Failed => $e");
      }
    }
  }
}
