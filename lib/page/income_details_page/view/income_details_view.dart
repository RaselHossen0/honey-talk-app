import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/custom/function/custom_format_date.dart';
import 'package:tingle/page/income_details_page/controller/income_details_controller.dart';
import 'package:tingle/page/income_details_page/model/fetch_income_details_model.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class IncomeDetailsView extends GetView<IncomeDetailsController> {
  const IncomeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
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
          EnumLocal.txtDetails.name.tr,
          style: AppFontStyle.styleW700(AppColor.black, 18),
        ),
        actions: [
          GestureDetector(
            onTap: _showFilterSheet,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder<IncomeDetailsController>(
                    id: AppConstant.onGetFeed,
                    builder: (ctrl) => Text(
                      ctrl.selectedFilter,
                      style: AppFontStyle.styleW600(AppColor.primary, 14),
                    ),
                  ),
                  4.width,
                  Icon(Icons.keyboard_arrow_down, color: AppColor.primary, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<IncomeDetailsController>(
        id: AppConstant.onGetFeed,
        builder: (ctrl) => ctrl.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColor.primary))
            : ctrl.transactions.isEmpty
                ? NoDataFoundWidget()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    itemCount: ctrl.transactions.length,
                    itemBuilder: (context, index) {
                      final tx = ctrl.transactions[index];
                      return _TransactionItem(transaction: tx);
                    },
                  ),
      ),
    );
  }

  void _showFilterSheet() {
    Get.bottomSheet(
      Container(
        color: AppColor.white,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("All", style: AppFontStyle.styleW600(AppColor.black, 16)),
                onTap: () {
                  controller.onChangeFilter("All");
                  Get.back();
                },
              ),
              ListTile(
                title: Text("Agent Transfer", style: AppFontStyle.styleW600(AppColor.black, 16)),
                onTap: () {
                  controller.onChangeFilter("Agent Transfer");
                  Get.back();
                },
              ),
              ListTile(
                title: Text("Commission", style: AppFontStyle.styleW600(AppColor.black, 16)),
                onTap: () {
                  controller.onChangeFilter("Commission");
                  Get.back();
                },
              ),
              ListTile(
                title: Text("Withdrawal", style: AppFontStyle.styleW600(AppColor.black, 16)),
                onTap: () {
                  controller.onChangeFilter("Withdrawal");
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({required this.transaction});

  final IncomeTransaction transaction;

  String get _typeLabel {
    switch (transaction.type) {
      case "agent_transfer":
        return "Transferred to the Agent's account";
      case "commission":
        return "Payment of commission";
      case "withdrawal":
        return "Withdrawal";
      default:
        return transaction.type ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNegative = (transaction.total ?? 0) < 0;
    final negativeColor = AppColor.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.colorBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (transaction.recipientImage != null || transaction.recipientName != null)
                Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.colorBorder),
                  ),
                  child: PreviewProfileImageWidget(
                    image: transaction.recipientImage ?? "",
                    isBanned: false,
                    fit: BoxFit.cover,
                  ),
                ),
              if (transaction.recipientImage != null || transaction.recipientName != null) 8.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _typeLabel,
                      style: AppFontStyle.styleW600(AppColor.darkGrey, 14),
                    ),
                    if (transaction.recipientName != null || transaction.recipientId != null) ...[
                      4.height,
                      Text(
                        "${transaction.recipientName ?? ""} (ID:${transaction.recipientId ?? ""})",
                        style: AppFontStyle.styleW500(AppColor.grayText, 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    4.height,
                    Text(
                      CustomFormatDate.onConvert(transaction.createdAt ?? ""),
                      style: AppFontStyle.styleW400(AppColor.grayText, 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.height,
          _buildAmountRow(transaction, isNegative, negativeColor),
        ],
      ),
    );
  }

  Widget _buildAmountRow(IncomeTransaction tx, bool isNegative, Color negativeColor) {
    final hasSubsidy = tx.subsidy != null && tx.subsidy != 0;
    final hasRevenue = tx.revenue != null && tx.revenue != 0;
    final total = tx.total ?? 0;

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        if (hasSubsidy)
          _amountChip(
            "${isNegative && (tx.subsidy ?? 0) < 0 ? "" : "+"}${CustomFormatNumber.onConvert(tx.subsidy ?? 0)}(subsidy)",
            isNegative && (tx.subsidy ?? 0) < 0 ? negativeColor : AppColor.orange,
          ),
        if (hasRevenue)
          _amountChip(
            "${isNegative && (tx.revenue ?? 0) < 0 ? "" : "+"}${CustomFormatNumber.onConvert(tx.revenue ?? 0)}(revenue)",
            isNegative && (tx.revenue ?? 0) < 0 ? negativeColor : AppColor.green,
          ),
        _amountChip(
          "=${CustomFormatNumber.onConvert(total)}",
          isNegative ? negativeColor : AppColor.darkYellow,
          showCoin: true,
        ),
      ],
    );
  }

  Widget _amountChip(String text, Color color, {bool showCoin = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(text, style: AppFontStyle.styleW600(color, 12)),
        ),
        if (showCoin) ...[4.width, Image.asset(AppAssets.icMyCoin, width: 16)],
      ],
    );
  }
}
