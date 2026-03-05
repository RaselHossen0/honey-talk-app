import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/fake_gift_gallery_bottom_sheet_wiget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeOtherUserProfileGiftGalleryWidget extends StatelessWidget {
  const FakeOtherUserProfileGiftGalleryWidget({
    super.key,
    required this.userID,
    required this.giftCount,
    required this.isFake,
  });

  final String userID;
  final int giftCount;
  final bool isFake;

  static const _giftIcons = [
    AppAssets.icGiftToy,
    AppAssets.icGiftCat,
    AppAssets.icGiftLove,
    AppAssets.icLightPinkGift,
    AppAssets.icChatGift,
    AppAssets.icDiamondRing,
  ];
  static const _counts = [5, 1, 3, 1, 1, 47, 2, 1, 6, 4];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FakeGiftGalleryBottomSheetWidget.show(
        count: giftCount > 0 ? giftCount : 10,
        context: context,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  EnumLocal.txtGift.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
                Image.asset(AppAssets.icArrowRight, width: 18, color: AppColor.grayText),
              ],
            ),
            10.height,
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 5,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
              children: List.generate(
                10,
                (i) => _GiftGridItem(
                  icon: _giftIcons[i % _giftIcons.length],
                  count: _counts[i % _counts.length],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GiftGridItem extends StatelessWidget {
  const _GiftGridItem({required this.icon, required this.count});

  final String icon;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(icon, width: 40, height: 40, fit: BoxFit.cover),
        ),
        const SizedBox(height: 4),
        Text(
          "x$count",
          style: AppFontStyle.styleW500(AppColor.grayText, 11),
        ),
      ],
    );
  }
}
