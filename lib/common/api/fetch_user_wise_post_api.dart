import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/utils/utils.dart';
import 'dart:async';

class FetchUserWisePostApi {
  static Future<FetchPostModel?> callApi({required String uid, required String token, required String toUserId}) async {
    Utils.showLog("Mock Fetch User Wise Post API Calling...");

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return dummy data
    return FetchPostModel(
      status: true,
      message: "User posts fetched successfully",
      post: [
        Post(
          id: "post_001",
          caption: "Sunsets are proof that no matter what happens, every day can end beautifully 🌅.",
          postImage: [
            PostImage(
              url: "https://example.com/images/sunset1.jpg",
              isBanned: false,
              id: "img_001",
            ),
          ],
          shareCount: 5,
          isFake: false,
          createdAt: "2025-04-29T18:30:00Z",
          postId: "p001",
          hashTagId: ["hashtag1", "hashtag2"],
          hashTag: ["#sunset", "#nature"],
          userId: "user_123",
          name: "Aryan Sharma",
          userName: "aryan_s",
          gender: "male",
          age: 25,
          country: "India",
          countryFlagImage: "🇮🇳",
          userImage: "https://example.com/profiles/aryan.jpg",
          isProfilePicBanned: false,
          isVerified: true,
          userIsFake: false,
          isLike: true,
          isFollow: true,
          totalLikes: 320,
          totalComments: 45,
          time: "3 hours ago",
        ),
        Post(
          id: "post_002",
          caption: "Workout time! 💪🏋️‍♂️ Stay fit, stay healthy.",
          postImage: [
            PostImage(
              url: "https://example.com/images/workout1.jpg",
              isBanned: false,
              id: "img_002",
            ),
          ],
          shareCount: 8,
          isFake: false,
          createdAt: "2025-04-29T10:00:00Z",
          postId: "p002",
          hashTagId: ["fitness", "motivation"],
          hashTag: ["#workout", "#fitnessgoals"],
          userId: "user_123",
          name: "Aryan Sharma",
          userName: "aryan_s",
          gender: "male",
          age: 25,
          country: "India",
          countryFlagImage: "🇮🇳",
          userImage: "https://example.com/profiles/aryan.jpg",
          isProfilePicBanned: false,
          isVerified: true,
          userIsFake: false,
          isLike: false,
          isFollow: true,
          totalLikes: 150,
          totalComments: 20,
          time: "6 hours ago",
        ),
      ],
    );
  }
}
