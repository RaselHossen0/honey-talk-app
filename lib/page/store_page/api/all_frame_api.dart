import 'dart:async';
import 'dart:math';

import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/store_page/model/all_store_item_model.dart';

class FetchAllFramesApi {
  static Future<AllStoreItemModel> callApi() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay

    List<AvatarFrame> generateItems(String prefix, int count) {
      return List.generate(count, (index) {
        final i = index + 1;
        return AvatarFrame(
          id: '${prefix}_$i',
          name: prefix == "theme"
              ? FakeProfilesSet().fakeThemename[Random().nextInt(FakeProfilesSet().fakeThemename.length)]
              : prefix == "ride"
                  ? FakeProfilesSet().fakeRidename[Random().nextInt(FakeProfilesSet().fakeRidename.length)]
                  : FakeProfilesSet().fakeFramename[Random().nextInt(FakeProfilesSet().fakeFramename.length)],
          type: prefix == "avatar"
              ? 0
              : prefix == "theme"
                  ? 1
                  : 2, // 0 = avatar, 1 = theme, 2 = ride
          image: prefix == "theme"
              ? FakeProfilesSet().fakeTheme[Random().nextInt(FakeProfilesSet().fakeTheme.length)]
              : prefix == "ride"
                  ? FakeProfilesSet().fakeRide[Random().nextInt(FakeProfilesSet().fakeRide.length)]
                  : FakeProfilesSet().fakeFrame[Random().nextInt(FakeProfilesSet().fakeFrame.length)],
          svgaImage: prefix == "theme"
              ? FakeProfilesSet().fakeTheme[Random().nextInt(FakeProfilesSet().fakeTheme.length)]
              : prefix == "ride"
                  ? FakeProfilesSet().fakeRide[Random().nextInt(FakeProfilesSet().fakeRide.length)]
                  : FakeProfilesSet().fakeFrame[Random().nextInt(FakeProfilesSet().fakeFrame.length)],
          coin: 100 * i,
          validity: i * 7,
          validityType: 1, // e.g., 1 = days
          createdAt: DateTime.now().subtract(Duration(days: i)),
          isPurchased: i % 2 == 0,
        );
      });
    }

    final data = Data(
      avatarFrames: generateItems("avatar", 5),
      themes: generateItems("theme", 3),
      rides: generateItems("ride", 4),
    );

    return AllStoreItemModel(
      status: true,
      message: "Dummy store items fetched successfully",
      data: data,
    );
  }
}
