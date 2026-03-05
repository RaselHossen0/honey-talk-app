import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:lottie/lottie.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class StreamGridviewItemWidget extends StatelessWidget {
  const StreamGridviewItemWidget({
    super.key,
    required this.name,
    required this.userName,
    required this.image,
    required this.isBanned,
    required this.countryFlag,
    required this.countryCode,
    required this.viewCount,
    required this.callback,
    required this.liveType,
    required this.callPricePerMin,
    this.age = 0,
  });

  final String name;
  final String userName;
  final String image;
  final bool isBanned;
  final String countryFlag;
  final String countryCode;
  final int viewCount;
  final Callback callback;
  final int liveType;
  final int callPricePerMin;
  final int age;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.white),
          borderRadius: BorderRadius.circular(20),
        ),
        child: LayoutBuilder(builder: (context, box) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PreviewPostImageWidget(
                  image: image,
                  isBanned: isBanned,
                  fit: BoxFit.cover,
                ),
              ),
              // Live badge - top right, purple
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    liveType == 1
                        ? EnumLocal.txtLive.name.tr
                        : liveType == 2
                            ? EnumLocal.txtAudioLive.name.tr
                            : liveType == 3
                                ? EnumLocal.txtPkBattle.name.tr
                                : EnumLocal.txtLive.name.tr,
                    style: AppFontStyle.styleW600(AppColor.white, 10),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 100,
                  width: box.maxWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Left: name, age badge, flag+country, call rate
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.styleW700(AppColor.white, 12),
                            ),
                            4.height,
                            Row(
                              children: [
                                if (age > 0)
                                  Container(
                                    margin: const EdgeInsets.only(right: 6),
                                    height: 18,
                                    width: 18,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColor.pink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "$age",
                                      style: AppFontStyle.styleW600(AppColor.white, 10),
                                    ),
                                  ),
                                PreviewCountryFlagIcon(flag: countryFlag, size: 14),
                                4.width,
                                Text(
                                  countryCode,
                                  style: AppFontStyle.styleW600(AppColor.white, 10),
                                ),
                              ],
                            ),
                            4.height,
                            Row(
                              children: [
                                Image.asset(AppAssets.icDiamondRing, width: 12, color: AppColor.pink),
                                4.width,
                                Text(
                                  "${CustomFormatNumber.onConvert(callPricePerMin)}/min",
                                  style: AppFontStyle.styleW600(AppColor.white, 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Right: Lottie call receive button
                      GestureDetector(
                        onTap: callback,
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Lottie.asset(
                            AppAssets.lottieCallReceive,
                            width: 44,
                            height: 44,
                            fit: BoxFit.contain,
                            repeat: true,
                            errorBuilder: (_, __, ___) => Image.asset(AppAssets.icVideoCallBorder, width: 28, color: AppColor.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
