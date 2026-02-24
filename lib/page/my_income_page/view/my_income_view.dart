import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/my_income_page/controller/my_income_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MyIncomeView extends GetView<MyIncomeController> {
  const MyIncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<MyIncomeController>(
        id: AppConstant.onGetFeed,
        builder: (ctrl) => ctrl.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColor.primary))
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildHeader(context, ctrl),
                  ),
                  SliverToBoxAdapter(
                    child: _buildOrangeBanner(ctrl),
                  ),
                  SliverToBoxAdapter(
                    child: _buildTodayReport(ctrl),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MyIncomeController ctrl) {
    return Container(
      color: AppColor.orange,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top + 12,
        left: 15,
        right: 15,
        bottom: 12,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.arrow_back_ios, color: AppColor.white, size: 20),
            ),
          ),
          Expanded(
            child: Text(
              EnumLocal.txtMyIncome.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.styleW700(AppColor.white, 18),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: ctrl.onNavigateToReport,
                child: Text(EnumLocal.txtReport.name.tr, style: AppFontStyle.styleW600(AppColor.white, 14)),
              ),
              16.width,
              GestureDetector(
                onTap: ctrl.onNavigateToDetails,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(EnumLocal.txtDetails.name.tr, style: AppFontStyle.styleW600(AppColor.white, 14)),
                    4.width,
                    Icon(Icons.help_outline, color: AppColor.white, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrangeBanner(MyIncomeController ctrl) {
    return Container(
      color: AppColor.orange,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Column(
        children: [
          Text(
            CustomFormatNumber.onConvert(ctrl.totalBonus),
            style: AppFontStyle.styleW800(AppColor.white, 32),
          ),
          4.height,
          Text(EnumLocal.txtBonus.name.tr, style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.9), 14)),
          24.height,
          Row(
            children: [
              Expanded(
                child: _buildRevenueBox(
                  CustomFormatNumber.onConvert(ctrl.subsidyRevenue),
                  EnumLocal.txtSubsidyRevenueBonus.name.tr,
                ),
              ),
              16.width,
              Expanded(
                child: _buildRevenueBox(
                  CustomFormatNumber.onConvert(ctrl.payingRevenue),
                  EnumLocal.txtPayingRevenueBonus.name.tr,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueBox(String amount, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(amount, style: AppFontStyle.styleW700(AppColor.white, 18)),
          4.height,
          Text(EnumLocal.txtBonus.name.tr, style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.9), 11)),
          4.height,
          Text(label, style: AppFontStyle.styleW400(AppColor.white.withValues(alpha: 0.85), 10), textAlign: TextAlign.center, maxLines: 2),
        ],
      ),
    );
  }

  Widget _buildTodayReport(MyIncomeController ctrl) {
    final report = ctrl.todayReport;
    if (report == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(EnumLocal.txtTodaysReport.name.tr, style: AppFontStyle.styleW700(AppColor.black, 16)),
          16.height,
          _reportRow(EnumLocal.txtTotalRevenues.name.tr, CustomFormatNumber.onConvert(report.totalRevenues ?? 0), showCoin: true),
          _reportRow(EnumLocal.txtLiveTime.name.tr, report.liveTime ?? "00:00:00"),
          _reportRow(EnumLocal.txtTodaySubsidyRevenue.name.tr, CustomFormatNumber.onConvert(report.todaySubsidyRevenue ?? 0)),
          _reportRow(EnumLocal.txtTodayPayingRevenue.name.tr, CustomFormatNumber.onConvert(report.todayPayingRevenue ?? 0)),
          _reportRow(EnumLocal.txtCallDurationLiveMins.name.tr, (report.callDurationLiveMins ?? 0).toString()),
          _reportRow(EnumLocal.txtCallDurationMins.name.tr, (report.callDurationMins ?? 0).toString()),
          _reportRow(EnumLocal.txtTodayPartyDuration.name.tr, (report.todayPartyDuration ?? 0).toString()),
          _reportRow(EnumLocal.txtEffectiveDurationLive.name.tr, (report.effectiveDurationLive ?? 0).toString()),
          _reportRow(EnumLocal.txtTodayPartyRevenue.name.tr, CustomFormatNumber.onConvert(report.todayPartyRevenue ?? 0)),
        ],
      ),
    );
  }

  Widget _reportRow(String label, String value, {bool showCoin = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppFontStyle.styleW500(AppColor.darkGrey, 14)),
          Row(
            children: [
              Text(value, style: AppFontStyle.styleW600(AppColor.black, 14)),
              if (showCoin) ...[8.width, Image.asset(AppAssets.icMyCoin, width: 18)],
            ],
          ),
        ],
      ),
    );
  }
}
