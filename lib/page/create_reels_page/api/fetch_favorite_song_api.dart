import 'package:tingle/page/create_reels_page/model/fetch_favorite_sound_model.dart';

import 'dart:async';
import 'dart:math';

class FetchFavoriteSongApi {
  static Future<FetchFavoriteSoundModel?> callApi() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    final random = Random();
    final now = DateTime.now();

    // Sample song titles and singers
    final songTitles = ['Tum Hi Ho', 'Sun Raha Hai', 'Bol Do Na Zara', 'Channa Mereya', 'Raabta', 'Bekhayali', 'Shayad'];
    final singers = ['Arijit Singh', 'Shreya Ghoshal', 'Armaan Malik', 'Arijit Singh', 'Arijit Singh', 'Sachet Tandon', 'Arijit Singh'];

    // Sample categories
    final categories = [
      {'id': 'cat_001', 'name': 'Romantic'},
      {'id': 'cat_002', 'name': 'Sad'},
      {'id': 'cat_003', 'name': 'Love'},
      {'id': 'cat_004', 'name': 'Party'},
      {'id': 'cat_005', 'name': 'Motivation'},
    ];

    // Generate dummy favorite songs (10–20 items)
    final favoriteSongs = List.generate(10 + random.nextInt(10), (index) {
      final songIndex = random.nextInt(songTitles.length);
      final category = categories[random.nextInt(categories.length)];

      return FavoriteSongs(
        id: 'fav_${"user"}_${index + 1}',
        userId: "userid_${Random.secure().nextInt(10000)}",
        songId: SongId(
          id: 'song_${index + 1}',
          singerName: singers[songIndex],
          songTitle: songTitles[songIndex],
          songLink: 'https://example.com/song_${index + 1}.mp3',
          songImage: 'https://example.com/song_${index + 1}.jpg',
          songCategoryId: SongCategoryId(
            id: category['id'],
            name: category['name'],
          ),
          songTime: 180 + random.nextInt(120).toDouble(), // 3 to 5 minutes
        ),
        createdAt: now.subtract(Duration(days: random.nextInt(60))).toIso8601String(),
        updatedAt: now.subtract(Duration(days: random.nextInt(30))).toIso8601String(),
      );
    });

    return FetchFavoriteSoundModel(
      status: true,
      message: 'Favorite songs fetched successfully',
      songs: favoriteSongs,
    );
  }
}
