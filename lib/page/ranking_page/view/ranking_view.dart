import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';
import 'package:tingle/page/ranking_page/tabs/ranking_gift_tab_widget.dart';
import 'package:tingle/page/ranking_page/tabs/ranking_rich_tab_widget.dart';
import 'package:tingle/page/ranking_page/widget/rank_app_bar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class RankingView extends StatelessWidget {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff3B85F6), Color(0xffA239F9)],
              ),
            ),
          ),
          GetBuilder<RankingController>(
            builder: (controller) => Column(
              children: [
                RankAppBarWidget(),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      RankingRichTabWidget(),
                      RankingGiftTabWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
