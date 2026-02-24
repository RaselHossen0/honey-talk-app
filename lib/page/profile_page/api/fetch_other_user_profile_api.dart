import 'dart:async';
import 'dart:math';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';

class FetchOtherUserProfileApi {
  static Future<FetchUserProfileModel> callApi({
    required String token,
    required String uid,
    required String toUserId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate slight network delay

    final random = Random();
    final countries = [
      {'name': 'India', 'flag': '🇮🇳'},
      {'name': 'United States', 'flag': '🇺🇸'},
      {'name': 'Germany', 'flag': '🇩🇪'},
      {'name': 'Japan', 'flag': '🇯🇵'},
    ];
    final country = countries[random.nextInt(countries.length)];

    final user = User(
      id: 'user_${toUserId}_id',
      // name: 'User $toUserId',
      // userName: 'user_$toUserId',
      name: FakeProfilesSet.sampleNames[Random().nextInt(10)],
      userName: FakeProfilesSet.sampleNames[Random().nextInt(10)],

      gender: random.nextBool() ? 'male' : 'female',
      age: 18 + random.nextInt(30),
      image: 'https://randomuser.me/api/portraits/${random.nextBool() ? 'men' : 'women'}/${random.nextInt(100)}.jpg',
      isProfilePicBanned: random.nextBool(),
      countryFlagImage: country['flag'],
      country: country['name'],
      uniqueId: 'unique_id_$toUserId',
      coin: 500 + random.nextInt(5000),
      receivedGifts: random.nextInt(1000),
      wealthLevel: WealthLevel(
        id: 'wealth_${random.nextInt(10)}',
        levelImage: 'https://picsum.photos/seed/wealth${random.nextInt(1000)}/100/100',
      ),
      activeAvtarFrame: ActiveAvtarFrame(
        id: 'avtar_${random.nextInt(100)}',
        type: random.nextInt(3),
        image: 'https://picsum.photos/seed/avatar${random.nextInt(1000)}/120/120',
      ),
      isVerified: random.nextBool(),
      totalFollowers: 1000 + random.nextInt(5000),
      totalFollowing: 100 + random.nextInt(500),
      totalFriends: 50 + random.nextInt(200),
      totalVisitors: 5000 + random.nextInt(20000),
    );

    return FetchUserProfileModel(
      status: true,
      message: "Dummy user profile fetched successfully",
      user: user,
    );
  }
}
