import 'package:tingle/page/store_page/model/purchase_theme.dart';

import 'package:tingle/utils/utils.dart';

import 'dart:async';

class PurchaseThemeApi {
  static Future<Fetchpurchasedtheme?> callApi({
    required String token,
    required String itemType,
    required String itemId,
    required String userId,
    required bool directWear,
  }) async {
    Utils.showLog("Mock Purchase Theme API Called");

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 100));

    // Return dummy data
    return Fetchpurchasedtheme(
      status: true,
      message: "Theme purchased successfully",
      user: User(
        id: "user_001",
        name: "Aarav Mehta",
        userName: "aarav_star",
        gender: "male",
        age: 27,
        image: "https://example.com/images/users/aarav.jpg",
        isProfilePicBanned: false,
        countryFlagImage: "🇮🇳",
        country: "India",
        uniqueId: "UNQ202501",
        coin: 15300,
        wealthLevel: WealthLevel(
          id: "wl_002",
          levelImage: "https://example.com/wealth/wealth_level_2.png",
        ),
        isVerified: true,
        totalFollowers: 1200,
        totalFollowing: 340,
        totalFriends: 75,
        totalVisitors: 980,
      ),
    );
  }
}
