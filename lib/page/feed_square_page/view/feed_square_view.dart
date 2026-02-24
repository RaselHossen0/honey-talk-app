import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_dark_background_widget.dart';
import 'package:tingle/page/feed_square_page/controller/feed_square_controller.dart';
import 'package:tingle/page/feed_square_page/widget/feed_square_tab_bar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class FeedSquareView extends GetView<FeedSquareController> {
  const FeedSquareView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      body: Stack(
        children: [
          const CustomDarkBackgroundWidget(),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top + 50),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      3.height,
                      // const VideoActivityWidget(),
                      // 8.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: const FeedSquareTabBarWidget(),
                      ),
                      3.height,
                      Expanded(
                        child: GetBuilder<FeedSquareController>(
                          id: AppConstant.onChangeFeedType,
                          builder: (controller) => PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.feedPages.length,
                            itemBuilder: (context, index) {
                              return controller.feedPages[controller.selectedFeedType];
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<FeedSquareController>(
        id: AppConstant.onMomentPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingMomentPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
