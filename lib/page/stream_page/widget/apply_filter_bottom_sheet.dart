import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/country_flag_icon.dart';
import 'package:tingle/common/function/country_services.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ApplyFilterBottomSheet {
  static RxBool isLoading = false.obs;

  static void onInit() async {
    isLoading.value = true;
    await 500.milliseconds.delay();
    isLoading.value = false;
  }

  static Future<void> show({required BuildContext context}) async {
    onInit();
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: Get.height / 2,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 65,
              color: AppColor.secondary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  50.width,
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColor.grayText.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      10.height,
                      Text(
                        "Apply Filter",
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
            Expanded(
              child: Obx(
                () => isLoading.value
                    ? LoadingWidget()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          15.height,
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "Country",
                              style: AppFontStyle.styleW700(AppColor.black, 17),
                            ),
                          ),
                          8.height,
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Wrap(
                                  spacing: 15,
                                  alignment: WrapAlignment.start,
                                  children: [
                                    for (int index = 0; index < CountryService.countries.length; index++)
                                      GetBuilder<StreamController>(
                                        id: AppConstant.onChangeCountry,
                                        builder: (controller) => GestureDetector(
                                          onTap: () => controller.onChangeCountry((CountryService.countries[index].name ?? "").toLowerCase()),
                                          child: Chip(
                                            padding: const EdgeInsets.only(top: 7, bottom: 7, right: 7, left: 5),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                            deleteIconColor: AppColor.black,
                                            elevation: 0,
                                            autofocus: false,
                                            deleteIcon: Padding(
                                              padding: const EdgeInsets.only(right: 4),
                                              child: Image.asset(AppAssets.icClose, height: 50, width: 50, color: AppColor.pink),
                                            ),
                                            backgroundColor: controller.selectedCountry == (CountryService.countries[index].name)?.toLowerCase() ? AppColor.primary : AppColor.lightGrayBg,
                                            side: BorderSide(width: 0.8, color: AppColor.transparent),
                                            label: RichText(
                                              text: TextSpan(
                                                text: CountryFlagIcon.onShow(CountryService.countries[index].emoji ?? ""),
                                                children: [
                                                  TextSpan(
                                                    text: "  ${CountryService.countries[index].name ?? ""}",
                                                    style: controller.selectedCountry == (CountryService.countries[index].name)?.toLowerCase()
                                                        ? AppFontStyle.styleW600(AppColor.white, 13)
                                                        : AppFontStyle.styleW500(AppColor.lightGreyPurple, 12),
                                                  ),
                                                ],
                                                style: AppFontStyle.styleW500(AppColor.white, 14),
                                              ),
                                            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
