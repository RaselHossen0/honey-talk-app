import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/bottom_bar_page/widget/bottom_bar_widget.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: Utils.isExtendBody.value,
        body: GetBuilder<BottomBarController>(
          id: AppConstant.onChangeBottomBar,
          builder: (logic) {
            return PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: logic.bottomBarPages.length,
              onPageChanged: (int index) => logic.onChangeBottomBar(index),
              itemBuilder: (context, index) => logic.bottomBarPages[logic.selectedTabIndex],
            );
          },
        ),
        bottomNavigationBar: const BottomBarWidget(),
      ),
    );
  }
}
