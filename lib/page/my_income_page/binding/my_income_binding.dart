import 'package:get/get.dart';
import 'package:tingle/page/my_income_page/controller/my_income_controller.dart';

class MyIncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyIncomeController>(() => MyIncomeController());
  }
}
