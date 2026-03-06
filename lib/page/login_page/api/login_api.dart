import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/login_page/model/login_model.dart';
import 'package:tingle/utils/database.dart';

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
    final client = ApiClient.instance;

    // 1) Backend login (Firebase UID) -> accessToken; send name/email/image so backend stores them (e.g. Google)
    final body = <String, dynamic>{
      'firebaseUid': uid,
      'token': token,
    };
    if (name != null && name!.isNotEmpty) body['name'] = name;
    if (email.isNotEmpty) body['email'] = email;
    if (image != null && image!.isNotEmpty) body['image'] = image;
    final loginRes = await client.post('/auth/login', body: body);
    final accessToken = loginRes['accessToken'] as String?;
    if (accessToken == null || accessToken.isEmpty) {
      return LoginModel(
        status: false,
        message: loginRes['message'] as String? ?? 'Login failed',
        signUp: false,
        user: null,
      );
    }
    await Database.onSetAccessToken(accessToken);

    // 2) Get profile -> map to UserData
    final meRes = await client.get('/users/me', token: accessToken);
    if (meRes['id'] == null) {
      return LoginModel(
        status: false,
        message: 'Failed to load profile',
        signUp: false,
        user: null,
      );
    }

    final u = meRes;
    final userData = UserData(
      name: u['name'] as String?,
      userName: u['userName'] as String?,
      gender: u['gender'] as String?,
      bio: u['bio'] as String?,
      age: (u['age'] as num?)?.toInt(),
      image: u['image'] as String?,
      isProfilePicBanned: u['isProfilePicBanned'] as bool? ?? false,
      email: u['email'] as String? ?? email,
      mobileNumber: u['mobileNumber'] as String? ?? mobileNumber,
      countryFlagImage: u['countryFlagImage'] as String?,
      country: u['country'] as String?,
      identity: identity,
      fcmToken: fcmToken,
      uniqueId: u['uniqueId'] as String?,
      uid: uid,
      provider: loginType == 3 ? 'google' : 'mobile',
      coin: (u['coin'] as num?)?.toInt() ?? 0,
      consumedCoins: 0,
      purchasedCoin: 0,
      receivedCoin: (u['receivedGifts'] as num?)?.toInt() ?? 0,
      receivedGift: (u['receivedGifts'] as num?)?.toInt() ?? 0,
      totalWithdrawalCoin: 0,
      totalWithdrawalAmount: 0,
      isLive: u['isLive'] as bool? ?? false,
      liveHistoryId: null,
      isBlock: u['isBlock'] as bool? ?? false,
      isOnline: u['isOnline'] as bool? ?? false,
      isFake: false,
      isVerified: u['isVerified'] as bool? ?? false,
      lastlogin: null,
      date: DateTime.now().toIso8601String(),
      sId: u['id'] as String?,
      loginType: loginType,
      createdAt: (u['createdAt'] as String?) ?? DateTime.now().toIso8601String(),
      updatedAt: (u['updatedAt'] as String?) ?? DateTime.now().toIso8601String(),
    );

    return LoginModel(
      status: true,
      message: 'Login successful',
      signUp: false,
      user: userData,
    );
  }
}
