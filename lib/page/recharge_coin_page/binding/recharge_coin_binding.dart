import 'package:get/get.dart';
import 'package:tingle/page/recharge_coin_page/controller/recharge_coin_controller.dart';

class RechargeCoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechargeCoinController>(() => RechargeCoinController());
  }
}
