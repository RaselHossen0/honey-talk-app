import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/search_page/model/search_user_model.dart';

import 'dart:async';
import 'dart:math';

class SearchUserApi {
  static Future<SearchUserModel> callApi({
    required String token,
    required String uid,
    required String searchText,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    final random = Random();

    List<SearchUserData> users = List.generate(8, (index) {
      return SearchUserData(
        id: "user_${index + 1}",
        name: FakeProfilesSet.sampleNames[index],
        image: FakeProfilesSet.sampleImages[index],
        userName: FakeProfilesSet.sampleNames[index],
        age: 18 + random.nextInt(20),
        isProfilePicBanned: false,
        countryFlagImage: "🇮🇳",
        country: "India",
        uniqueId: "UID${index + 100}",
        coin: random.nextInt(10000),
        wealthLevel: "Level ${random.nextInt(5) + 1}",
        isFake: index % 4 == 0,
        isVerified: index % 3 == 0,
        isOnline: random.nextBool(),
        createdAt: DateTime.now().subtract(Duration(days: index)).toIso8601String(),
        isFollow: index % 2 == 0,
      );
    });

    return SearchUserModel(
      status: true,
      message: "Dummy users fetched successfully",
      searchData: users,
    );
  }
}
