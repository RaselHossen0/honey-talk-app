import 'dart:async';
import 'dart:math';

import 'package:tingle/page/fans_ranking_page/model/fetch_fans_ranking_model.dart'; // adjust import path if needed

class FetchFansRankingApi {
  static Future<FetchFansRankingModel?> callApi() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    final random = Random();

    // Random names, genders, and avatars
    final names = ['Alex', 'Taylor', 'Jordan', 'Casey', 'Morgan', 'Jamie', 'Riley', 'Avery', 'Charlie', 'Dakota'];
    final genders = ['Male', 'Female'];
    final wealthImages = ['wealth_1.png', 'wealth_2.png', 'wealth_3.png', 'wealth_4.png', 'wealth_5.png'];

    // Generate dummy list (5-10 users) for daily, weekly, monthly
    List<DailyWeeklyMonthlyCommonModel> generateRankingList() {
      return List.generate(5 + random.nextInt(6), (index) {
        final name = names[random.nextInt(names.length)];
        final gender = genders[random.nextInt(genders.length)];

        return DailyWeeklyMonthlyCommonModel(
          userId: 'user_${index + 1}',
          name: name,
          image: 'https://randomuser.me/api/portraits/${gender == 'Male' ? 'men' : 'women'}/${random.nextInt(50)}.jpg',
          isProfilePicBanned: random.nextDouble() < 0.1,
          gender: gender,
          age: 18 + random.nextInt(40),
          isVerified: random.nextBool(),
          wealthLevelImage: wealthImages[random.nextInt(wealthImages.length)],
          avtarFrame: 'frame_${random.nextInt(5) + 1}.png',
          avtarFrameType: random.nextInt(3),
          coin: 1000 + random.nextInt(100000),
        );
      });
    }

    return FetchFansRankingModel(
      status: true,
      message: 'Fans ranking fetched successfully',
      data: Data(
        daily: generateRankingList(),
        weekly: generateRankingList(),
        monthly: generateRankingList(),
      ),
    );
  }
}
