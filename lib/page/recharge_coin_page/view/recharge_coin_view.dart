import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/recharge_coin_page/controller/recharge_coin_controller.dart';
import 'package:tingle/page/recharge_coin_page/shimmer/recharge_coin_shimmer_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/agreement_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/coin_box_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/payment_gateway_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/purchase_coin_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/recharge_coin_app_bar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class RechargeCoinView extends GetView<RechargeCoinController> {
  const RechargeCoinView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: RechargeCoinAppBarWidget.onShow(context),
      body: GetBuilder<RechargeCoinController>(
        id: AppConstant.onGetCoinPlan,
        builder: (controller) => controller.isLoading
            ? RechargeCoinShimmerWidget()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            15.height,
                            CoinBoxWidget(),
                            PaymentGatewayWidget(),
                            PurchaseCoinWidget(),
                          ],
                        ),
                      ),
                    ),
                    AgreementWidget(),
                  ],
                ),
              ),
      ),
    );
  }
}
