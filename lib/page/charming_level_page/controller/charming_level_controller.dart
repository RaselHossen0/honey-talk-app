import 'package:get/get.dart';
import 'package:tingle/page/charming_level_page/api/fetch_charming_level_api.dart';
import 'package:tingle/page/charming_level_page/model/fetch_charming_level_model.dart';
import 'package:tingle/utils/constant.dart';

class CharmingLevelController extends GetxController {
  bool isLoading = true;
  FetchCharmingLevelModel? model;

  CharmingLevelData? get data => model?.data;
  int get currentLevel => data?.currentLevel ?? 0;
  int get nextLevel => data?.nextLevel ?? 1;
  int get currentBonus => data?.currentBonus ?? 0;
  int get bonusToNextLevel => data?.bonusToNextLevel ?? 0;
  List<LevelRewardTier> get rewardTiers => data?.rewardTiers ?? [];
  List<LevelRule> get levelRules => data?.levelRules ?? [];

  double get progress {
    final total = currentBonus + bonusToNextLevel;
    if (total <= 0) return 0;
    return (currentBonus / total).clamp(0.0, 1.0);
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    isLoading = true;
    update([AppConstant.onGetFeed]);
    model = await FetchCharmingLevelApi.callApi();
    isLoading = false;
    update([AppConstant.onGetFeed]);
  }
}
