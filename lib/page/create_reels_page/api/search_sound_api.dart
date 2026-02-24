import 'dart:async';
import 'dart:math';

import 'package:tingle/page/create_reels_page/model/search_sound_model.dart'; // adjust path if needed

class SearchSoundApi {
  static Future<SearchSoundModel?> callApi({
    required String searchString,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    final random = Random();
    final now = DateTime.now();

    // Sample song data
    final songTitles = ['Tum Hi Ho', 'Sun Raha Hai', 'Raabta', 'Channa Mereya', 'Bekhayali', 'Shayad', 'Ghungroo', 'Tera Ban Jaunga'];
    final singers = ['Arijit Singh', 'Shreya Ghoshal', 'Armaan Malik', 'Arijit Singh', 'Sachet Tandon', 'Arijit Singh', 'Vishal-Shekhar', 'Akhil Sachdeva'];
    final categories = ['Romantic', 'Sad', 'Party', 'Motivation', 'Love'];

    // Filter dummy songs by searchString
    final filteredList = songTitles.asMap().entries.where((entry) => entry.value.toLowerCase().contains(searchString.toLowerCase())).map((entry) {
      int idx = entry.key;
      return SearchData(
        id: 'search_${idx + 1}',
        singerName: singers[idx % singers.length],
        songTitle: songTitles[idx],
        songLink: 'https://example.com/audio/song_${idx + 1}.mp3',
        songImage: 'https://example.com/song_${idx + 1}.jpg',
        songTime: 180 + random.nextInt(120).toDouble(),
        createdAt: now.subtract(Duration(days: random.nextInt(30))),
        songCategoryName: categories[random.nextInt(categories.length)],
        isFavorite: random.nextBool(),
      );
    }).toList();

    return SearchSoundModel(
      status: true,
      message: 'Songs fetched successfully',
      searchData: filteredList,
    );
  }
}
