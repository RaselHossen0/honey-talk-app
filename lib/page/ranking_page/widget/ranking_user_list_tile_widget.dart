import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class RankingUserListTileWidget extends StatelessWidget {
  const RankingUserListTileWidget({
    super.key,
    required this.index,
    required this.title,
    required this.coin,
    required this.image,
    required this.gender,
    required this.age,
    required this.wealthLevelImage,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
    required this.frame,
    required this.frameType,
  });

  final int index;
  final String title;
  final int coin;
  final String image;
  final String gender;
  final String frame;
  final int age;
  final int frameType;
  final String wealthLevelImage;
  final bool isProfileImageBanned;
  final bool isVerified;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 100,
        width: Get.width,
        margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.colorBorder.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 25,
              child: (index + 1) <= 3
                  ? Image.asset(
                      (index + 1) == 1
                          ? AppAssets.rankLevel_1
                          : (index + 1) == 2
                              ? AppAssets.rankLevel_2
                              : AppAssets.rankLevel_3,
                      height: 25,
                    )
                  : Center(
                      child: Text(
                        (index + 1).toString(),
                        style: AppFontStyle.styleW700(AppColor.black, 15),
                      ),
                    ),
            ),
            15.width,
            Container(
              height: 50,
              width: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: AppColor.transparent, shape: BoxShape.circle),
              child: PreviewProfileImageWithFrameWidget(
                image: image,
                isBanned: isProfileImageBanned,
                frame: frame,
                type: frameType,
                fit: BoxFit.cover,
                margin: EdgeInsets.all(5),
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          title,
                          maxLines: 1,
                          style: AppFontStyle.styleW700(AppColor.black, 13),
                        ),
                      ),
                      Visibility(
                        visible: isVerified,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Image.asset(AppAssets.icAuthoriseIcon, width: 18),
                        ),
                      ),
                    ],
                  ),
                  3.height,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              gender == ApiParams.male ? AppAssets.icFemale : AppAssets.icFemale,
                              color: AppColor.white,
                              width: 10,
                            ),
                            3.width,
                            Text(
                              CustomFormatNumber.onConvert(age),
                              style: AppFontStyle.styleW600(AppColor.white, 10),
                            ),
                          ],
                        ),
                      ),
                      5.width,
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColor.lightYellow.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppAssets.icCoinStar, width: 18),
                      3.width,
                      Text(
                        CustomFormatNumber.onConvert(coin),
                        style: AppFontStyle.styleW700(AppColor.lightYellow, 12),
                      ),
                      5.width,
                    ],
                  ),
                ),
                15.height,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
