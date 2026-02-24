import 'dart:async';
import 'dart:math';
import 'package:tingle/page/recharge_coin_page/model/create_coin_plan_history_model.dart';

class CreateCoinPlanHistoryApi {
  static Future<CreateCoinPlanHistoryModel> callApi({
    required String token,
    required String uid,
    required String coinPlanId,
    required String paymentGateway,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Simulate random coin result based on coinPlanId
    final random = Random();
    final coinAmount = 100 * (random.nextInt(5) + 1); // e.g., 100, 200, ..., 500

    return CreateCoinPlanHistoryModel(
      status: true,
      message: "Coins added successfully via $paymentGateway",
      totalCoins: coinAmount,
    );
  }
}
