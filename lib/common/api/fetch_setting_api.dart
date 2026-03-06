import 'dart:convert';

import 'package:tingle/common/model/fetch_setting_model.dart';
import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class FetchSettingApi {
  static FetchSettingModel? fetchSettingModel;

  static Future<void> callApi({required String uid, required String token}) async {
    Utils.showLog("Fetch Setting API Calling...");
    try {
      final res = await ApiClient.instance.get('/settings');
      fetchSettingModel = FetchSettingModel.fromJson(Map<String, dynamic>.from(res));
      if (fetchSettingModel?.data != null) {
        await Database.onSetAdminSetting(jsonEncode(fetchSettingModel!.toJson()));
        final agoraId = fetchSettingModel!.data?.agoraAppId;
        if (agoraId != null && agoraId.isNotEmpty) {
          Utils.agoraAppId = agoraId;
          Utils.showLog("Agora App ID set from settings");
        }
        if (fetchSettingModel!.data?.isRazorpayEnabled == true &&
            (fetchSettingModel!.data?.razorPayId ?? '').isNotEmpty) {
          Utils.razorpayTestKey = fetchSettingModel!.data!.razorPayId!;
          Utils.showLog("Razorpay key set from settings");
        }
      }
      Utils.showLog("Settings fetched successfully!");
    } catch (e) {
      Utils.showLog("Fetch Setting API Error: $e");
      fetchSettingModel = null;
    }
  }
}
