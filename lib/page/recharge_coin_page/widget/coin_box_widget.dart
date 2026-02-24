import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CoinBoxWidget extends StatelessWidget {
  const CoinBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: LayoutBuilder(
        builder: (context, box) {
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Image.asset(
                AppAssets.imgCoinPlanBg,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 15,
                child: SizedBox(
                  height: box.maxHeight,
                  width: box.maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: 120,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.black.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    EnumLocal.txtRemainingCoins.name.tr,
                                    style: AppFontStyle.styleW500(AppColor.white, 12),
                                  ),
                                ),
                                10.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      AppAssets.icMyCoin,
                                      height: 45,
                                      width: 45,
                                    ),
                                    10.width,
                                    Obx(
                                      () => Text(
                                        CustomFormatNumber.onConvert(FetchUserCoin.coin.value),
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          color: AppColor.white,
                                          fontFamily: AppConstant.appFontBold,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2, 2),
                                              blurRadius: 2,
                                              color: Colors.black.withValues(alpha: 0.3),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            // Container(
                            //   height: 35,
                            //   width: 90,
                            //   alignment: Alignment.center,
                            //   decoration: BoxDecoration(
                            //     color: AppColor.white,
                            //     borderRadius: BorderRadius.circular(100),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: AppColor.black.withValues(alpha: 0.3),
                            //         blurRadius: 2,
                            //         offset: Offset(0, 2),
                            //       ),
                            //     ],
                            //   ),
                            //   child: Text(
                            //     EnumLocal.txtTopUp.name.tr,
                            //     style: AppFontStyle.styleW700(AppColor.orange, 16),
                            //   ),
                            // ),
                          ],
                        ),
                        5.height,
                        Divider(
                          color: AppColor.white.withValues(alpha: 0.4),
                        ),
                        5.height,
                        Text(
                          "[ 19***85] 13:10 \$0.98 Recharged",
                          style: AppFontStyle.styleW600(AppColor.white, 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
