import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/other_user_connection_page/controller/other_user_connection_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OtherUserConnectionAppBarWidget {
  static PreferredSizeWidget onShow(BuildContext context, {String? title, int? count}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top + 82),
      child: GetBuilder<OtherUserConnectionController>(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text(
                        controller.mainTitle.value,
                        style: AppFontStyle.styleW700(AppColor.black, 18),
                      ),
                      45.width
                    ],
                  ),
                  GetBuilder<OtherUserConnectionController>(
                      id: AppConstant.onTabBarTap,
                      builder: (controller) => Container(
                            height: 60,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: AppColor.lightGrayBg),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TabBar(
                                  padding: EdgeInsets.zero,
                                  isScrollable: true,
                                  controller: controller.tabController,
                                  indicator: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  unselectedLabelColor: AppColor.secondary,
                                  labelColor: AppColor.white,
                                  dividerColor: Colors.transparent,
                                  labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                  indicatorPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                  onTap: (value) {
                                    // controller.onTabChange(value);
                                  },
                                  tabAlignment: TabAlignment.start,
                                  tabs: [
                                    Tab(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Text(
                                          EnumLocal.txtFriends.name.tr,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Text(
                                          EnumLocal.txtFollow.name.tr,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Text(
                                          EnumLocal.txtFollowers.name.tr,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                ],
              ),
            );
          }),
    );
  }
}
