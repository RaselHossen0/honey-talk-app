import 'dart:async';
import 'dart:math';

import 'package:tingle/page/create_reels_page/model/fetch_song_model.dart';

class FetchSongApi {
  static Future<FetchSongModel?> callApi() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    final random = Random();
    final now = DateTime.now();

    // Sample song titles and singers
    final songTitles = ['Tum Hi Ho', 'Sun Raha Hai', 'Channa Mereya', 'Raabta', 'Bekhayali', 'Shayad', 'Ghungroo', 'Tera Ban Jaunga'];
    final singers = ['Arijit Singh', 'Shreya Ghoshal', 'Armaan Malik', 'Arijit Singh', 'Sachet Tandon', 'Arijit Singh', 'Vishal-Shekhar', 'Akhil Sachdeva'];

    // Sample categories
    final categories = [
      {'name': 'Romantic', 'image': 'https://example.com/category_romantic.jpg'},
      {'name': 'Sad', 'image': 'https://example.com/category_sad.jpg'},
      {'name': 'Party', 'image': 'https://example.com/category_party.jpg'},
      {'name': 'Motivation', 'image': 'https://example.com/category_motivation.jpg'},
      {'name': 'Love', 'image': 'https://example.com/category_love.jpg'},
    ];

    // Generate dummy song list (10-20 songs)
    final songList = List.generate(10 + random.nextInt(10), (index) {
      final songIndex = random.nextInt(songTitles.length);
      final category = categories[random.nextInt(categories.length)];

      return SongData(
        id: 'song_${index + 1}',
        songTitle: songTitles[songIndex],
        songImage: 'https://example.com/song_${index + 1}.jpg',
        singerName: singers[songIndex],
        songLink: 'https://example.com/audio/song_${index + 1}.mp3',
        songTime: 180 + random.nextInt(120).toDouble(), // 3 to 5 mins
        createdAt: now.subtract(Duration(days: random.nextInt(60))).toIso8601String(),
        songCategoryName: category['name'],
        songCategoryImage: category['image'],
        isFavorite: random.nextBool(),
      );
    });

    return FetchSongModel(
      status: true,
      message: 'Songs fetched successfully',
      data: songList,
    );
  }
}
