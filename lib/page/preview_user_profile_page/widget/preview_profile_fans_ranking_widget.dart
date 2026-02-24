import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/fans_ranking_page/controller/fans_ranking_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileFansRankingWidget extends StatelessWidget {
  const PreviewProfileFansRankingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FansRankingController>();
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.fansRankingPage);
      },
      child: Container(
        height: 80,
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.colorBorder.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocal.txtFansRanking.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
                3.height,
                Text(
                  "${EnumLocal.txtNumberOfParticipantsOnRank.name.tr} ${controller.fansRanking[0].length}",
                  style: AppFontStyle.styleW500(AppColor.grayText, 12),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              height: 36,
              width: 36,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  controller.fansRanking[0].isNotEmpty
                      ? Container(
                          height: 22,
                          width: 22,
                          margin: EdgeInsets.only(bottom: 5),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: PreviewProfileImageWidget(
                            image: controller.fansRanking[0][1].image,
                            isBanned: controller.fansRanking[0][1].isProfilePicBanned,
                          ),
                        )
                      : Offstage(),
                  Image.asset(
                    controller.fansRanking[0].isNotEmpty ? AppAssets.firstRankEmptyFrame : AppAssets.firstRankSeatFrame,
                    width: 36,
                  ),
                ],
              ),
            ),
            8.width,
            SizedBox(
              height: 36,
              width: 36,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  controller.fansRanking[0].length >= 2
                      ? Container(
                          height: 22,
                          width: 22,
                          margin: EdgeInsets.only(bottom: 5),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: PreviewProfileImageWidget(
                            image: controller.fansRanking[0][1].image,
                            isBanned: controller.fansRanking[0][1].isProfilePicBanned,
                          ),
                        )
                      : Offstage(),
                  Image.asset(
                    controller.fansRanking[0].length >= 2 ? AppAssets.secondRankEmptyFrame : AppAssets.secondRankSeatFrame,
                    width: 36,
                  ),
                ],
              ),
            ),
            8.width,
            SizedBox(
              height: 36,
              width: 36,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  controller.fansRanking[0].length >= 3
                      ? Container(
                          height: 22,
                          width: 22,
                          margin: EdgeInsets.only(bottom: 5),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: PreviewProfileImageWidget(
                            image: controller.fansRanking[0][2].image,
                            isBanned: controller.fansRanking[0][2].isProfilePicBanned,
                          ),
                        )
                      : Offstage(),
                  Image.asset(
                    controller.fansRanking[0].length >= 3 ? AppAssets.thirdRankEmptyFrame : AppAssets.thirdRankSeatFrame,
                    width: 36,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
