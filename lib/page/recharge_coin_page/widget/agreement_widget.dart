import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/recharge_coin_page/controller/recharge_coin_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AgreementWidget extends StatelessWidget {
  const AgreementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RechargeCoinController>(
      id: AppConstant.onToggleAgreement,
      builder: (controller) => GestureDetector(
        onTap: controller.onToggleAgreement,
        child: Container(
          color: AppColor.transparent,
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: controller.isAllowAgreement ? AppColor.transparent : AppColor.orange),
                  gradient: controller.isAllowAgreement ? AppColor.orangeYellowGradient : null,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.done,
                  color: controller.isAllowAgreement ? AppColor.white : AppColor.transparent,
                  size: 15,
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
        ),
      ),
    );
  }
}
