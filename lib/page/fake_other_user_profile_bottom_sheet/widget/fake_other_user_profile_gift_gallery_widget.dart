import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/fake_gift_gallery_bottom_sheet_wiget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeOtherUserProfileGiftGalleryWidget extends StatelessWidget {
  const FakeOtherUserProfileGiftGalleryWidget({super.key, required this.userID, required this.giftCount, required this.isFake});

  final String userID;
  final int giftCount;
  final bool isFake;

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int count = random.nextInt(15);
    return GestureDetector(
      onTap: () => FakeGiftGalleryBottomSheetWidget.show(
        count: count,
        context: context,
      ),
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
                  "Gift Gallery",
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
                3.height,
                Text(
                  "Total Gift Received : $count",
                  style: AppFontStyle.styleW500(AppColor.grayText, 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
