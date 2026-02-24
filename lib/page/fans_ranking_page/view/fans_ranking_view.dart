import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/fans_ranking_page/controller/fans_ranking_controller.dart';
import 'package:tingle/page/fans_ranking_page/widget/fans_ranking_app_bar_widget.dart';
import 'package:tingle/page/fans_ranking_page/widget/fans_ranking_tab_bar_widget.dart';
import 'package:tingle/page/fans_ranking_page/widget/fans_ranking_tab_widget.dart';
import 'package:tingle/page/fans_ranking_page/widget/fans_ranking_top_three_user_widget.dart';

import 'package:tingle/utils/utils.dart';

class FansRankingView extends StatelessWidget {
  const FansRankingView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      body: Stack(
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
          GetBuilder<FansRankingController>(
            builder: (controller) => Column(
              children: [
                FansRankingAppBarWidget(),
                FansRankingTabBarWidget(),
                20.height,
                FansRankingTopThreeUserWidget(),
                20.height,
                FansRankingTabWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
