import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/recharge_coin_page/controller/recharge_coin_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PurchaseCoinWidget extends StatelessWidget {
  const PurchaseCoinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RechargeCoinController>(
      id: AppConstant.onGetCoinPlan,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocal.txtPurchaseCoins.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
          15.height,
          GridView.builder(
            itemCount: controller.coinPlans.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              mainAxisExtent: 200,
            ),
            itemBuilder: (BuildContext context, int index) {
              final indexData = controller.coinPlans[index];
              return _ItemWidget(
                callback: () => controller.onClickPayNow(index),
                amount: (indexData.amount ?? 0).toDouble(),
                coin: (indexData.coin ?? 0).toInt(),
                isPopular: indexData.isPopular ?? false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    required this.coin,
    required this.amount,
    required this.isPopular,
    required this.callback,
  });

  final int coin;
  final double amount;
  final bool isPopular;
  final Callback callback;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.orange, width: 1),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              children: [
                12.height,
                Center(
                  child: Image.asset(AppAssets.icMyCoin, width: 58),
                ),
                10.height,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.orange.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "${CustomFormatNumber.onConvert(coin)} Coin",
                    style: AppFontStyle.styleW700(AppColor.orange.withValues(alpha: 0.6), 11),
                  ),
                ),
                8.height,
                Text(
                  "${Utils.currencySymbol} ${CustomFormatNumber.onConvert(amount.toInt())}",
                  style: AppFontStyle.styleW900(AppColor.orange, 20),
                ),
                8.height,
                GestureDetector(
                  onTap: callback,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: AppColor.orangeYellowGradient,
                    ),
                    height: 42,
                    width: Get.width,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            EnumLocal.txtPayNow.name.tr,
                            style: AppFontStyle.styleW700(AppColor.white, 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isPopular,
            child: Positioned(
              top: 20,
              right: -22,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(45 / 360),
                child: Container(
                  height: 18,
                  width: 100,
                  decoration: BoxDecoration(gradient: AppColor.orangeYellowGradient),
                  child: Center(
                    child: Text(
                      EnumLocal.txtMostPopularPlan.name.tr,
                      style: AppFontStyle.styleW700(AppColor.white, 8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
