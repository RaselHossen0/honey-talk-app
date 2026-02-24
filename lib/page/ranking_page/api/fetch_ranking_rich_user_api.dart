import 'dart:async';
import 'dart:math';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/ranking_page/model/fetch_ranking_rich_user_model.dart';

class FetchRankingRichUserApi {
  static Future<FetchRankingRichUserModel> callApi({
    required String uid,
    required String token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

    final random = Random();
    final genders = ['Male', 'Female', 'Other'];
    // Use only 0, 1, 2 (network images). Type 3 expects SVGA format - picsum URLs are regular images.
    final frameTypes = [0, 1, 2];

    List<Daily> generateUsers(int count) {
      return List.generate(count, (index) {
        final gender = genders[random.nextInt(genders.length)];
        return Daily(
          userId: 'user_id_${index + 1}',
          name: FakeProfilesSet.sampleNames[index],
          image: FakeProfilesSet.sampleImages[index],
          isProfilePicBanned: random.nextBool(),
          gender: gender,
          age: 18 + random.nextInt(30),
          isVerified: random.nextBool(),
          wealthLevelImage: 'https://picsum.photos/seed/wealth${index + 1}/100/100',
          avtarFrame: 'https://picsum.photos/seed/frame${index + 1}/60/60',
          avtarFrameType: frameTypes[random.nextInt(frameTypes.length)],
          coin: 1000 + random.nextInt(50000),
        );
      });
    }

    return FetchRankingRichUserModel(
      status: true,
      message: "Dummy ranking data generated",
      data: Data(
        daily: generateUsers(10),
        weekly: generateUsers(8),
        monthly: generateUsers(6),
      ),
    );
  }
}
