import 'package:get/get.dart';
import 'package:tingle/page/search_message_user_page/controller/search_message_user_controller.dart';

class SearchMessageUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMessageUserController>(() => SearchMessageUserController());
  }
}
