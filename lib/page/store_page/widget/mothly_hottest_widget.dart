import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/new_preview_frame.dart';
import 'package:tingle/custom/widget/custom_coinday_txt_widget.dart';
import 'package:tingle/custom/widget/custum_gredient_text.dart';
import 'package:tingle/page/store_page/controller/store_controller.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MonthHottestPage extends StatelessWidget {
  const MonthHottestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // You can wrap your UI in a Scaffold or use it inside another widget
    return GetBuilder<StoreController>(builder: (logic) {
      final topFrames = logic.topFramesModel?.topFrames ?? [];
      return topFrames.length == 3
          ? Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.only(top: 20),
                  height: 200,
                  decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColor.primary)),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (index) {
                      if (index < topFrames.length) {
                        final item = topFrames[index];
                        return item.name?.isEmpty == true
                            ? _buildPlaceholder()
                            : Expanded(
                                child: itemCard(
                                  imagePath: item.image ?? "",
                                  title: item.name ?? "",
                                  coin: item.coin ?? 0,
                                  validity: item.validity ?? 0,
                                  validityType: item.validity ?? 0,
                                  framePath: item.svgaImage ?? "",
                                  type: item.type ?? 0,
                                  frameColor: Colors.blue,
                                  callback: () {
                                    PreviewSVGADaiLog.show(
                                      isfake: true,
                                      userId: Database.loginUserId,
                                      context: context,
                                      frameData: item,
                                      itemType: ApiParams.frame,
                                    );
                                  },
                                ),
                              );
                      } else {
                        return _buildPlaceholder();
                      }
                    }),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    transform: Matrix4.skewX(-.3),
                    // Give some padding so the text has room
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    // Use a BoxDecoration to create a horizontal gradient + rounded corners
                    decoration: BoxDecoration(
                      gradient: AppColor.monthHottestGradientBg,
                      border: Border.all(color: AppColor.white, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          EnumLocal.txtMonthHottest.name.tr,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppConstant.appFontBold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 5
                              ..color = Colors.white,
                          ),
                        ),
                        // 2) The fill text on top
                        GradientTextUi(
                          gradient: AppColor.monthHottestGradient,
                          EnumLocal.txtMonthHottest.name.tr,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppConstant.appFontBold,
                            // Dark fill color
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : 0.height;
    });
  }

  // A helper widget for each frame card
  Widget itemCard({
    required String imagePath,
    required String framePath,
    required String title,
    required int validity,
    required int validityType,
    required int coin,
    required int type,
    required Color frameColor,
    required Callback callback,
  }) {
    log("imagePath:NEW CHECK $title");

    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor.transparent),
      onTap: callback,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.lightGrayBg),
            child: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset(imagePath)),
          ),

          8.height,
          SizedBox(
            width: 120,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppFontStyle.styleW500(AppColor.black, 12),
            ),
          ),
          8.height,

          // Price row
          Container(
            decoration: BoxDecoration(color: AppColor.lightestYellow, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(4),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Image.asset(
                  AppAssets.icCoinStar,
                  width: 16,
                ),
                const SizedBox(width: 4),
                CoinValidityText(
                  coin: coin.toString(),
                  validity: validity.toString(),
                  validityType: validityType,
                  style: AppFontStyle.styleW600(AppColor.darkYellow, 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Column(
      children: [
        8.height,
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(
            AppAssets.icFrameIcon,
            fit: BoxFit.cover,
          ),
        ),
        // 6.height,
      ],
    );
  }
}
