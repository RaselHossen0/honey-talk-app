import 'package:get/get.dart';
import 'package:tingle/page/fans_ranking_page/controller/fans_ranking_controller.dart';

class FansRankingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FansRankingController>(() => FansRankingController());
  }
}
