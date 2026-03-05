import 'package:tingle/common/api/fetch_user_wise_video_api.dart' as common;
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';

class FetchUserWiseVideoApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchVideoModel> callApi({
    required String uid,
    required String token,
    required String toUserId,
  }) async {
    final model = await common.FetchUserWiseVideoApi.callApi(
      uid: uid,
      token: token,
      toUserId: toUserId,
    );
    return model ?? FetchVideoModel(status: false, message: 'Failed to load videos', data: []);
  }
}
