import 'package:get/get.dart';
import 'package:tingle/page/income_details_page/controller/income_details_controller.dart';

class IncomeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomeDetailsController>(() => IncomeDetailsController());
  }
}
