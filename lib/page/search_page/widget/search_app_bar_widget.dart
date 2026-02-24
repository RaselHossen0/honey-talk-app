import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/search_page/controller/search_controller.dart' as controller;
import 'package:tingle/common/widget/search_text_field_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class SearchAppBarWidget {
  static PreferredSizeWidget onShow(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top + 60),
      child: Container(
        height: MediaQuery.of(context).viewPadding.top + 60,
        width: Get.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                child: Image.asset(AppAssets.icArrowLeft, width: 10),
              ),
            ),
            Expanded(
              child: GetBuilder<controller.SearchController>(
                id: AppConstant.onGetSearchUser,
                builder: (controller) => SearchTextFieldWidget(
                  hintText: "ID number or nickname",
                  controller: controller.searchController,
                  isShowClearIcon: controller.searchController.text.trim().isNotEmpty,
                  onChanged: (value) => controller.onChangeSearch(),
                  onClickClear: controller.onClearSearch,
                  onTap: () => controller.onChangeSearchHistory(false),
                ),
              ),
            ),
            15.width,
          ],
        ),
      ),
    );
  }
}
