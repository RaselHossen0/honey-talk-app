import 'package:get/get.dart';
import 'package:tingle/page/wealth_level_page/api/fetch_wealth_level_api.dart';
import 'package:tingle/page/wealth_level_page/model/fetch_wealth_level_model.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class WealthLevelController extends GetxController {
  bool isLoading = true;
  FetchWealthLevelModel? model;

  WealthLevelData? get data => model?.data;
  int get currentLevel => data?.currentLevel ?? 0;
  int get nextLevel => data?.nextLevel ?? 1;
  int get currentToken => data?.currentToken ?? 0;
  int get tokenToNextLevel => data?.tokenToNextLevel ?? 0;
  List<WealthRewardTier> get rewardTiers => data?.rewardTiers ?? [];
  List<WealthLevelRule> get levelRules => data?.levelRules ?? [];

  double get progress {
    final total = currentToken + tokenToNextLevel;
    if (total <= 0) return 0;
    return (currentToken / total).clamp(0.0, 1.0);
  }

  @override
  void onInit() {
    final gender = (Database.fetchLoginUserProfile()?.user?.gender ?? '').toLowerCase();
    if (gender == 'female') {
      Get.back();
      Utils.showToast(text: 'Wealth Level is only available for male users.');
      return;
    }
    init();
    super.onInit();
  }

  Future<void> init() async {
    isLoading = true;
    update([AppConstant.onGetFeed]);
    model = await FetchWealthLevelApi.callApi();
    isLoading = false;
    update([AppConstant.onGetFeed]);
  }

}
