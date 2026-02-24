import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/fans_ranking_page/controller/fans_ranking_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class FansRankingTopThreeUserWidget extends StatelessWidget {
  const FansRankingTopThreeUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FansRankingController>(
      id: AppConstant.onChangeTabBar,
      builder: (controller) {
        bool isAvailable_1 = controller.fansRanking[controller.selectedTabIndex].isNotEmpty;
        bool isAvailable_2 = controller.fansRanking[controller.selectedTabIndex].length >= 2;
        bool isAvailable_3 = controller.fansRanking[controller.selectedTabIndex].length >= 3;

        return Container(
          height: 120,
          width: Get.width,
          color: AppColor.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              15.width,
              _SeatWidget(
                position: 2,
                isAvailable: isAvailable_2,
                image: isAvailable_2 ? (controller.fansRanking[controller.selectedTabIndex][1].image ?? "") : "",
                isBanned: isAvailable_2 ? (controller.fansRanking[controller.selectedTabIndex][1].isProfilePicBanned ?? false) : false,
                size: 80,
              ),
              _SeatWidget(
                position: 1,
                isAvailable: isAvailable_1,
                image: isAvailable_1 ? (controller.fansRanking[controller.selectedTabIndex][0].image ?? "") : "",
                isBanned: isAvailable_1 ? (controller.fansRanking[controller.selectedTabIndex][0].isProfilePicBanned ?? false) : false,
                size: 110,
              ),
              _SeatWidget(
                position: 3,
                isAvailable: isAvailable_3,
                image: isAvailable_3 ? (controller.fansRanking[controller.selectedTabIndex][2].image ?? "") : "",
                isBanned: isAvailable_3 ? (controller.fansRanking[controller.selectedTabIndex][2].isProfilePicBanned ?? false) : false,
                size: 80,
              ),
              15.width,
            ],
          ),
        );
      },
    );
  }
}

class _SeatWidget extends StatelessWidget {
  const _SeatWidget({
    required this.position,
    required this.isAvailable,
    required this.image,
    required this.isBanned,
    required this.size,
  });

  final int position;
  final bool isAvailable;
  final String image;
  final bool isBanned;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: position == 1 ? Alignment.topCenter : Alignment.bottomCenter,
      child: isAvailable
          ? SizedBox(
              height: size,
              width: size,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: size / 1.5,
                    width: size / 1.5,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: PreviewProfileImageWidget(image: image, isBanned: isBanned),
                  ),
                  Image.asset(
                    position == 1
                        ? AppAssets.firstRankEmptyFrame
                        : position == 2
                            ? AppAssets.secondRankEmptyFrame
                            : AppAssets.thirdRankEmptyFrame,
                    width: size,
                  ),
                ],
              ),
            )
          : SizedBox(
              height: size,
              width: size,
              child: Image.asset(
                position == 1
                    ? AppAssets.firstRankSeatFrame
                    : position == 2
                        ? AppAssets.secondRankSeatFrame
                        : AppAssets.thirdRankSeatFrame,
                width: size,
              ),
            ),
    );
  }
}
