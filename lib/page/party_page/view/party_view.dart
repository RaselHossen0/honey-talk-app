import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_dark_background_widget.dart';
import 'package:tingle/page/party_page/controller/party_controller.dart';
import 'package:tingle/page/party_page/widget/party_app_bar_widget.dart';
import 'package:tingle/page/party_page/widget/party_country_tab_bar_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PartyView extends GetView<PartyController> {
  const PartyView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    Utils.onChangeExtendBody(false);
    controller.init();
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.createAudioRoomPage),
        child: Container(
          height: 45,
          width: 115,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            gradient: AppColor.coinPinkGradient,
            border: Border.all(color: AppColor.white),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppAssets.icGoLive, width: 25),
              8.width,
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  EnumLocal.txtParty.name.tr,
                  style: AppFontStyle.styleW700(AppColor.white, 14),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          const CustomDarkBackgroundWidget(),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const PartyAppBarWidget(),
                5.height,
                PartyCountryTabBarWidget(),
                15.height,
                Expanded(
                  child: PageView.builder(
                    itemCount: controller.tabTitles.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GetBuilder<PartyController>(
                        id: AppConstant.onChangeTab,
                        builder: (controller) => controller.pages[controller.selectedTabIndex],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PartyController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
