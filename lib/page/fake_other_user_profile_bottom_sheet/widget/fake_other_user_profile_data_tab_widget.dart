import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_gift_gallery_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_wealth_level_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

/// Information tab: Private album, Review, My Wealth Level, Gift (matching preview layout).
class FakeOtherUserProfileDataTabWidget extends StatelessWidget {
  const FakeOtherUserProfileDataTabWidget({
    super.key,
    required this.userID,
    required this.giftCount,
    required this.isFake,
  });

  final String userID;
  final int giftCount;
  final bool isFake;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PrivateAlbumSection(),
        _ReviewSection(),
        FakeOtherUserProfileWealthLevelWidget(),
        15.height,
        FakeOtherUserProfileGiftGalleryWidget(
          userID: userID,
          giftCount: giftCount,
          isFake: isFake,
        ),
      ],
    );
  }
}

class _PrivateAlbumSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const count = 6;
    const total = 50;
    final placeholders = List.generate(5, (_) => 500);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${EnumLocal.txtPrivateAlbum.name.tr} ($count/$total)",
                style: AppFontStyle.styleW700(AppColor.black, 16),
              ),
              Image.asset(AppAssets.icArrowRight, width: 18, color: AppColor.grayText),
            ],
          ),
          10.height,
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: placeholders.length,
              separatorBuilder: (_, __) => 10.width,
              itemBuilder: (_, i) => _PrivateAlbumThumbnail(price: placeholders[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateAlbumThumbnail extends StatelessWidget {
  const _PrivateAlbumThumbnail({required this.price});

  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.colorBorder,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          PreviewProfileImageWidget(image: "", isBanned: false, isShowPlaceHolder: true),
          Container(color: AppColor.black.withValues(alpha: 0.5)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.icDiamondRing, width: 20, color: AppColor.pink),
                4.height,
                Text("$price", style: AppFontStyle.styleW600(AppColor.pink, 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tags = [
      {"label": "Young", "count": 2},
      {"label": "Beautiful", "count": 2},
      {"label": "Graceful", "count": 2},
      {"label": "Elegant", "count": 1},
      {"label": "Cute", "count": 1},
      {"label": "Charming voice", "count": 1},
      {"label": "Coquettish", "count": 1},
    ];
    const color = Color(0xFFE8E0F5);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocal.txtReview.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
          10.height,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map<Widget>((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${t["label"]}·${t["count"]}",
                style: AppFontStyle.styleW500(AppColor.grayText, 12),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
