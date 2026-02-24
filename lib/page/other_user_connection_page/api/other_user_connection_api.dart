import 'dart:async';
import 'dart:math';
import 'package:tingle/page/other_user_connection_page/model/other_user_connection_model.dart';

class FetchOtherUserConnectionApi {
  static int startPagination = 1;
  static int limitPagination = 20;

  static Future<FetchOtherUserConnectionModel> callApi({
    required String uid,
    required String token,
    required String userId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

    startPagination += 1;

    final random = Random();
    final now = DateTime.now();

    // Helper function to generate dummy followers/friends/following
    List<Follower> generateDummyUsers(int count, {bool isFriend = false}) {
      final countries = [
        {'name': 'United States', 'flag': '🇺🇸'},
        {'name': 'India', 'flag': '🇮🇳'},
        {'name': 'Brazil', 'flag': '🇧🇷'},
        {'name': 'Germany', 'flag': '🇩🇪'},
        {'name': 'Japan', 'flag': '🇯🇵'},
      ];

      return List.generate(count, (index) {
        final country = countries[random.nextInt(countries.length)];
        final joinDate = now.subtract(Duration(days: random.nextInt(365)));

        return Follower(
          id: 'user_${startPagination}_${index + 1}',
          name: 'User ${index + 1}',
          userName: 'user${random.nextInt(99999)}',
          image: 'https://randomuser.me/api/portraits/men/${random.nextInt(90)}.jpg',
          isProfilePicBanned: random.nextBool(),
          age: 18 + random.nextInt(30),
          isVerified: random.nextBool(),
          country: country['name'],
          countryFlagImage: country['flag'],
          coin: random.nextInt(5000),
          uniqueId: 'unique_${random.nextInt(100000)}',
          isOnline: random.nextBool(),
          date: joinDate,
          wealthLevelImage: 'wealth_${random.nextInt(5) + 1}.png',
          isFollow: isFriend ? true : random.nextBool(),
        );
      });
    }

    return FetchOtherUserConnectionModel(
      status: true,
      message: 'Dummy other user connections fetched successfully',
      friends: generateDummyUsers(5 + random.nextInt(5), isFriend: true), // 5 to 10 friends
      following: generateDummyUsers(8 + random.nextInt(5)), // 8 to 12 following
      followers: generateDummyUsers(10 + random.nextInt(5)), // 10 to 15 followers
    );
  }
}
