import 'dart:async';
import 'dart:math';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';

class FetchUserWiseVideoApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchVideoModel> callApi({
    required String uid,
    required String token,
    required String toUserId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate network delay

    startPagination += 1;
    final random = Random();
    final now = DateTime.now();

    List<VideoData> generateDummyVideos(int count) {
      final hashtagsList = ['dance', 'funny', 'travel', 'music', 'vlog', 'tutorial', 'shorts'];
      final countryList = [
        {'name': 'India', 'flag': '🇮🇳'},
        {'name': 'United States', 'flag': '🇺🇸'},
        {'name': 'Germany', 'flag': '🇩🇪'},
        {'name': 'Japan', 'flag': '🇯🇵'},
        {'name': 'France', 'flag': '🇫🇷'},
      ];
      final songsList = [
        {'title': 'Shape of You', 'link': 'https://dummy.song/shape_of_you', 'image': 'https://picsum.photos/seed/song1/300/300'},
        {'title': 'Despacito', 'link': 'https://dummy.song/despacito', 'image': 'https://picsum.photos/seed/song2/300/300'},
        {'title': 'Blinding Lights', 'link': 'https://dummy.song/blinding_lights', 'image': 'https://picsum.photos/seed/song3/300/300'},
      ];

      return List.generate(count, (index) {
        final hashtags = List.generate(2 + random.nextInt(2), (_) => hashtagsList[random.nextInt(hashtagsList.length)]);
        final country = countryList[random.nextInt(countryList.length)];
        final song = songsList[random.nextInt(songsList.length)];

        return VideoData(
          id: 'video_${startPagination}_${index + 1}',
          songId: 'song_${index + 1}',
          caption: 'Enjoying the vibes with video ${index + 1}',
          videoTime: 30 + random.nextInt(120), // seconds
          videoImage: "https://picsum.photos/seed/video_${random.nextInt(1000)}/400/600",
          videoUrl: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_${random.nextInt(10)}.mp4",
          shareCount: random.nextInt(500),
          isFake: random.nextBool(),
          isBanned: false,
          createdAt: now.subtract(Duration(days: random.nextInt(30))).toIso8601String(),
          songTitle: song['title'],
          songImage: song['image'],
          songLink: song['link'],
          singerName: "Singer ${random.nextInt(50)}",
          hashTagId: hashtags.map((e) => 'tag_${e}_id').toList(),
          hashTag: hashtags,
          userId: toUserId,
          name: "Dummy User",
          userName: "dummy_user${index + 1}",
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
          totalLikes: random.nextInt(5000),
          totalComments: random.nextInt(1000),
          time: "${random.nextInt(59)} min ago",
        );
      });
    }

    return FetchVideoModel(
      status: true,
      message: "Dummy videos fetched successfully",
      data: generateDummyVideos(10 + random.nextInt(5)), // 10-14 videos
    );
  }
}
