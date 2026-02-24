import 'package:tingle/common/model/fetch_setting_model.dart';
import 'package:tingle/utils/utils.dart';
import 'dart:async';

class FetchSettingApi {
  static FetchSettingModel? fetchSettingModel;

  static Future<void> callApi({required String uid, required String token}) async {
    Utils.showLog("Mock Fetch Setting API Calling...");

    await Future.delayed(const Duration(milliseconds: 100)); // simulate network delay

    fetchSettingModel = FetchSettingModel(
      status: true,
      message: "Settings fetched successfully",
      data: Data(
        currency: Currency(
          name: "Indian Rupee",
          symbol: "₹",
          countryCode: "IN",
          currencyCode: "INR",
          isDefault: true,
        ),
        id: "settings_001",
        isGooglePlayEnabled: true,
        isStripeEnabled: true,
        stripePublishableKey: "pk_test_1234567890",
        stripeSecretKey: "sk_test_0987654321",
        isRazorpayEnabled: true,
        razorPayId: "rzp_test_Abc12345",
        razorSecretKey: "secret_test_Key",
        isFlutterwaveEnabled: false,
        flutterWaveId: "FLW1234567",
        privacyPolicyLink: "https://example.com/privacy-policy",
        termsOfUsePolicyLink: "https://example.com/terms-of-use",
        isDummyData: false,
        loginBonus: 100,
        privateCallRate: 20,
        durationOfShorts: 30,
        minCoinsToCashOut: 500,
        minCoinsForPayout: 1000,
        pkEndTime: 60,
        videoBanned: ["violence", "adult"],
        postBanned: ["spam", "abuse"],
        sightengineUser: "sightengine_user_123",
        sightengineApiSecret: "sightengine_secret_123",
        shortsEffectEnabled: true,
        androidEffectLicenseKey: "android_license_key_sample",
        iosEffectLicenseKey: "ios_license_key_sample",
        watermarkEnabled: true,
        watermarkIcon: "https://example.com/watermark.png",
        privateKey: PrivateKey(
          type: "service_account",
          projectId: "tingle-project-id",
          privateKeyId: "private_key_id_sample",
          privateKey: "-----BEGIN PRIVATE KEY-----\nPRIVATE_KEY\n-----END PRIVATE KEY-----\n",
          clientEmail: "client@example.com",
          clientId: "client_id_sample",
          authUri: "https://accounts.google.com/o/oauth2/auth",
          tokenUri: "https://oauth2.googleapis.com/token",
          authProviderX509CertUrl: "https://www.googleapis.com/oauth2/v1/certs",
          clientX509CertUrl: "https://www.googleapis.com/robot/v1/metadata/x509/client",
          universeDomain: "googleapis.com",
        ),
        createdAt: "2025-01-01T10:00:00Z",
        updatedAt: "2025-04-01T15:00:00Z",
        profilePhotoList: ["https://example.com/profile1.jpg", "https://example.com/profile2.jpg", "https://example.com/profile3.jpg"],
      ),
    );

    Utils.showLog("Mock Settings fetched successfully!");
  }
}
