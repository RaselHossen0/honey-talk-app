import 'dart:async';
import 'dart:math';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/ranking_page/model/fetch_ranking_gift_user_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchRankingGiftUserApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchRankingGiftUserModel?> callApi({
    required String uid,
    required String token,
    required String date,
  }) async {
    Utils.showLog("Mock Fetch Ranking Gift User Api Calling... ");

    startPagination += 1;

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return dummy model
    return FetchRankingGiftUserModel(
      status: true,
      message: "Dummy Gift Ranking fetched successfully",
      data: GiftStatsData(
        daily: generateTimeframeStats(),
        weekly: generateTimeframeStats(),
        monthly: generateTimeframeStats(),
      ),
    );
  }

  static TimeframeStats generateTimeframeStats() {
    return TimeframeStats(
      topSenders: List.generate(5, (index) => generateDummyUserStats(index, isSender: true)),
      topReceivers: List.generate(5, (index) => generateDummyUserStats(index, isSender: false)),
    );
  }

  static UserStats generateDummyUserStats(int index, {required bool isSender}) {
    final random = Random();
    final genders = ['Male', 'Female'];

    return UserStats(
      userId: "user_${index + (isSender ? 100 : 200)}",
      name: "${isSender ? 'Sender' : 'Receiver'} ${FakeProfilesSet.sampleNames[index]} ",
      image: "https://randomuser.me/api/portraits/${genders[index % 2] == 'Male' ? 'men' : 'women'}/${10 + index}.jpg",
      isProfilePicBanned: random.nextBool(),
      gender: genders[index % 2],
      age: 18 + random.nextInt(30),
      isVerified: random.nextBool(),
      wealthLevelImage: "https://dummyimage.com/wealth_level_${random.nextInt(5) + 1}.png",
      avtarFrame: "https://dummyimage.com/avatar_frame_${random.nextInt(3) + 1}.png",
      avtarFrameType: random.nextInt(2),
      coin: 1000 + random.nextInt(9000),
    );
  }
}
