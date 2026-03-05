import 'package:tingle/common/model/fatch_other_user_profile_model.dart';
import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

class FetchOtherUserProfileInfoApi {
  static OtherUserProfileModel? otherUserProfileModel;

  static Future<OtherUserProfileModel?> callApi({
    required String token,
    required String uid,
    required String toUserId,
  }) async {
    Utils.showLog("Fetch Other User Profile Info API Called...");
    try {
      final res = await ApiClient.instance.get('/users/$toUserId');
      if (res['id'] == null) {
        otherUserProfileModel = null;
        return null;
      }
      final u = Map<String, dynamic>.from(res);
      u['_id'] = u['id'];
      u['receivedGifts'] = u['receivedGifts'] ?? 0;
      if (u['wealthLevelObj'] != null) {
        final w = Map<String, dynamic>.from(u['wealthLevelObj'] as Map);
        w['_id'] = w['id'];
        u['wealthLevel'] = w;
      } else if (u['wealthLevelImage'] != null) {
        u['wealthLevel'] = {'_id': u['wealthLevel'], 'levelImage': u['wealthLevelImage']};
      }
      otherUserProfileModel = OtherUserProfileModel(
        status: true,
        message: 'Success',
        user: User.fromJson(u),
      );
      return otherUserProfileModel;
    } catch (e) {
      Utils.showLog("Fetch Other User Profile Info API Error: $e");
      otherUserProfileModel = null;
      return null;
    }
  }
}
