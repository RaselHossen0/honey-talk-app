// ignore_for_file: file_names
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/connection_page/model/fetch_following_follower_model.dart';
import 'dart:math';

class FetchGetSocialListsApi {
  static Future<FollowerFollowingModel?> callApi() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    // Generate dummy data
    final random = Random();
    final now = DateTime.now();

    // Helper function to generate followers/following/friends
    List<Follower> generateUsers(int count, {bool isFriend = false}) {
      final countries = [
        {'name': 'United States', 'code': 'US', 'flag': '🇺🇸'},
        {'name': 'India', 'code': 'IN', 'flag': '🇮🇳'},
        {'name': 'Brazil', 'code': 'BR', 'flag': '🇧🇷'},
        {'name': 'Germany', 'code': 'DE', 'flag': '🇩🇪'},
        {'name': 'Japan', 'code': 'JP', 'flag': '🇯🇵'},
      ];

      return List.generate(count, (index) {
        final country = countries[random.nextInt(countries.length)];
        final joinDate = now.subtract(Duration(days: random.nextInt(365)));

        return Follower(
          id: 'user_${1023}_${index + 1}',
          name: FakeProfilesSet.sampleNames[index],
          userName: FakeProfilesSet.sampleNames[index],
          image: FakeProfilesSet.sampleImages[index],
          isProfilePicBanned: false, // 10% chance
          age: 18 + random.nextInt(50),
          isVerified: random.nextDouble() < 0.3, // 30% chance
          country: country['name'],
          countryFlagImage: country['flag'],
          coin: random.nextInt(10000),
          uniqueId: 'unique_${random.nextInt(10000)}',
          isOnline: random.nextBool(),
          date: joinDate,
          wealthLevelImage: 'wealth_level_${random.nextInt(5) + 1}.png',
          isFollow: isFriend ? true : random.nextBool(),
        );
      });
    }

    return FollowerFollowingModel(
      status: true,
      message: 'Social lists fetched successfully',
      friends: generateUsers(10 + random.nextInt(5), isFriend: true),
      following: generateUsers(10 + random.nextInt(5)),
      followers: generateUsers(10 + random.nextInt(5)),
    );
  }
}
