import 'package:tingle/common/model/fetch_user_coin_model.dart';
import 'package:tingle/utils/utils.dart';
import 'dart:async';

class FetchUserCoinApi {
  static Future<FetchUserCoinModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Mock Fetch User Coin API Calling...");

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return dummy data
    return FetchUserCoinModel(
      status: true,
      message: "User coin fetched successfully",
      coinBalance: 7850, // You can change this to any balance you want
    );
  }
}
