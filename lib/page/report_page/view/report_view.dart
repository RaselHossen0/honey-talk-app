import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/report_page/controller/report_controller.dart';
import 'package:tingle/page/report_page/model/fetch_report_model.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: GetBuilder<ReportController>(
        id: AppConstant.onGetFeed,
        builder: (ctrl) => ctrl.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColor.primary))
            : Column(
                children: [
                  _buildHeader(context, ctrl),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 24),
                      itemCount: ctrl.dailyReports.length,
                      itemBuilder: (context, index) => _buildDailyCard(ctrl.dailyReports[index]),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ReportController ctrl) {
    return Container(
      color: AppColor.orange,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top + 12,
        left: 15,
        right: 15,
        bottom: 16,
      ),
      child: Column(
        children: [
          Row(
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
                  EnumLocal.txtReport.name.tr,
                  textAlign: TextAlign.center,
                  style: AppFontStyle.styleW700(AppColor.white, 18),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          16.height,
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: ctrl.selectThisWeek,
                  child: Column(
                    children: [
                      Text(
                        EnumLocal.txtThisWeek.name.tr,
                        style: AppFontStyle.styleW600(
                          ctrl.isThisWeek ? AppColor.white : AppColor.white.withValues(alpha: 0.7),
                          14,
                        ),
                      ),
                      if (ctrl.isThisWeek)
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          height: 3,
                          color: AppColor.white,
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: ctrl.selectLastWeek,
                  child: Column(
                    children: [
                      Text(
                        EnumLocal.txtLastWeek.name.tr,
                        style: AppFontStyle.styleW600(
                          !ctrl.isThisWeek ? AppColor.white : AppColor.white.withValues(alpha: 0.7),
                          14,
                        ),
                      ),
                      if (!ctrl.isThisWeek)
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          height: 3,
                          color: AppColor.white,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyCard(DailyReport report) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            report.date ?? "",
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
          16.height,
          _reportRow(EnumLocal.txtLiveTime.name.tr, report.liveTime ?? "00:00:00"),
          _reportRow(EnumLocal.txtCallDurationLiveMins.name.tr, (report.callDurationLiveMins ?? 0).toString()),
          _reportRow(EnumLocal.txtCallDurationMins.name.tr, (report.callDurationMins ?? 0).toString()),
          _reportRow(EnumLocal.txtNegativeReview.name.tr, (report.negativeReview ?? 0).toString()),
          _reportRow(EnumLocal.txtComplaint.name.tr, (report.complaint ?? 0).toString()),
          _reportRow(EnumLocal.txtTodayPartyDuration.name.tr, (report.partyDuration ?? 0).toString()),
          12.height,
          _reportRowWithCoin(EnumLocal.txtSubsidyRevenueBonus.name.tr, report.subsidyRevenue ?? 0),
          _reportRowWithCoin(EnumLocal.txtPayingRevenueBonus.name.tr, report.payingRevenue ?? 0),
          _reportRowWithCoin(EnumLocal.txtPartyRevenue.name.tr, report.partyRevenue ?? 0),
          _reportRowWithCoin(EnumLocal.txtBenefitsOfPrivateChat.name.tr, report.benefitsOfPrivateChat ?? 0),
          12.height,
          _reportRowWithCoin(EnumLocal.txtTotalRevenues.name.tr, report.totalRevenues ?? 0),
          _reportRowWithCoinAndDollar(EnumLocal.txtEstimatedSettlementAmount.name.tr, report.estimatedSettlementAmount ?? 0),
        ],
      ),
    );
  }

  Widget _reportRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppFontStyle.styleW500(AppColor.darkGrey, 14)),
          Text(value, style: AppFontStyle.styleW600(AppColor.black, 14)),
        ],
      ),
    );
  }

  Widget _reportRowWithCoin(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppFontStyle.styleW500(AppColor.darkGrey, 14)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppAssets.icMyCoin, width: 18),
              6.width,
              Text(CustomFormatNumber.onConvert(value), style: AppFontStyle.styleW600(AppColor.black, 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reportRowWithCoinAndDollar(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppFontStyle.styleW500(AppColor.darkGrey, 14)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppAssets.icMyCoin, width: 18),
              6.width,
              Text(
                "${CustomFormatNumber.onConvert(value)} \$",
                style: AppFontStyle.styleW600(AppColor.black, 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
