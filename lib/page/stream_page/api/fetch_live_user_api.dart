import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchLiveUserApi {
  static Future<FetchLiveUserModel?> callApi({
    required String token,
    required String uid,
    required String liveType,
    required int startPage,
    String? country,
  }) async {
    Utils.showLog("Fetch Live User API Called");
    try {
      final query = <String, String>{};
      if (country != null && country.isNotEmpty) query['country'] = country;
      final res = await ApiClient.instance.get('/live', queryParameters: query);
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final liveUserList = list.map((m) {
        final user = m['user'] as Map<String, dynamic>?;
        return {
          '_id': m['id'],
          'userId': m['userId'],
          'name': user?['name'],
          'userName': user?['userName'],
          'image': user?['image'],
          'isProfilePicBanned': user?['isProfilePicBanned'],
          'countryFlagImage': user?['countryFlagImage'],
          'country': m['country'] ?? user?['country'],
          'isVerified': user?['isVerified'],
          'view': m['viewCount'],
          'hostIsMuted': m['hostIsMuted'],
          'channel': m['channel'],
          'token': m['token'],
          'liveType': m['liveType'],
          'isPkMode': m['isPkMode'],
          'videoUrl': m['videoUrl'],
          'streamSource': m['streamSource'],
          'isFake': m['isFake'],
          'audioLiveType': m['audioLiveType'],
          'privateCode': m['privateCode'],
          'agoraUid': m['agoraUid'],
          'roomName': m['roomName'],
          'roomWelcome': m['roomWelcome'],
          'roomImage': m['roomImage'],
          'isAudio': m['isAudio'],
          'liveHistoryId': m['id'],
          'host2Id': m['host2Id'],
          'uniqueId': user?['uniqueId'],
          'coin': user?['coin'],
          'wealthLevelImage': user?['wealthLevelImage'],
        };
      }).toList();
      return FetchLiveUserModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        liveUserList: liveUserList.map((m) => LiveUserList.fromJson(Map<String, dynamic>.from(m))).toList(),
      );
    } catch (e) {
      Utils.showLog("Fetch Live User API Error: $e");
      return null;
    }
  }
}
