import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/backpack_page/controller/backpack_controller.dart';
import 'package:tingle/page/backpack_page/shimmer/backpack_shimmer_widget.dart';
import 'package:tingle/page/backpack_page/widget/backpack_app_bar.dart';
import 'package:tingle/page/backpack_page/widget/network_frame_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class BackpackPage extends GetView<BackpackController> {
  const BackpackPage({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      body: GetBuilder<BackpackController>(
          id: ApiParams.backpack,
          builder: (logic) {
            return Container(
              decoration: BoxDecoration(color: AppColor.colorBorder.withValues(alpha: 0.5)),
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  const BackpackAppbar(),
                  Expanded(
                    child: logic.isLoading
                        ? BackpackShimmerWidget()
                        : RefreshIndicator(
                            onRefresh: () async => controller.init(),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  15.height,
                                  NetworkFrameWidget(
                                    callback: () {
                                      Get.toNamed(AppRoutes.themeOutfitPage, arguments: {ApiParams.tabIndex: 0})?.then(
                                        (value) => Utils.onChangeStatusBar(brightness: Brightness.dark),
                                      );
                                    },
                                    title: EnumLocal.txtAvtarTheme.name.tr,
                                    ownedCount: logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?.length ?? 0,
                                    frameAssets: logic.fetchPurchasedFrameModel?.data?.avatarFrames,
                                    itemType: ApiParams.frame,
                                  ),
                                  15.height,
                                  NetworkFrameWidget(
                                    callback: () {
                                      Get.toNamed(AppRoutes.themeOutfitPage, arguments: {ApiParams.tabIndex: 1})?.then(
                                        (value) => Utils.onChangeStatusBar(brightness: Brightness.dark),
                                      );
                                    },
                                    title: EnumLocal.txtRides.name.tr,
                                    ownedCount: logic.fetchPurchasedFrameModel?.data?.rides?.active?.length ?? 0,
                                    frameAssets: logic.fetchPurchasedFrameModel?.data?.rides,
                                    itemType: ApiParams.ride,
                                    // List.generate(logic.fetchPurchasedFrameModel?.data?.rides?.length ?? 0, (index) => AppAssets.ic_frame_icon),
                                  ),
                                  15.height,
                                  NetworkFrameWidget(
                                    callback: () {
                                      Get.toNamed(AppRoutes.themeOutfitPage, arguments: {ApiParams.tabIndex: 2})?.then(
                                        (value) => Utils.onChangeStatusBar(brightness: Brightness.dark),
                                      );
                                    },
                                    title: EnumLocal.txtPartyTheme.name.tr,
                                    ownedCount: logic.fetchPurchasedFrameModel?.data?.themes?.active?.length ?? 0,
                                    frameAssets: logic.fetchPurchasedFrameModel?.data?.themes,
                                    itemType: ApiParams.theme,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
