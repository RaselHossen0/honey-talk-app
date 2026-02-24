import 'package:tingle/common/model/fatch_other_user_profile_model.dart';
import 'package:tingle/utils/utils.dart';
import 'dart:async';

class FetchOtherUserProfileInfoApi {
  static OtherUserProfileModel? otherUserProfileModel;

  static Future<OtherUserProfileModel?> callApi({
    required String token,
    required String uid,
    required String toUserId,
  }) async {
    Utils.showLog("Mock Fetch Other User Profile Info API Called...");

    await Future.delayed(const Duration(milliseconds: 100)); // simulate network delay

    return OtherUserProfileModel(
      status: true,
      message: "User profile fetched successfully",
      user: User(
        id: "user_101",
        name: "Ishaan Patel",
        userName: "ishaan_live",
        gender: "male",
        age: 26,
        image: "https://example.com/user/ishaan.jpg",
        isProfilePicBanned: false,
        countryFlagImage: "🇮🇳",
        country: "India",
        uniqueId: "UNQISH2025",
        coin: 12500,
        receivedGifts: 47,
        wealthLevel: WealthLevel(
          id: "wl_05",
          levelImage: "https://example.com/wealth/level_5.png",
        ),
        isVerified: true,
        totalFollowers: 2200,
        totalFollowing: 530,
        totalFriends: 85,
        totalVisitors: 2300,
        isFollowed: true,
      ),
    );
  }
}
