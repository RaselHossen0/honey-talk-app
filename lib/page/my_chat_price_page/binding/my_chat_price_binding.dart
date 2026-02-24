import 'package:get/get.dart';
import 'package:tingle/page/my_chat_price_page/controller/my_chat_price_controller.dart';

class MyChatPriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyChatPriceController>(() => MyChatPriceController());
  }
}
