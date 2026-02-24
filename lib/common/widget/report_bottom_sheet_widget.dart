import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tingle/common/model/fetch_report_reason_model.dart';
import 'package:tingle/common/model/send_report_model.dart';
import 'package:tingle/common/shimmer/report_bottom_sheet_shimmer_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ReportBottomSheetWidget {
  static RxInt selectedReportType = 0.obs;

  static RxBool isLoading = false.obs;
  static FetchReportReasonModel? fetchReportReasonModel;
  static List<Data> reportTypes = [];

  static SendReportModel? sendReportModel;

  static Future<void> onSendReport({required String id, required String type}) async {
    Utils.showToast(text: EnumLocal.txtReportSending.name.tr);

    Get.back();

    if (sendReportModel?.status ?? false) {
      Utils.showToast(text: EnumLocal.txtReportSendSuccess.name.tr);
    } else {
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
    }
  }

  static Future<void> onGetReports() async {
    if (reportTypes.isEmpty) {
      isLoading.value = true;


      if (fetchReportReasonModel?.data != null) {
        reportTypes.addAll(fetchReportReasonModel?.data ?? []);
      }
      isLoading.value = false;
    }
  }

  static void onShow({required BuildContext context, required String id, required String type}) async {
    onGetReports();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: 500,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 65,
              color: AppColor.secondary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.width,
                  Expanded(
                    child: Center(
                      child: Text(
                        EnumLocal.txtReport.name.tr,
                        style: AppFontStyle.styleW700(AppColor.greyBlue, 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondary.withValues(alpha: 0.6),
                      ),
                      child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => isLoading.value
                  ? Expanded(child: ReportBottomSheetShimmerWidget())
                  : Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: reportTypes.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => selectedReportType.value = index,
                              child: Container(
                                height: 46,
                                color: AppColor.transparent,
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Obx(() => ReportRadioButtonUi(isSelected: selectedReportType.value == index)),
                                    12.width,
                                    Text(
                                      reportTypes[index].title ?? "",
                                      style: AppFontStyle.styleW500(AppColor.black, 16),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ),
            Obx(
              () => Visibility(
                visible: !isLoading.value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColor.secondary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            EnumLocal.txtCancel.name.tr,
                            style: AppFontStyle.styleW700(AppColor.secondary, 16),
                          ),
                        ),
                      ),
                      15.width,
                      GestureDetector(
                        onTap: () async => await onSendReport(id: id, type: type),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: AppColor.primaryGradient,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            EnumLocal.txtReport.name.tr,
                            style: AppFontStyle.styleW700(AppColor.white, 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportRadioButtonUi extends StatelessWidget {
  const ReportRadioButtonUi({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColor.transparent,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? null : AppColor.transparent,
              gradient: isSelected ? AppColor.primaryGradient : null,
            ),
            child: Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? AppColor.white : AppColor.primary.withValues(alpha: 0.5), width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
