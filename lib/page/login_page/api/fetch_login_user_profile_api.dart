import 'dart:convert';

import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/login_page/model/fetch_login_user_profile_model.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class FetchLoginUserProfileApi {
  static FetchLoginUserProfileModel? fetchLoginUserProfileModel;

  static Future<void> callApi({required String token, required String uid}) async {
    Utils.showLog("Get Login User Profile API Calling...");
    try {
      final res = await ApiClient.instance.get('/users/me');
      if (res['id'] == null) {
        Utils.showLog("Get Login User Profile API: no user");
        return;
      }
      final u = Map<String, dynamic>.from(res);
      u['_id'] = u['id'];
      if (u['activeAvtarFrame'] != null) {
        final f = Map<String, dynamic>.from(u['activeAvtarFrame'] as Map);
        f['_id'] = f['id'];
        u['activeAvtarFrame'] = f;
      }
      if (u['activeTheme'] != null) {
        final t = Map<String, dynamic>.from(u['activeTheme'] as Map);
        t['_id'] = t['id'];
        u['activeTheme'] = t;
      }
      if (u['activeRide'] != null) {
        final r = Map<String, dynamic>.from(u['activeRide'] as Map);
        r['_id'] = r['id'];
        u['activeRide'] = r;
      }
      fetchLoginUserProfileModel = FetchLoginUserProfileModel(
        status: true,
        message: 'Success',
        user: MyUser.fromJson(u),
      );
      await Database.onSetLoginUserProfile(jsonEncode(fetchLoginUserProfileModel!.toJson()));
      Utils.showLog("Login User Profile Saved Successfully");
    } catch (e) {
      Utils.showLog("Get Login User Profile API Error: $e");
      fetchLoginUserProfileModel = null;
    }
  }
}
