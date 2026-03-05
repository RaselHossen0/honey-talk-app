import 'package:tingle/common/api/fetch_user_wise_post_api.dart' as common;
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';

class FetchUserWisePostApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchPostModel> callApi({
    required String uid,
    required String token,
    required String toUserId,
  }) async {
    final model = await common.FetchUserWisePostApi.callApi(
      uid: uid,
      token: token,
      toUserId: toUserId,
    );
    return model ?? FetchPostModel(status: false, message: 'Failed to load posts', post: []);
  }
}
