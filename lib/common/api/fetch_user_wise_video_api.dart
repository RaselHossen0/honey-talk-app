import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
import 'package:tingle/utils/utils.dart';

import 'dart:async';

class FetchUserWiseVideoApi {
  static Future<FetchVideoModel?> callApi({required String uid, required String token, required String toUserId}) async {
    Utils.showLog("Mock Fetch User Wise Video API Calling...");

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return dummy data
    return FetchVideoModel(
      status: true,
      message: "User videos fetched successfully",
      data: [
        VideoData(
          id: "video_001",
          caption: "Exploring the mountains 🏔️ #adventure",
          videoTime: 45,
          videoImage: "https://example.com/thumbnails/mountain.jpg",
          videoUrl: "https://example.com/videos/mountain.mp4",
          shareCount: 20,
          isFake: false,
          isBanned: false,
          createdAt: "2025-04-29T10:00:00Z",
          songTitle: "Mountain Echo",
          songImage: "https://example.com/songs/mountain_song.jpg",
          songLink: "https://example.com/songs/mountain_song.mp3",
          singerName: "Nature Beats",
          hashTagId: ["adventure", "nature"],
          hashTag: ["#adventure", "#nature"],
          userId: "user_101",
          name: "Kavya Patel",
          userName: "kavya_explorer",
          gender: "female",
          age: 24,
          country: "India",
          countryFlagImage: "🇮🇳",
          userImage: "https://example.com/profiles/kavya.jpg",
          isProfilePicBanned: false,
          isVerified: true,
          userIsFake: false,
          isLike: true,
          isFollow: true,
          totalLikes: 520,
          totalComments: 87,
          time: "2 hours ago",
        ),
        VideoData(
          id: "video_002",
          caption: "Dance like nobody’s watching 💃🕺",
          videoTime: 30,
          videoImage: "https://example.com/thumbnails/dance.jpg",
          videoUrl: "https://example.com/videos/dance.mp4",
          shareCount: 15,
          isFake: false,
          isBanned: false,
          createdAt: "2025-04-29T12:30:00Z",
          songTitle: "Dance Beats",
          songImage: "https://example.com/songs/dance_song.jpg",
          songLink: "https://example.com/songs/dance_song.mp3",
          singerName: "DJ Flex",
          hashTagId: ["dance", "fun"],
          hashTag: ["#dance", "#fun"],
          userId: "user_101",
          name: "Kavya Patel",
          userName: "kavya_explorer",
          gender: "female",
          age: 24,
          country: "India",
          countryFlagImage: "🇮🇳",
          userImage: "https://example.com/profiles/kavya.jpg",
          isProfilePicBanned: false,
          isVerified: true,
          userIsFake: false,
          isLike: false,
          isFollow: true,
          totalLikes: 410,
          totalComments: 65,
          time: "1 hour ago",
        ),
      ],
    );
  }
}
