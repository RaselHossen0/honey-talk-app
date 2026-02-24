import 'package:tingle/page/feed_page/model/fetch_post_model.dart';

import 'dart:async';
import 'dart:math';

class FetchPostApi {
  static Future<FetchPostModel?> callApi() async {
    await Future.delayed(const Duration(milliseconds: 100));

    final random = Random();
    final now = DateTime.now();

    // Dummy sample data
    final captions = [
      'Life is beautiful 🌟',
      'Living my best life 🌈',
      'Adventure awaits 🚀',
      'Sunset vibes 🌅',
      'Dream big and dare to fail ✨',
    ];
    final hashtags = ['#life', '#travel', '#dream', '#sunset', '#vibes'];
    final names = ['Alex', 'Taylor', 'Jordan', 'Casey', 'Morgan'];
    final countries = ['India', 'USA', 'Japan', 'Germany', 'Brazil'];
    final countryFlags = ['🇮🇳', '🇺🇸', '🇯🇵', '🇩🇪', '🇧🇷'];

    // Generate dummy posts (10–20 posts)
    final posts = List.generate(10 + random.nextInt(10), (index) {
      final name = names[random.nextInt(names.length)];
      final gender = random.nextBool() ? 'Male' : 'Female';
      final countryIndex = random.nextInt(countries.length);

      return Post(
        id: 'post_${index + 1}',
        caption: captions[random.nextInt(captions.length)],
        postImage: List.generate(
          1 + random.nextInt(2),
          (imgIndex) => PostImage(
            url: 'https://picsum.photos/seed/${index + imgIndex}/400/400',
            isBanned: random.nextDouble() < 0.1,
            id: 'img_${index}_$imgIndex',
          ),
        ),
        shareCount: random.nextInt(500),
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
        totalComments: random.nextInt(500),
        time: "${random.nextInt(23)}h ago",
      );
    });

    return FetchPostModel(
      status: true,
      message: 'Posts fetched successfully',
      post: posts,
    );
  }
}
