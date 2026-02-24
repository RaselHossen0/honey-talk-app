import 'package:get/get.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';

class RankingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankingController>(() => RankingController());
  }
}
