import 'dart:async';
import 'package:tingle/page/upload_feed_page/model/fetch_all_hashtag_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchAllHashtagApi {
  static Future<FetchAllHashtagModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Mock Fetch All Hashtag API Called (Proper realistic data)");

    await Future.delayed(const Duration(milliseconds: 100));

    return FetchAllHashtagModel(
      status: true,
      message: "Hashtags fetched successfully",
      data: [
        Data(sId: "tag_001", hashTag: "#love"),
        Data(sId: "tag_002", hashTag: "#travel"),
        Data(sId: "tag_003", hashTag: "#music"),
        Data(sId: "tag_004", hashTag: "#fitness"),
        Data(sId: "tag_005", hashTag: "#nature"),
        Data(sId: "tag_006", hashTag: "#fashion"),
        Data(sId: "tag_007", hashTag: "#photography"),
        Data(sId: "tag_008", hashTag: "#friends"),
        Data(sId: "tag_009", hashTag: "#selfie"),
        Data(sId: "tag_010", hashTag: "#summer"),
        Data(sId: "tag_011", hashTag: "#motivation"),
        Data(sId: "tag_012", hashTag: "#life"),
        Data(sId: "tag_013", hashTag: "#explore"),
        Data(sId: "tag_014", hashTag: "#happy"),
        Data(sId: "tag_015", hashTag: "#health"),
      ],
    );
  }
}
