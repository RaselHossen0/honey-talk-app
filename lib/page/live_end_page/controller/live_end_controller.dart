import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/page/live_end_page/model/live_end_args.dart';
import 'package:tingle/page/message_page/api/fetch_live_female_api.dart';
import 'package:tingle/page/message_page/model/fetch_live_female_model.dart';
import 'package:tingle/utils/database.dart';

class LiveEndController extends GetxController {
  LiveEndArgs? args;
  List<LiveFemaleData> suggestedLives = [];
  bool isLoading = true;

  @override
  void onInit() {
    args = Get.arguments is LiveEndArgs ? Get.arguments : null;
    fetchSuggestedLives();
    super.onInit();
  }

  String get durationFormatted {
    final mins = args?.liveDurationMinutes ?? 0;
    final h = mins ~/ 60;
    final m = mins % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  Future<void> fetchSuggestedLives() async {
    isLoading = true;
    update();
    try {
      final token = await FirebaseAccessToken.onGet() ?? '';
      final uid = Database.loginUserId;
      final model = await FetchLiveFemaleApi.callApi(token: token, uid: uid);
      suggestedLives = model.data ?? [];
    } catch (_) {
      suggestedLives = [];
    }
    isLoading = false;
    update();
  }

  void onBack() => Get.back();
}
