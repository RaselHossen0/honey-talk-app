import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/page/connection_page/widget/search_connection_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class SearchConnectionAppBarWidget {
  static PreferredSizeWidget onShow(BuildContext context, {String? title, int? count}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top + 60),
      child: GetBuilder<ConnectionController>(
          id: AppConstant.onTabBarTap,
          builder: (controller) {
            return Container(
              width: Get.width,
              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                          child: GetBuilder<ConnectionController>(
                        id: AppConstant.onSearchConnection,
                        builder: (controller) => SearchTextFieldConnectionWidget(
                            onClickClear: () {
                              controller.searchController.clear();
                              controller.searchData.clear();
                              controller.onSearchChanged(controller.searchController.text);
                              controller.isSearchLoading = true;

                              controller.update([AppConstant.onSearchConnection]);
                            },
                            controller: controller.searchController,
                            onChanged: (value) async {
                              controller.searchData.clear();
                              controller.onSearchChanged(value);
                              controller.isSearchLoading = true;

                              controller.update([AppConstant.onSearchConnection]);
                            },
                            isShowClearIcon: controller.isSearchLoading,
                            onTap: () {},
                            hintText: EnumLocal.txtEnterNickNameOrChatHistory.name.tr),
                      )),
                      5.width
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
