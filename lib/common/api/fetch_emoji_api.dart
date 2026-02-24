import 'package:tingle/common/model/fetch_emoji_model.dart';
import 'package:tingle/utils/utils.dart';
import 'dart:async';

class FetchEmojiApi {
  static Future<FetchEmojiModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Mock Fetch Emoji API Called...");

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    // Create dummy emoji list
    List<EmojiData> dummyEmojis = List.generate(15, (index) {
      return EmojiData(
        id: "emoji_id_$index",
        title: "Emoji ${index + 1}",
        image: "https://example.com/emojis/emoji_${index % 5}.png",
      );
    });

    // Return dummy model
    return FetchEmojiModel(
      status: true,
      message: "Emoji list fetched successfully",
      data: dummyEmojis,
    );
  }
}
