import 'dart:async';
import 'dart:math';
import 'package:tingle/page/login_page/model/login_model.dart';

class LoginApi {
  static Future<LoginModel> callApi({
    String? name,
    String? userName,
    String? image,
    String? mobileNumber,
    required String email,
    required String identity,
    required String fcmToken,
    required String token,
    required String uid,
    required int loginType,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final random = Random();
    final now = DateTime.now();

    // Create dummy user data
    final userData = UserData(
      name: name ?? "John Doe ${random.nextInt(1000)}",
      userName: userName ?? "johndoe_${random.nextInt(10000)}",
      gender: (random.nextBool()) ? "Male" : "Female",
      bio: "This is a bio for demo user.",
      age: 18 + random.nextInt(30),
      image: image ?? "https://example.com/profiles/user${random.nextInt(100)}.jpg",
      isProfilePicBanned: random.nextBool(),
      email: email,
      mobileNumber: mobileNumber ?? "98765${random.nextInt(100000).toString().padLeft(5, '0')}",
      countryFlagImage: "🇮🇳",
      country: "India",
      ipAddress: "192.168.${random.nextInt(255)}.${random.nextInt(255)}",
      identity: identity,
      fcmToken: fcmToken,
      uniqueId: "UNIQUE_${random.nextInt(999999)}",
      uid: uid,
      provider: (loginType == 3) ? "google" : "mobile",
      coin: 5000 + random.nextInt(5000),
      consumedCoins: 1000 + random.nextInt(4000),
      purchasedCoin: 2000 + random.nextInt(3000),
      receivedCoin: 1500 + random.nextInt(2000),
      receivedGift: 100 + random.nextInt(300),
      totalWithdrawalCoin: 300 + random.nextInt(700),
      totalWithdrawalAmount: 100 + random.nextInt(500),
      isLive: random.nextBool(),
      liveHistoryId: "live_${random.nextInt(10000)}",
      isBlock: false,
      isOnline: true,
      isFake: random.nextBool(),
      isVerified: random.nextBool(),
      lastlogin: now.subtract(Duration(days: random.nextInt(10))).toIso8601String(),
      date: now.toIso8601String(),
      sId: "id_${random.nextInt(9999)}",
      loginType: loginType,
      createdAt: now.subtract(Duration(days: random.nextInt(30))).toIso8601String(),
      updatedAt: now.toIso8601String(),
    );

    return LoginModel(
      status: true,
      message: "Login successful",
      signUp: random.nextBool(),
      user: userData,
    );
  }
}
