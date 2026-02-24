import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/my_chat_price_page/controller/my_chat_price_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MyChatPriceView extends GetView<MyChatPriceController> {
  const MyChatPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.colorScaffold,
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(AppAssets.icArrowLeft, width: 10),
          ),
        ),
        centerTitle: true,
        title: Text(
          EnumLocal.txtMyChatPrice.name.tr,
          style: AppFontStyle.styleW700(AppColor.black, 18),
        ),
      ),
      body: GetBuilder<MyChatPriceController>(
        id: AppConstant.onGetFeed,
        builder: (ctrl) => ctrl.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColor.primary))
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBeanBanner(ctrl),
                    20.height,
                    _buildVideoCallPriceCard(ctrl, context),
                    20.height,
                    _buildHighestCallPriceTable(ctrl),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildBeanBanner(MyChatPriceController ctrl) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(AppAssets.icMyCoin, width: 100, height: 100),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: AppColor.coinPinkGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.pink.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                CustomFormatNumber.onConvert(ctrl.videoCallPricePerMin),
                style: AppFontStyle.styleW700(AppColor.white, 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCallPriceCard(MyChatPriceController ctrl, BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.lightestYellow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.lightYellow.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColor.darkYellow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocal.txtVideoCallPrice.name.tr,
            style: AppFontStyle.styleW700(AppColor.darkGrey, 16),
          ),
          12.height,
          Row(
            children: [
              Image.asset(AppAssets.icMyCoin, width: 24, height: 24),
              8.width,
              Text(
                CustomFormatNumber.onConvert(ctrl.videoCallPricePerMin),
                style: AppFontStyle.styleW700(AppColor.darkGrey, 20),
              ),
              Text(
                " ${EnumLocal.txtBonus.name.tr}${EnumLocal.txtPerMinute.name.tr}",
                style: AppFontStyle.styleW500(AppColor.grayText, 14),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => ctrl.onEditPrice(context),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(Icons.edit_outlined, size: 20, color: AppColor.primary),
                ),
              ),
            ],
          ),
          6.height,
          Text(
            EnumLocal.txtRaisePriceHint.name.tr,
            style: AppFontStyle.styleW500(AppColor.orange, 12),
          ),
          16.height,
          Text(
            EnumLocal.txtRegulationsForPriceAdjustment.name.tr,
            style: AppFontStyle.styleW700(AppColor.darkGrey, 14),
          ),
          12.height,
          _buildNumberedRule(1, EnumLocal.txtDefaultPriceNewHosts.name.tr),
          8.height,
          _buildNumberedRule(2, EnumLocal.txtPriceRaiseOpportunities.name.tr),
          8.height,
          _buildNumberedRule(3, EnumLocal.txtFreeCallEarning.name.tr),
          12.height,
          Text(
            EnumLocal.txtVideoFeesNote.name.tr,
            style: AppFontStyle.styleW500(AppColor.orange, 12),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedRule(int num, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$num. ",
          style: AppFontStyle.styleW600(AppColor.darkGrey, 12),
        ),
        Expanded(
          child: Text(
            text,
            style: AppFontStyle.styleW400(AppColor.grayText, 12),
          ),
        ),
      ],
    );
  }

  Widget _buildHighestCallPriceTable(MyChatPriceController ctrl) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.lightestYellow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.lightYellow.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColor.darkYellow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocal.txtTheHighestCallPrice.name.tr,
            style: AppFontStyle.styleW700(AppColor.darkGrey, 16),
          ),
          16.height,
          if (ctrl.highestCallPriceTiers.isEmpty)
            Text(
              "No data",
              style: AppFontStyle.styleW400(AppColor.grayText, 14),
            )
          else
            ...ctrl.highestCallPriceTiers.map((tier) => _buildTableRow(
                  tier.levelRange ?? "",
                  tier.maxPrice ?? 0,
                )),
        ],
      ),
    );
  }

  Widget _buildTableRow(String level, int price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            level,
            style: AppFontStyle.styleW500(AppColor.darkGrey, 14),
          ),
          Row(
            children: [
              Image.asset(AppAssets.icMyCoin, width: 18, height: 18),
              6.width,
              Text(
                CustomFormatNumber.onConvert(price),
                style: AppFontStyle.styleW600(AppColor.darkGrey, 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
