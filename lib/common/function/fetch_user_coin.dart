import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_user_coin_api.dart';
import 'package:tingle/common/model/fetch_user_coin_model.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';

class FetchUserCoin {
  static RxInt coin = 0.obs;
  static FetchUserCoinModel? fetchUserCoinModel;
  static RxBool isLoading = false.obs;

  static Future<void> init() async {
    isLoading.value = true;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchUserCoinModel = await FetchUserCoinApi.callApi(token: token, uid: uid);

    if (fetchUserCoinModel?.coinBalance != null) {
      coin.value = fetchUserCoinModel?.coinBalance ?? 0;
      isLoading.value = false;
    }
  }
}
