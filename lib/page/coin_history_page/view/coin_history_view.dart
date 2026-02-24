import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/custom/function/custom_format_date.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/custom/function/custom_range_picker.dart';
import 'package:tingle/page/coin_history_page/controller/coin_history_controller.dart';
import 'package:tingle/page/coin_history_page/widget/coin_box_widget.dart';
import 'package:tingle/page/coin_history_page/widget/coin_history_app_bar_widget.dart';
import 'package:tingle/page/coin_history_page/widget/coin_history_shimmer_ui.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CoinHistoryView extends GetView<CoinHistoryController> {
  const CoinHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CoinHistoryAppBarWidget.onShow(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.height,
            CoinBoxWidget(),
            15.height,
            Row(
              children: [
                Text(
                  EnumLocal.txtCoinHistory.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    DateTimeRange? dateTimeRange = await CustomRangePicker.onShow(context);
                    if (dateTimeRange != null) {
                      String startDate = DateFormat('yyyy-MM-dd').format(dateTimeRange.start);
                      String endDate = DateFormat('yyyy-MM-dd').format(dateTimeRange.end);

                      final range = "${DateFormat('dd MMM').format(dateTimeRange.start)} - ${DateFormat('dd MMM').format(dateTimeRange.end)}";

                      Utils.showLog("Selected Date Range => $range");

                      controller.onChangeDate(startDate: startDate, endDate: endDate, rangeDate: range);

                      controller.onGetCoinHistory();
                    }
                  },
                  child: Container(
                    height: 35,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.secondary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GetBuilder<CoinHistoryController>(
                          id: AppConstant.onChangeDate,
                          builder: (controller) => Text(
                            controller.rangeDate,
                            style: AppFontStyle.styleW500(AppColor.darkGrey, 12),
                          ),
                        ),
                        8.width,
                        SizedBox(
                          height: 35,
                          width: 12,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(top: 12.5, child: Icon(Icons.keyboard_arrow_down_outlined, size: 19)),
                              Positioned(top: 3.5, child: Icon(Icons.keyboard_arrow_up_rounded, size: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            15.height,
            Expanded(
              child: GetBuilder<CoinHistoryController>(
                id: AppConstant.onGetCoinHistory,
                builder: (controller) => controller.isLoading
                    ? CoinHistoryShimmerUi()
                    : controller.coinHistory.isEmpty
                        ? NoDataFoundWidget()
                        : SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: controller.coinHistory.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final historyIndex = controller.coinHistory[index];
                                return HistoryItemUi(
                                  status: historyIndex.isIncome == true ? 1 : 2,
                                  title: historyType(historyIndex.type ?? 0),
                                  date: historyIndex.createdAt ?? "",
                                  uniqueId: historyIndex.uniqueId ?? "",
                                  coin: (historyIndex.coin ?? 0),
                                  reason: "",
                                );
                              },
                            ),
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HistoryItemUi extends StatelessWidget {
  const HistoryItemUi({
    super.key,
    required this.status,
    required this.title,
    required this.date,
    required this.uniqueId,
    required this.coin,
    required this.reason,
  });

  final String title;
  final String date;
  final String uniqueId;
  final int coin;
  final String reason;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.colorBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          10.width,
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColor.colorBorder.withValues(alpha: 0.6),
              ),
            ),
            child: Center(
              child: Image.asset(AppAssets.icMyCoin, width: 32),
            ),
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppFontStyle.styleW700(
                      status == 0
                          ? AppColor.black
                          : status == 1
                              ? AppColor.green
                              : AppColor.red,
                      13),
                ),
                Text(
                  CustomFormatDate.onConvert(date),
                  style: AppFontStyle.styleW500(AppColor.grayText, 10),
                ),
                2.height,
                Text(
                  "ID : $uniqueId",
                  style: AppFontStyle.styleW500(AppColor.grayText, 10),
                ),
                Visibility(
                  visible: reason != "",
                  child: SizedBox(
                    width: Get.width / 2,
                    child: Text(
                      "Reason : $reason",
                      maxLines: 1,
                      style: AppFontStyle.styleW500(AppColor.grayText, 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.width,
          Container(
            height: 32,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: status == 0
                  ? AppColor.grayText.withValues(alpha: 0.1)
                  : status == 1
                      ? AppColor.green.withValues(alpha: 0.05)
                      : AppColor.red.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "${status == 0 ? "" : status == 1 ? "+" : "-"} ${CustomFormatNumber.onConvert(coin)}",
                style: AppFontStyle.styleW700(
                    status == 0
                        ? AppColor.black
                        : status == 1
                            ? AppColor.green
                            : AppColor.red,
                    15),
              ),
            ),
          ),
          10.width,
        ],
      ),
    );
  }
}

String historyType(int type) {
  switch (type) {
    case 1:
      {
        return "Welcome Bonus Coin";
      }
    case 2:
      {
        return "Purchase Theme";
      }
    case 3:
      {
        return "Purchase Avtar Frame";
      }
    case 4:
      {
        return "Purchase Ride";
      }
    case 5:
      {
        return "Private Video Call";
      }
    case 6:
      {
        return "Live Gift Received";
      }
    case 7:
      {
        return "Coin Plan Purchase";
      }

    default:
      {
        return "";
      }
  }
}
