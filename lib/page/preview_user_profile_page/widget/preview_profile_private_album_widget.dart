import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfilePrivateAlbumWidget extends StatelessWidget {
  const PreviewProfilePrivateAlbumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) {
        // Placeholder: 6/50 - can be wired to API later
        const int count = 0;
        const int total = 50;
        final List<String> placeholderImages = List.generate(5, (_) => "");

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
                  itemCount: placeholderImages.length,
                  separatorBuilder: (_, __) => 10.width,
                  itemBuilder: (_, index) => _PrivateAlbumThumbnail(price: 500),
                ),
              ),
            ],
          ),
        );
      },
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
          PreviewProfileImageWidget(
            image: "",
            isBanned: false,
            isShowPlaceHolder: true,
          ),
          Container(
            color: AppColor.black.withValues(alpha: 0.5),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.icDiamondRing, width: 20, color: AppColor.pink),
                4.height,
                Text(
                  "$price",
                  style: AppFontStyle.styleW600(AppColor.pink, 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
