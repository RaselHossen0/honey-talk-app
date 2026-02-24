import 'package:get/get.dart';
import 'package:tingle/page/theme_page/controller/theme_controller.dart';

class ThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}
