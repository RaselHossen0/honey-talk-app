import 'dart:async';
import 'dart:math';

import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/store_page/model/top_frame_model.dart';

class FetchTopFramesApi {
  static Future<TopFramesModel> callApi() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 100));

    return TopFramesModel(
      status: true,
      message: "Top and recommended frames fetched successfully.",
      topFrames: List.generate(3, (index) {
        return Recommended(
          id: "frame_${index + 1}",
          name: "Top Frame ${index + 1}",
          image: FakeProfilesSet().fakeFrame[Random().nextInt(FakeProfilesSet().fakeFrame.length - 1)],
          coin: 100 + (index * 50),
          validity: 30,
          validityType: 0,
          isPurchased: true,
          itemType: ItemType.frame,
          svgaImage: "https://example.com/svga/top_frame_${index + 1}.svga",
          type: 2,
        );
      }),
      recommended: List.generate(10, (index) {
        return Recommended(
          id: "rec_frame_${index + 1}",
          name: "Frame ${index + 1}",
          image: FakeProfilesSet().fakeFrame[Random().nextInt(FakeProfilesSet().fakeFrame.length - 1)],
          coin: 200 + (index * 20),
          validity: 7 + index,
          validityType: 1,
          isPurchased: false,
          itemType: ItemType.frame,
          svgaImage: "https://example.com/svga/rec_frame_${index + 1}.svga",
          type: 2,
        );
      }),
    );
  }
}
