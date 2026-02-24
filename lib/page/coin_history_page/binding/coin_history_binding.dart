import 'package:get/get.dart';
import 'package:tingle/page/coin_history_page/controller/coin_history_controller.dart';

class CoinHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoinHistoryController>(() => CoinHistoryController());
  }
}
