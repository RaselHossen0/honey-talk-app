import 'package:get/get.dart';
import 'package:tingle/page/theme_outfit_page/controller/theme_outfit_contoller.dart';

class ThemeOutfitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeOutfitController>(() => ThemeOutfitController());
  }
}
