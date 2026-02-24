import 'dart:async';

import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/page/my_chat_price_page/model/fetch_my_chat_price_model.dart';
import 'package:tingle/utils/utils.dart';

/// API layer - replace mock with HTTP when backend is ready
class FetchMyChatPriceApi {
  static FetchMyChatPriceModel? fetchMyChatPriceModel;

  static Future<FetchMyChatPriceModel> callApi() async {
    Utils.showLog("Fetch My Chat Price API Calling...");
    await Future.delayed(const Duration(milliseconds: 200));

    // Use privateCallRate from settings when available, else default
    final rate = FetchSettingApi.fetchSettingModel?.data?.privateCallRate ?? 300;

    fetchMyChatPriceModel = FetchMyChatPriceModel(
      status: true,
      message: "Success",
      data: MyChatPriceData(
        videoCallPricePerMin: rate != 300 ? rate : 2450,
        userLevel: 4,
        availablePriceOptions: [1750, 2450, 2800, 3500, 3850, 4200, 5000],
        defaultNewHostPrice: 1750,
        freeCallEarning: 700,
        priceRaiseCountThisWeek: 0,
        priceRaiseOpportunitiesPerWeek: 2,
        highestCallPriceTiers: [
          LevelPriceTier(levelRange: "≤Lv4", maxPrice: 1800),
          LevelPriceTier(levelRange: "Lv5", maxPrice: 2400),
          LevelPriceTier(levelRange: "Lv6", maxPrice: 3000),
          LevelPriceTier(levelRange: "Lv7", maxPrice: 3600),
          LevelPriceTier(levelRange: "Lv8", maxPrice: 4800),
          LevelPriceTier(levelRange: "≥Lv9", maxPrice: 6000),
        ],
      ),
    );
    return fetchMyChatPriceModel!;
  }
}
