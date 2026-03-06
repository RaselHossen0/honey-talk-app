import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

/// Payment gateway: Razorpay only.
class PaymentGatewayWidget extends StatelessWidget {
  const PaymentGatewayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.height,
        Text(
          EnumLocal.txtSelectPaymentGateway.name.tr,
          style: AppFontStyle.styleW700(AppColor.black, 16),
        ),
        15.height,
        Row(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColor.colorBorder.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.orange),
              ),
              child: Image.asset(
                AppAssets.icRazorpayLogo,
                width: 75,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        15.height,
      ],
    );
  }
}
