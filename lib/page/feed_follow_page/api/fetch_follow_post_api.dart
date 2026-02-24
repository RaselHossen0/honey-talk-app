import 'dart:async';
import 'dart:math';

import 'package:tingle/page/feed_page/model/fetch_post_model.dart'; // adjust if needed

class FetchFollowPostApi {
  static Future<FetchPostModel?> callApi() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    final random = Random();
    final now = DateTime.now();

    // Sample captions, hashtags, names
    final captions = ['Enjoying the sunset 🌅', 'Life is beautiful! 💫', 'Good vibes only ✌️', 'Dream big, work hard 🔥', 'Just chilling 😎'];
    final hashtags = ['#sunset', '#life', '#vibes', '#dream', '#chill'];
    final countries = ['India', 'USA', 'Germany', 'Japan', 'Brazil'];
    final countryFlags = ['🇮🇳', '🇺🇸', '🇩🇪', '🇯🇵', '🇧🇷'];
    final names = ['Alex', 'Taylor', 'Jordan', 'Casey', 'Morgan', 'Jamie'];

    // Generate dummy posts (10-20)
    final posts = List.generate(10 + random.nextInt(10), (index) {
      final name = names[random.nextInt(names.length)];
      final gender = random.nextBool() ? 'Male' : 'Female';
      final countryIndex = random.nextInt(countries.length);

      return Post(
        id: 'post_${index + 1}',
        caption: captions[random.nextInt(captions.length)],
        postImage: List.generate(
          1 + random.nextInt(2), // 1 or 2 images per post
          (imgIndex) => PostImage(
            url: 'https://picsum.photos/seed/${index + imgIndex}/400/400',
            isBanned: random.nextDouble() < 0.1,
            id: 'img_${index}_$imgIndex',
          ),
        ),
        shareCount: random.nextInt(100),
        isFake: random.nextBool(),
        createdAt: now.subtract(Duration(days: random.nextInt(30))).toIso8601String(),
        postId: 'postId_${index + 1}',
        hashTagId: List.generate(2, (i) => 'hashtagId_${random.nextInt(100)}'),
        hashTag: List.generate(2, (i) => hashtags[random.nextInt(hashtags.length)]),
        userId: 'user_${index + 1}',
        name: name,
        userName: '${name.toLowerCase()}${random.nextInt(100)}',
        gender: gender,
        age: 18 + random.nextInt(30),
        country: countries[countryIndex],
        countryFlagImage: countryFlags[countryIndex],
        userImage: 'https://randomuser.me/api/portraits/${gender == 'Male' ? 'men' : 'women'}/${random.nextInt(50)}.jpg',
        isProfilePicBanned: random.nextDouble() < 0.1,
        isVerified: random.nextDouble() < 0.3,
        userIsFake: random.nextDouble() < 0.1,
        isLike: random.nextBool(),
        isFollow: random.nextBool(),
        totalLikes: 100 + random.nextInt(5000),
        totalComments: random.nextInt(1000),
        time: "${random.nextInt(23)}h ago",
      );
    });

    return FetchPostModel(
      status: true,
      message: 'Followed posts fetched successfully',
      post: posts,
    );
  }
}
