import 'dart:async';
import 'package:tingle/page/audio_wise_videos_page/model/fetch_audio_wise_videos_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchAudioWiseVideosApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchAudioWiseVideosModel?> callApi({
    required String token,
    required String uid,
    required String songId,
  }) async {
    Utils.showLog("Mock Fetch Audio Wise Videos API Called...");

    await Future.delayed(const Duration(milliseconds: 100));

    List<Videos> dummyVideos = List.generate(10, (index) {
      return Videos(
        id: "vid_$index",
        caption: "Enjoying the vibes #musiclife $index",
        videoUrl: "https://example.com/videos/video_$index.mp4",
        videoImage: "https://example.com/thumbnails/thumb_$index.jpg",
        songId: songId,
        isBanned: false,
        createdAt: DateTime.now().toIso8601String(),
        totalLikes: 100 + index * 15,
        isLike: index % 2 == 0,
        totalComments: 20 + index * 5,
        totalViews: 500 + index * 50,
        songTitle: "Top Hit Song $index",
        songImage: "https://example.com/songs/song_$index.jpg",
        songLink: "https://example.com/songs/song_link_$index.mp3",
        singerName: "Singer $index",
        hashTag: ["#music", "#fun", "#trending"],
        userId: "user_$index",
        isProfileImageBanned: false,
        name: "User $index",
        userName: "user_$index",
        userImage: "https://example.com/users/user_$index.jpg",
        userIsFake: index % 3 == 0,
      );
    });

    return FetchAudioWiseVideosModel(
      status: true,
      message: "Audio wise videos fetched successfully",
      totalVideosOfSong: dummyVideos.length,
      videos: dummyVideos,
    );
  }
}
