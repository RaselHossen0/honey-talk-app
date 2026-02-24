import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/backpack_page/controller/backpack_controller.dart';

import 'package:tingle/page/theme_outfit_page/controller/theme_outfit_contoller.dart';
import 'package:tingle/page/theme_outfit_page/shimmer/theme_outfit_shimmer.dart';
import 'package:tingle/page/theme_outfit_page/widget/avtar_theme_outfit_widget.dart';
import 'package:tingle/page/theme_outfit_page/widget/party_theme_widget_outfit.dart';
import 'package:tingle/page/theme_outfit_page/widget/rides_theme_outfit_widget.dart';
import 'package:tingle/page/theme_outfit_page/widget/theme_outfit_appbar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class ThemeOutfitView extends GetView<ThemeOutfitView> {
  const ThemeOutfitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: ThemeOutfitAppbarWidget.onShow(
        context,
      ),
      body: GetBuilder<BackpackController>(
        builder: (logic) => GetBuilder<ThemeOutfitController>(
          builder: (controller) => controller.isLoading.value
              ? ThemeOutfitShimmerWidget()
              : SizedBox(
                  height: Get.height * 0.83, // Ensures full height for scrolling
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller.outfitTabController,
                    children: [
                      AvtarThemeOutfitWidget(),
                      RidesThemeOutfitWidget(),
                      PartyThemeWidgetOutfit(),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: GetBuilder<ThemeOutfitController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
