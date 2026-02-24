import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/profile_page/api/fetch_user_profile_api.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class ProfileController extends GetxController with GetTickerProviderStateMixin {
  FetchUserProfileModel? fetchUserProfileModel;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void onInit() {
    Utils.showLog("Profile Controller Init Success");
    super.onInit();
  }

  Future<void> init() async {
    final controller = Get.find<BottomBarController>();
    if (Get.currentRoute == AppRoutes.bottomBarPage && controller.selectedTabIndex == 4) {
      await onGetProfile();
    }
  }

  Future<void> onGetProfile() async {
    isLoading = true;
    update([AppConstant.onGetProfile]);

    fetchUserProfileModel = getDummyFetchUserProfile();

    Database.onSetMyCoins((fetchUserProfileModel?.user?.coin ?? 0).toInt());

    isLoading = false;
    update([AppConstant.onGetProfile]);
  }
}
