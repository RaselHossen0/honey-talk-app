import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchUserWiseVideoApi {
  static Future<FetchVideoModel?> callApi({
    required String uid,
    required String token,
    required String toUserId,
  }) async {
    Utils.showLog("Fetch User Wise Video API Calling...");
    try {
      final res = await ApiClient.instance.get('/videos/user/$toUserId');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final data = <VideoData>[];
      for (var i = 0; i < list.length; i++) {
        final v = list[i];
        final user = v['user'] as Map<String, dynamic>?;
        final song = v['song'] as Map<String, dynamic>?;
        final m = Map<String, dynamic>.from(v);
        m['_id'] = m['id'];
        m['userId'] = v['userId'] ?? user?['id'];
        m['name'] = user?['name'];
        m['userName'] = user?['userName'];
        m['gender'] = user?['gender'];
        m['age'] = user?['age'];
        m['country'] = user?['country'];
        m['countryFlagImage'] = user?['countryFlagImage'];
        m['userImage'] = user?['image'];
        m['isProfilePicBanned'] = user?['isProfilePicBanned'];
        m['isVerified'] = user?['isVerified'];
        m['songTitle'] = song?['title'];
        m['songImage'] = song?['image'];
        m['songLink'] = song?['link'];
        m['singerName'] = song?['singerName'];
        data.add(VideoData.fromJson(m));
      }
      return FetchVideoModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: data,
      );
    } catch (e) {
      Utils.showLog("Fetch User Wise Video API Error: $e");
      return null;
    }
  }
}
