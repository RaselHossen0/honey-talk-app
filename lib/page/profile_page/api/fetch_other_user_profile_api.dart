import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchOtherUserProfileApi {
  static Future<FetchUserProfileModel> callApi({
    required String token,
    required String uid,
    required String toUserId,
  }) async {
    try {
      final res = await ApiClient.instance.get('/users/$toUserId');
      if (res['id'] == null) {
        return FetchUserProfileModel(status: false, message: 'User not found', user: null);
      }
      final u = Map<String, dynamic>.from(res);
      u['_id'] = u['id'];
      if (u['wealthLevelObj'] != null) {
        final w = Map<String, dynamic>.from(u['wealthLevelObj'] as Map);
        w['_id'] = w['id'];
        u['wealthLevel'] = w;
      } else if (u['wealthLevelImage'] != null) {
        u['wealthLevel'] = {'_id': u['wealthLevel'], 'levelImage': u['wealthLevelImage']};
      }
      if (u['activeAvtarFrame'] != null) {
        final f = Map<String, dynamic>.from(u['activeAvtarFrame'] as Map);
        f['_id'] = f['id'];
        u['activeAvtarFrame'] = f;
      }
      final user = User.fromJson(u);
      return FetchUserProfileModel(
        status: true,
        message: 'Success',
        user: user,
      );
    } catch (e) {
      Utils.showLog("Fetch Other User Profile API Error: $e");
      return FetchUserProfileModel(status: false, message: e.toString(), user: null);
    }
  }
}
