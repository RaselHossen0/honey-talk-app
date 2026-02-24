import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/fans_ranking_page/controller/fans_ranking_controller.dart';
import 'package:tingle/page/ranking_page/widget/ranking_user_list_tile_widget.dart';
import 'package:tingle/page/ranking_page/shimmer/ranking_user_list_shimmer_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class FansRankingTabWidget extends StatelessWidget {
  const FansRankingTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: GetBuilder<FansRankingController>(
                id: AppConstant.onChangeTabBar,
                builder: (controller) => controller.isLoading
                    ? RankingUserListShimmerWidget()
                    : controller.fansRanking[controller.selectedTabIndex].isEmpty
                        ? NoDataFoundWidget()
                        : SingleChildScrollView(
                            controller: controller.scrollController,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.fansRanking[controller.selectedTabIndex].length,
                              padding: EdgeInsets.only(top: 15),
                              itemBuilder: (context, index) {
                                final indexData = controller.fansRanking[controller.selectedTabIndex][index];
                                return RankingUserListTileWidget(
                                  index: index,
                                  title: indexData.name ?? "",
                                  coin: indexData.coin ?? 0,
                                  image: indexData.image ?? "",
                                  gender: indexData.gender ?? "",
                                  age: indexData.age ?? 0,
                                  wealthLevelImage: indexData.wealthLevelImage ?? "",
                                  isVerified: indexData.isVerified ?? false,
                                  isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                                  frame: indexData.avtarFrame ?? "",
                                  frameType: indexData.avtarFrameType ?? 0,
                                  callback: () {},
                                );
                              },
                            ),
                          ),
              ),
            ),
          ),
          GetBuilder<FansRankingController>(
            id: AppConstant.onPagination,
            builder: (controller) => Visibility(
              visible: controller.isPagination,
              child: LinearProgressIndicator(color: AppColor.primary),
            ),
          ),
        ],
      ),
    );
  }
}
