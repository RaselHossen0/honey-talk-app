import 'dart:convert';
import 'dart:math';
import 'package:tingle/page/login_page/model/fetch_login_user_profile_model.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class FetchLoginUserProfileApi {
  static FetchLoginUserProfileModel? fetchLoginUserProfileModel;

  static Future<void> callApi({required String token, required String uid}) async {
    Utils.showLog("Get Login User Profile Dummy Api Calling...");

    await Future.delayed(const Duration(milliseconds: 100)); // Simulate network delay
    MyUser generateDummyUser() {
      final random = Random();
      final now = DateTime.now();

      return MyUser(
        id: "user_${random.nextInt(10000)}",
        name: "Demo User",
        userName: "demo_user_${random.nextInt(999)}",
        gender: random.nextBool() ? "Male" : "Female",
        bio: "This is a demo bio for a user",
        age: 18 + random.nextInt(32), // 18-50 years
        image: "https://example.com/images/user_profile_${random.nextInt(100)}.jpg",
        isProfilePicBanned: random.nextBool(),
        email: "demo_user${random.nextInt(100)}@example.com",
        mobileNumber: "9876543${random.nextInt(10000)}",
        countryFlagImage: "🇮🇳",
        country: "India",
        ipAddress: "192.168.${random.nextInt(255)}.${random.nextInt(255)}",
        identity: "identity_${random.nextInt(10000)}",
        fcmToken: "fcm_token_${random.nextInt(10000)}",
        uniqueId: "UNIQUE_${random.nextInt(1000000)}",
        firebaseUid: "firebase_uid_${random.nextInt(1000000)}",
        provider: "google",
        coin: 5000 + random.nextInt(5000),
        topUpCoins: 2000 + random.nextInt(3000),
        spentCoins: 1500 + random.nextInt(2500),
        receivedCoins: 3000 + random.nextInt(4000),
        receivedGifts: 50 + random.nextInt(50),
        withdrawnCoins: 500 + random.nextInt(500),
        withdrawnAmount: 100 + random.nextInt(1000),

        wealthLevel: "Gold",
        activeAvtarFrame: ActiveAvtarFrame(
          id: "af_${random.nextInt(999)}",
          type: 1,
          image: "https://example.com/avatar_frames/frame_${random.nextInt(5)}.png",
        ),
        activeTheme: ActiveTheme(
          id: "theme_${random.nextInt(999)}",
          image: "https://example.com/themes/theme_${random.nextInt(5)}.png",
        ),
        activeRide: ActiveRide(
          id: "ride_${random.nextInt(999)}",
          image: "https://example.com/rides/ride_${random.nextInt(5)}.png",
        ),
        isBlock: false,
        isFake: random.nextBool(),
        isVerified: random.nextBool(),
        isOnline: random.nextBool(),
        isBusy: random.nextBool(),
        isVIP: random.nextBool(),
        role: 1,
        agencyId: "agency_${random.nextInt(500)}",
        agencyOwnerId: "owner_${random.nextInt(500)}",
        isLive: random.nextBool(),
        liveHistoryId: "live_${random.nextInt(10000)}",
        callId: "call_${random.nextInt(10000)}",
        lastlogin: now.subtract(Duration(days: random.nextInt(30))).toIso8601String(),
        date: now.toIso8601String(),
        referralCode: "REF_${random.nextInt(10000)}",
        loginType: 1,
        createdAt: now.toIso8601String(),
        updatedAt: now.toIso8601String(),
      );
    }

    // Create dummy data
    fetchLoginUserProfileModel = FetchLoginUserProfileModel(status: true, message: "Login user profile fetched successfully", user: generateDummyUser());

    // Save it to local Database
    Database.onSetLoginUserProfile(jsonEncode(fetchLoginUserProfileModel?.toJson()));

    Utils.showLog("Dummy Login User Profile Saved Successfully ✅");
  }
}
