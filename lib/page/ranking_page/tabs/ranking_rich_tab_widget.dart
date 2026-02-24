import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/ranking_page/widget/ranking_user_list_tile_widget.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';
import 'package:tingle/page/ranking_page/shimmer/ranking_user_list_shimmer_widget.dart';
import 'package:tingle/page/ranking_page/widget/rich_and_gift_tab_bar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class RankingRichTabWidget extends StatelessWidget {
  const RankingRichTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          20.height,
          RichTabBarWidget(),
          20.height,
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: GetBuilder<RankingController>(
                id: AppConstant.onChangeRichTabBar,
                builder: (controller) => controller.isLoadingRankingRichUser
                    ? RankingUserListShimmerWidget()
                    : controller.rankingRichUser[controller.selectedRichTabIndex].isEmpty
                        ? NoDataFoundWidget()
                        : SingleChildScrollView(
                            controller: controller.richScrollController,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.rankingRichUser[controller.selectedRichTabIndex].length,
                              padding: EdgeInsets.only(top: 15),
                              itemBuilder: (context, index) {
                                final indexData = controller.rankingRichUser[controller.selectedRichTabIndex][index];
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
          GetBuilder<RankingController>(
            id: AppConstant.onPagination,
            builder: (controller) => Visibility(
              visible: controller.isPaginationRankingRichUser,
              child: LinearProgressIndicator(color: AppColor.primary),
            ),
          )
        ],
      ),
    );
  }
}
