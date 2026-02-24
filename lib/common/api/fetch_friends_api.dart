import 'dart:async';
import 'package:tingle/common/model/fetch_friends_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchFriendsApi {
  static Future<FetchFriendsModel?> callApi({required String uid, required String token}) async {
    Utils.showLog("Mock Fetch Friends API Called...");

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    // Dummy friends list
    List<Friends> dummyFriends = List.generate(10, (index) {
      return Friends(
        id: "friend_id_$index",
        name: "Friend Name $index",
        userName: "friend_username_$index",
        image: "https://example.com/users/friend_$index.jpg",
        isProfilePicBanned: false,
        isVerified: index % 2 == 0, // Alternate true/false
        age: 20 + index,
        uniqueId: "UNQFRIEND$index",
      );
    });

    // Return dummy model
    return FetchFriendsModel(
      success: true,
      message: "Friends fetched successfully",
      friends: dummyFriends,
    );
  }
}
