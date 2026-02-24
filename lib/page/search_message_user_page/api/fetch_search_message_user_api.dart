import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/search_message_user_page/model/fetch_search_message_user_model.dart';

import 'dart:async';
import 'dart:math';

class FetchSearchMessageUserApi {
  static Future<FetchSearchMessageUserModel> callApi({
    required String uid,
    required String token,
    required String searchString,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final random = Random();

    List<Data> users = List.generate(10, (index) {
      final isOnline = random.nextBool();
      final isVerified = index % 3 == 0;
      final isFake = index % 5 == 0;

      return Data(
        id: "user_${index + 1}",
        name: FakeProfilesSet.sampleNames[index],
        userName: FakeProfilesSet.sampleNames[index],
        image: FakeProfilesSet.sampleImages[index],
        isProfilePicBanned: false,
        isFake: isFake,
        isVerified: isVerified,
        isOnline: isOnline,
        chatTopicId: "chat_topic_${index + 1}",
      );
    });

    return FetchSearchMessageUserModel(
      status: true,
      message: "Users fetched successfully",
      data: users,
    );
  }
}
