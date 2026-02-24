import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeOtherUserProfileFansRankingWidget extends StatelessWidget {
  const FakeOtherUserProfileFansRankingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                "Fans Ranking",
                style: AppFontStyle.styleW700(AppColor.black, 16),
              ),
              3.height,
              Text(
                "Number of participants on rank:  0",
                style: AppFontStyle.styleW500(AppColor.grayText, 12),
              ),
            ],
          ),
          Spacer(),
          Image.asset(AppAssets.icYellowFansRanking, width: 35),
          10.width,
          Image.asset(AppAssets.icGreyFansRanking, width: 35),
          10.width,
          Image.asset(AppAssets.icOrangeFansRanking, width: 35),
        ],
      ),
    );
  }
}
