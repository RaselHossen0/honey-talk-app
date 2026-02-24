import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/feed_page/shimmer/feed_shimmer_widget.dart';
import 'package:tingle/page/feed_page/widget/feed_item_widget.dart';
import 'package:tingle/page/feed_square_page/controller/feed_square_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FeedSquareTopicsWidget extends StatelessWidget {
  const FeedSquareTopicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        5.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: 32,
            width: Get.width,
            child: GetBuilder<FeedSquareController>(
              id: AppConstant.onChangeHashtag,
              builder: (controller) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.popularHashtag.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final indexData = controller.popularHashtag[index];
                    return GestureDetector(
                      onTap: () => controller.onChangeHashtag(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: controller.selectedHashtagIndex == index ? AppColor.primary : AppColor.white.withValues(alpha: 0.2),
                          border: Border.all(color: AppColor.white.withValues(alpha: controller.selectedHashtagIndex == index ? 1 : 0.7)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Image.asset(AppAssets.icRedYellowColorFire, width: 16),
                            5.width,
                            Text(
                              indexData.hashTag ?? "",
                              style: AppFontStyle.styleW600(controller.selectedHashtagIndex == index ? AppColor.white : AppColor.lightGreyPurple, 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        15.height,
        Expanded(
          child: GetBuilder<FeedSquareController>(
            id: AppConstant.onChangeHashtag,
            builder: (controller) => controller.isLoadingTopic
                ? FeedShimmerWidget()
                : controller.topics.isEmpty
                    ? NoDataFoundWidget()
                    : SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.topics.length,
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final indexData = controller.topics[index];
                            return FeedItemWidget(post: indexData);
                          },
                        ),
                      ),
          ),
        ),
      ],
    );
  }
}
