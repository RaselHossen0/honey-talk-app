import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/page/connection_page/widget/have_visited_widget.dart';
import 'package:tingle/page/connection_page/widget/myvisitor_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class VisitorsWidget extends StatelessWidget {
  const VisitorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
        id: AppConstant.onChangeFollowUpdate,
        builder: (controller) => SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  5.height,
                  Container(
                    width: max(255, Get.width * 0.6),
                    decoration: BoxDecoration(
                      color: AppColor.lightGrayBg,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: TabBar(
                      padding: EdgeInsets.zero,
                      isScrollable: false,
                      controller: controller.visitTabController,
                      indicator: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      unselectedLabelColor: AppColor.secondary,
                      labelColor: AppColor.black,
                      dividerColor: Colors.transparent,
                      labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      overlayColor: WidgetStatePropertyAll(AppColor.transparent),
                      onTap: (value) {},
                      tabAlignment: TabAlignment.center,
                      tabs: [
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              EnumLocal.txtMyVisitors.name.tr,
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              EnumLocal.txtWhoIHaveVisited.name.tr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(controller: controller.visitTabController, children: [
                      MyVisitorWidget(),
                      HaveVisitedWidget(),
                    ]),
                  )
                ],
              ),
            ));
  }
}
