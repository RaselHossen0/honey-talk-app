import 'dart:async';
import 'dart:math';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';

class FetchUserWisePostApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchPostModel> callApi({
    required String uid,
    required String token,
    required String toUserId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate network delay

    startPagination += 1;
    final random = Random();
    final now = DateTime.now();

    List<Post> generateDummyPosts(int count) {
      final hashtagsList = ['travel', 'foodie', 'fitness', 'love', 'instagood', 'music', 'fashion', 'art', 'nature'];
      final countryList = [
        {'name': 'India', 'flag': '🇮🇳'},
        {'name': 'United States', 'flag': '🇺🇸'},
        {'name': 'Germany', 'flag': '🇩🇪'},
        {'name': 'Japan', 'flag': '🇯🇵'},
        {'name': 'Australia', 'flag': '🇦🇺'},
      ];

      return List.generate(count, (index) {
        final hashtags = List.generate(2 + random.nextInt(3), (_) => hashtagsList[random.nextInt(hashtagsList.length)]);
        final country = countryList[random.nextInt(countryList.length)];
        final images = List.generate(
          1 + random.nextInt(3),
          (i) => PostImage(
            url: "https://picsum.photos/seed/${random.nextInt(1000)}/400/400",
            isBanned: false,
            id: 'img_${startPagination}_${index}_$i',
          ),
        );

        return Post(
          id: 'post_${startPagination}_${index + 1}',
          caption: 'This is a dummy post ${index + 1} with random vibes!',
          postImage: images,
          shareCount: random.nextInt(100),
          isFake: random.nextBool(),
          createdAt: now.subtract(Duration(days: random.nextInt(100))).toIso8601String(),
          postId: 'postId_${startPagination}_${index + 1}',
          hashTagId: hashtags.map((e) => 'tag_${e}_id').toList(),
          hashTag: hashtags,
          userId: toUserId,
          name: 'Dummy User',
          userName: 'dummy_user${index + 1}',
          gender: random.nextBool() ? 'male' : 'female',
          age: 18 + random.nextInt(30),
          country: country['name'],
          countryFlagImage: country['flag'],
          userImage: "https://randomuser.me/api/portraits/men/${random.nextInt(90)}.jpg",
          isProfilePicBanned: random.nextBool(),
          isVerified: random.nextBool(),
          userIsFake: random.nextBool(),
          isLike: random.nextBool(),
          isFollow: random.nextBool(),
          totalLikes: random.nextInt(1000),
          totalComments: random.nextInt(500),
          time: '${random.nextInt(59)} min ago',
        );
      });
    }

    return FetchPostModel(
      status: true,
      message: 'Dummy posts fetched successfully',
      post: generateDummyPosts(10 + random.nextInt(5)), // 10-14 posts
    );
  }
}
