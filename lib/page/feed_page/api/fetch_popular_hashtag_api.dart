import 'package:tingle/page/feed_page/model/fetch_popular_hashtag_model.dart';

import 'dart:async';
import 'dart:math';

// adjust path if needed

class FetchPopularHashtagApi {
  static Future<FetchPopularHashtagModel?> callApi() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    final random = Random();

    // Sample hashtags
    final sampleHashtags = [
      'sunset',
      'life',
      'vibes',
      'dream',
      'chill',
      'travel',
      'music',
      'fitness',
      'love',
      'friends',
    ];

    // Generate dummy hashtags
    final hashtags = List.generate(sampleHashtags.length, (index) {
      return Hashtags(
        id: 'hashtag_${index + 1}',
        hashTag: '#${sampleHashtags[index]}',
        usageCount: 1000 + random.nextInt(90000), // 1K to 90K usage
      );
    });

    return FetchPopularHashtagModel(
      success: true,
      message: 'Popular hashtags fetched successfully',
      hashtags: hashtags,
    );
  }
}
