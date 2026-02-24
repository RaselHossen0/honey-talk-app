import 'package:tingle/common/model/fetch_gift_gallery_model.dart';
import 'package:tingle/utils/utils.dart';

import 'dart:async';

class FetchGiftGalleryApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchGiftGalleryModel?> callApi({
    required String uid,
    required String token,
    required String userId,
  }) async {
    Utils.showLog("Mock Fetch Gift Gallery API Calling...");

    await Future.delayed(const Duration(milliseconds: 100)); // Simulate API delay

    List<Data> dummyGiftGallery = List.generate(
        8,
        (index) => Data(
              id: "giftGalleryId_$index",
              totalGiftCount: 5 + index,
              latestDate: "2025-04-${10 + index}T12:34:56Z",
              giftId: "gift_$index",
              giftTitle: "Gift Title #$index",
              giftImage: "https://example.com/images/gift_$index.png",
              giftCoin: 100 * (index + 1),
              giftType: index % 2, // 0 or 1
            ));

    return FetchGiftGalleryModel(
      status: true,
      message: "Gift Gallery fetched successfully",
      data: dummyGiftGallery,
    );
  }
}
