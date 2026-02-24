import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';

import 'dart:async';
import 'dart:math';

class FetchVideoApi {
  static Future<FetchVideoModel?> callApi() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    final random = Random();
    final now = DateTime.now();

    // Sample data
    final captions = [
      'Sunset vibes 🌅',
      'Life in motion 🎥',
      'Dream big, hustle harder 💪',
      'Lost in the music 🎶',
      'Nature is calling 🌳',
    ];
    final songTitles = ['Tum Hi Ho', 'Bekhayali', 'Raabta', 'Channa Mereya', 'Shayad'];
    final singers = ['Arijit Singh', 'Sachet Tandon', 'Pritam', 'Arijit Singh', 'Arijit Singh'];
    final hashtags = ['#sunset', '#life', '#dream', '#music', '#nature'];
    final names = ['Alex', 'Taylor', 'Jordan', 'Casey', 'Morgan'];
    final countries = ['India', 'USA', 'Japan', 'Germany', 'Brazil'];
    final countryFlags = ['🇮🇳', '🇺🇸', '🇯🇵', '🇩🇪', '🇧🇷'];

    // Generate dummy videos (10-20 videos)
    final videos = List.generate(10 + random.nextInt(10), (index) {
      final name = names[random.nextInt(names.length)];
      final gender = random.nextBool() ? 'Male' : 'Female';
      final countryIndex = random.nextInt(countries.length);
      final songIndex = random.nextInt(songTitles.length);

      return VideoData(
        id: 'video_${index + 1}',
        songId: 'song_${index + 1}',
        caption: captions[random.nextInt(captions.length)],
        videoTime: 10 + random.nextInt(120), // seconds
        videoImage: 'https://picsum.photos/seed/video${index + 1}/400/600',
        videoUrl: index % 2 == 0
            ? "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
            : 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        shareCount: random.nextInt(500),
        isFake: random.nextBool(),
        isBanned: random.nextBool(),
        createdAt: now.subtract(Duration(days: random.nextInt(30))).toIso8601String(),
        songTitle: songTitles[songIndex],
        songImage: 'https://picsum.photos/seed/song${index + 1}/300/300',
        songLink: 'https://sample-videos.com/audio/mp3/crowd-cheering.mp3',
        singerName: singers[songIndex],
        hashTagId: List.generate(2, (i) => 'hashtagId_${random.nextInt(100)}'),
        hashTag: List.generate(2, (i) => hashtags[random.nextInt(hashtags.length)]),
        userId: 'user_${index + 1}',
        name: name,
        userName: '${name.toLowerCase()}${random.nextInt(100)}',
        gender: gender,
        age: 18 + random.nextInt(30),
        country: countries[countryIndex],
        countryFlagImage: countryFlags[countryIndex],
        userImage: 'https://randomuser.me/api/portraits/${gender == 'Male' ? 'men' : 'women'}/${random.nextInt(60)}.jpg',
        isProfilePicBanned: random.nextDouble() < 0.1,
        isVerified: random.nextDouble() < 0.3,
        userIsFake: random.nextDouble() < 0.1,
        isLike: random.nextBool(),
        isFollow: random.nextBool(),
        totalLikes: 100 + random.nextInt(5000),
        totalComments: random.nextInt(500),
        time: "${random.nextInt(24)}h ago",
      );
    });

    return FetchVideoModel(
      status: true,
      message: 'Videos fetched successfully',
      data: videos,
    );
  }
}
