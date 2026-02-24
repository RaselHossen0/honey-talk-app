import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/recharge_coin_page/controller/recharge_coin_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PaymentGatewayWidget extends StatelessWidget {
  const PaymentGatewayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RechargeCoinController>(
      id: AppConstant.onChangePayment,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.height,
          Text(
            EnumLocal.txtSelectPaymentGateway.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
          15.height,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _ItemWidget(
                  icon: AppAssets.icStripeLogo,
                  iconSize: 40,
                  boxWidth: 80,
                  isSelected: controller.selectedPaymentIndex == 0,
                  callback: () => controller.onChangePayment(0),
                  visible: Utils.isShowStripePaymentMethod,
                ),
                _ItemWidget(
                  icon: AppAssets.icRazorpayLogo,
                  iconSize: 75,
                  boxWidth: 110,
                  margin: EdgeInsets.only(left: 15),
                  isSelected: controller.selectedPaymentIndex == 1,
                  callback: () => controller.onChangePayment(1),
                  visible: Utils.isShowStripePaymentMethod,
                ),
                _ItemWidget(
                  icon: AppAssets.icFlutterWaveLogo,
                  iconSize: 120,
                  boxWidth: 140,
                  margin: EdgeInsets.only(left: 15),
                  isSelected: controller.selectedPaymentIndex == 2,
                  callback: () => controller.onChangePayment(2),
                  visible: Utils.isShowStripePaymentMethod,
                ),
              ],
            ),
          ),
          15.height,
        ],
      ),
    );
  }
}

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
