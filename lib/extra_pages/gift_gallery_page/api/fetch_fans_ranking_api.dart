import 'dart:async';
import 'package:tingle/page/fans_ranking_page/model/fetch_fans_ranking_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchFansRankingApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchFansRankingModel?> callApi({required String uid, required String token}) async {
    Utils.showLog("Mock Fetch Fans Ranking API Called...");

    await Future.delayed(const Duration(milliseconds: 100));

    List<DailyWeeklyMonthlyCommonModel> generateDummyFans(String type) {
      return List.generate(10, (index) {
        return DailyWeeklyMonthlyCommonModel(
          userId: "${type}_user_$index",
          name: "${type.toUpperCase()} User $index",
          image: "https://example.com/images/user_${type}_$index.jpg",
          isProfilePicBanned: false,
          gender: index % 2 == 0 ? "male" : "female",
          age: 20 + index,
          isVerified: index % 2 == 0,
          wealthLevelImage: "https://example.com/wealth/level_${index % 5}.png",
          avtarFrame: "https://example.com/frames/frame_${index % 3}.png",
          avtarFrameType: index % 2,
          coin: 1000 + (index * 100),
        );
      });
    }

    Data dummyData = Data(
      daily: generateDummyFans('daily'),
      weekly: generateDummyFans('weekly'),
      monthly: generateDummyFans('monthly'),
    );

    return FetchFansRankingModel(
      status: true,
      message: "Fans ranking fetched successfully",
      data: dummyData,
    );
  }
}
