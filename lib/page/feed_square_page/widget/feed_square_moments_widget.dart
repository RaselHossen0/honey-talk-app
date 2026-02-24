import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/feed_page/shimmer/feed_shimmer_widget.dart';
import 'package:tingle/page/feed_page/widget/feed_item_widget.dart';
import 'package:tingle/page/feed_square_page/controller/feed_square_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class FeedSquareMomentsWidget extends StatelessWidget {
  const FeedSquareMomentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GetBuilder<FeedSquareController>(
        id: AppConstant.onGetMoment,
        builder: (controller) => RefreshIndicator(
          color: AppColor.primary,
          onRefresh: () async => controller.onRefreshMoment(),
          child: controller.isLoadingMoment
              ? FeedShimmerWidget()
              : controller.moments.isEmpty
                  ? LayoutBuilder(
                      builder: (context, box) {
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: box.maxHeight + 1,
                            child: NoDataFoundWidget(),
                          ),
                        );
                      },
                    )
                  : LayoutBuilder(builder: (context, box) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: box.maxHeight + 1,
                          child: RefreshIndicator(
                            color: AppColor.primary,
                            onRefresh: () async => controller.onRefreshMoment(),
                            child: SingleChildScrollView(
                              controller: controller.momentScrollController,
                              child: ListView.builder(
                                shrinkWrap: true,
                                // itemCount: 1,
                                itemCount: controller.moments.length,
                                padding: const EdgeInsets.only(right: 15, left: 15),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final indexData = controller.moments[index];
                                  return FeedItemWidget(post: indexData);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
        ),
      ),
    );
  }
}
