import 'dart:async';
import 'package:tingle/page/recharge_coin_page/model/fetch_coin_plan_model.dart';

class FetchCoinPlanApi {
  static Future<FetchCoinPlanModel> callApi({
    required String token,
    required String uid,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final now = DateTime.now().toIso8601String();

    List<Data> plans = List.generate(5, (index) {
      final coinAmount = (index + 1) * 100;
      return Data(
        id: "plan_${index + 1}",
        coin: coinAmount,
        amount: coinAmount / 10,
        productKey: "product_key_${index + 1}",
        isPopular: index == 2, // third plan is popular
        isActive: true,
        createdAt: now,
        updatedAt: now,
      );
    });

    return FetchCoinPlanModel(
      status: true,
      message: "Coin plans fetched successfully",
      data: plans,
    );
  }
}
