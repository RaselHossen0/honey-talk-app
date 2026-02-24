import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/shimmer/coin_recharge_widget_shimmer.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/recharge_coin_page/api/fetch_coin_plan_api.dart';

import 'package:tingle/page/recharge_coin_page/model/fetch_coin_plan_model.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CoinPurchaseBottomSheet {
  static Future<void> show({
    required BuildContext context,
  }) async {
    RxBool isLoading = true.obs;
    RxList<Data> coinPlans = <Data>[].obs;
    RxInt selectedPaymentIndex = 0.obs;
    RxBool isAllowAgreement = false.obs;

    Future<void> fetchCoinPlans() async {
      final uid = FirebaseUid.onGet() ?? "";
      final token = await FirebaseAccessToken.onGet() ?? "";

      final model = await FetchCoinPlanApi.callApi(token: token, uid: uid);
      coinPlans.value = model.data ?? [];
      isLoading.value = false;
    }

    Future<void> handlePayNow(int index) async {
      if (!isAllowAgreement.value) {
        Utils.showToast(text: "Please accept agreement");
        return;
      }

      if (selectedPaymentIndex.value == 0) {
      } else if (selectedPaymentIndex.value == 1) {}
    }

    Widget purchaseCoinWidget() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GridView.builder(
          itemCount: coinPlans.length,
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
            final indexData = coinPlans[index];

            return ItemWidget(
              callback: () => handlePayNow(index),
              amount: (indexData.amount ?? 0).toDouble(),
              coin: (indexData.coin ?? 0).toInt(),
              isPopular: indexData.isPopular ?? false,
            );
          },
        ),
      );
    }

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            EnumLocal.txtSelectPaymentGateway.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
        ),
        15.height,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              15.width,
              _ItemWidget(
                icon: AppAssets.icStripeLogo,
                iconSize: 40,
                boxWidth: 80,
                isSelected: true,
                // controller.selectedPaymentIndex == 0,
                callback: () {
                  handlePayNow(0);
                },
                // controller.onChangePayment(0),
                visible: Utils.isShowStripePaymentMethod,
              ),
              _ItemWidget(
                icon: AppAssets.icRazorpayLogo,
                iconSize: 75,
                boxWidth: 110,
                margin: EdgeInsets.only(left: 15),
                isSelected: true,
                callback: () {},
                // isSelected: controller.selectedPaymentIndex == 1,
                // callback: () => controller.onChangePayment(1),
                visible: Utils.isShowStripePaymentMethod,
              ),
              _ItemWidget(
                icon: AppAssets.icFlutterWaveLogo,
                iconSize: 120,
                boxWidth: 140,
                margin: EdgeInsets.only(left: 15),
                isSelected: true,

                callback: () {},
                // isSelected: controller.selectedPaymentIndex == 2,
                // callback: () => controller.onChangePayment(2),
                visible: Utils.isShowStripePaymentMethod,
              ),
              15.width,
            ],
          ),
        ),
        15.height,
      ],
    );
    fetchCoinPlans();
    Widget paymentGetWayWidget() {
      return SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                EnumLocal.txtSelectPaymentGateway.name.tr,
                style: AppFontStyle.styleW700(AppColor.black, 16),
              ),
            ),
            15.height,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  15.width,
                  _ItemWidget(
                    icon: AppAssets.icStripeLogo,
                    iconSize: 40,
                    boxWidth: 80,
                    isSelected: selectedPaymentIndex.value == 0,
                    callback: () {
                      selectedPaymentIndex.value = 0;
                    },
                    // controller.onChangePayment(0),
                    visible: Utils.isShowStripePaymentMethod,
                  ),
                  _ItemWidget(
                    icon: AppAssets.icRazorpayLogo,
                    iconSize: 75,
                    boxWidth: 110,
                    margin: EdgeInsets.only(left: 15),
                    isSelected: selectedPaymentIndex.value == 1,
                    callback: () {
                      selectedPaymentIndex.value = 1;
                    },
                    visible: Utils.isShowStripePaymentMethod,
                  ),
                  _ItemWidget(
                    icon: AppAssets.icFlutterWaveLogo,
                    iconSize: 120,
                    boxWidth: 140,
                    margin: EdgeInsets.only(left: 15),
                    isSelected: selectedPaymentIndex.value == 2,
                    callback: () {
                      selectedPaymentIndex.value = 2;
                    },
                    visible: Utils.isShowStripePaymentMethod,
                  ),
                  15.width,
                ],
              ),
            ),
            15.height,
          ],
        ),
      );
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: Get.height,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SizedBox(
        height: Get.height / 1.1,
        width: Get.width,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 65,
              color: AppColor.secondary.withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 35,
                    // width: 35,
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(AppAssets.icCoinStar),
                          height: 18,
                          width: 18,
                        ),
                        5.width,
                        Text(
                          "${Database.onGetMyCoins}",
                          style: AppFontStyle.styleW600(AppColor.orange, 16),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      10.height,
                      Text(
                        // "Choose Image",
                        EnumLocal.txtTopUpCoins.name.tr,
                        style: AppFontStyle.styleW700(AppColor.black, 17),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 20, top: 10, left: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondary,
                      ),
                      child: Center(
                        child: Image.asset(
                          width: 18,
                          AppAssets.icClose,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            15.height,
            Obx(() {
              return isLoading.value
                  ? CoinRechargeCoinShimmerWidget()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          paymentGetWayWidget(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              EnumLocal.txtPurchaseCoins.name.tr,
                              style: AppFontStyle.styleW700(AppColor.black, 16),
                            ),
                          ),
                          15.height,
                          purchaseCoinWidget(),
                          const SizedBox(height: 15),
                        ],
                      ),
                    );
            }),
            Obx(() {
              return Container(
                height: 50,
                width: Get.width,
                color: AppColor.transparent,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isAllowAgreement.value = !isAllowAgreement.value;
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: isAllowAgreement.value ? AppColor.transparent : AppColor.orange),
                          gradient: isAllowAgreement.value ? AppColor.orangeYellowGradient : null,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.done,
                          color: isAllowAgreement.value ? AppColor.white : AppColor.transparent,
                          size: 15,
                        ),
                      ),
                    ),
                    10.width,
                    RichText(
                      text: TextSpan(
                        text: EnumLocal.txtByUsingTingleYouAgreeToThe.name.tr,
                        style: AppFontStyle.styleW600(AppColor.secondary, 11),
                        children: [
                          TextSpan(
                            text: EnumLocal.txtUserRechargeAgreement.name.tr,
                            style: AppFontStyle.styleW600(AppColor.orange, 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// Widget buildRechargeCoinSheet() {
//   return GetBuilder<RechargeCoinController>(
//     id: AppConstant.onGetCoinPlan,
//     builder: (controller) {
//       if (controller.isLoading) return RechargeCoinShimmerWidget();
//
//       return
//     },
//   );
// }
class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    required this.icon,
    required this.boxWidth,
    required this.iconSize,
    required this.isSelected,
    required this.callback,
    this.margin,
    required this.visible,
  });

  final String icon;
  final double boxWidth;
  final double iconSize;
  final bool isSelected;
  final EdgeInsetsGeometry? margin;
  final Callback callback;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 40,
          width: boxWidth,
          alignment: Alignment.center,
          margin: margin,
          decoration: BoxDecoration(
            color: AppColor.colorBorder.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? AppColor.orange : AppColor.transparent),
          ),
          child: Image.asset(icon, width: iconSize),
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
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

class PaymentGatewayWidget extends StatelessWidget {
  const PaymentGatewayWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            EnumLocal.txtSelectPaymentGateway.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
        ),
        15.height,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              15.width,
              _ItemWidget(
                icon: AppAssets.icStripeLogo,
                iconSize: 40,
                boxWidth: 80,
                isSelected: true,
                // controller.selectedPaymentIndex == 0,
                callback: () {
                  // handlePayNow(0);
                },
                // controller.onChangePayment(0),
                visible: Utils.isShowStripePaymentMethod,
              ),
              _ItemWidget(
                icon: AppAssets.icRazorpayLogo,
                iconSize: 75,
                boxWidth: 110,
                margin: EdgeInsets.only(left: 15),
                isSelected: true,
                callback: () {},
                // isSelected: controller.selectedPaymentIndex == 1,
                // callback: () => controller.onChangePayment(1),
                visible: Utils.isShowStripePaymentMethod,
              ),
              _ItemWidget(
                icon: AppAssets.icFlutterWaveLogo,
                iconSize: 120,
                boxWidth: 140,
                margin: EdgeInsets.only(left: 15),
                isSelected: true,

                callback: () {},
                // isSelected: controller.selectedPaymentIndex == 2,
                // callback: () => controller.onChangePayment(2),
                visible: Utils.isShowStripePaymentMethod,
              ),
              15.width,
            ],
          ),
        ),
        15.height,
      ],
    );
  }
}
