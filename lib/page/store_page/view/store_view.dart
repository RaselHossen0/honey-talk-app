import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/page/store_page/controller/store_controller.dart';
import 'package:tingle/page/store_page/shimmer/store_shimmer.dart';
import 'package:tingle/page/store_page/widget/hot_recommend_widget.dart';
import 'package:tingle/page/store_page/widget/mothly_hottest_widget.dart';
import 'package:tingle/page/store_page/widget/store_app_bar_widget.dart';
import 'package:tingle/page/store_page/widget/store_event_box.dart';
import 'package:tingle/utils/api_params.dart';

import 'package:tingle/utils/utils.dart';

class StoreView extends GetView<StoreController> {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);

    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          GetBuilder<StoreController>(
              id: ApiParams.themeStore,
              builder: (logic) {
                return SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      const StoreAppBarWidget(),
                      10.height,
                      Expanded(
                        child: logic.isLoading
                            ? StoreShimmerWidget()
                            : RefreshIndicator(
                                onRefresh: () async => controller.init(),
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      StoreEventBoxWidget(),
                                      15.height,
                                      MonthHottestPage(),
                                      18.height,
                                      HotRecommendWidget(),
                                      15.height,
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
