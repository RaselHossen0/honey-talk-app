import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class RankAppBarWidget extends GetView<RankingController> {
  const RankAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: SizedBox(
        height: 40,
        width: Get.width,
        child: Row(
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                child: Image.asset(
                  AppAssets.icArrowLeft,
                  width: 10,
                  color: AppColor.white,
                ),
              ),
            ),
            Expanded(
              child: TabBar(
                controller: controller.tabController,
                labelColor: AppColor.white,
                labelStyle: AppFontStyle.styleW600(AppColor.transparent, 17),
                unselectedLabelColor: AppColor.white.withValues(alpha: 0.5),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2,
                indicatorPadding: const EdgeInsets.only(top: 36, right: 10, left: 0),
                dividerColor: AppColor.transparent,
                indicator: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                tabs: <Tab>[
                  Tab(
                    text: EnumLocal.txtRich.name.tr,
                  ),
                  Tab(
                    text: EnumLocal.txtGift.name.tr,
                  ),
                ],
              ),
            ),
            45.width,
          ],
        ),
      ),
    );
  }
}
