import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';

import 'package:tingle/page/connection_page/widget/search_connection_appbar_widget.dart';
import 'package:tingle/page/connection_page/widget/search_connection_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class SearchConnectionView extends StatelessWidget {
  const SearchConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: SearchConnectionAppBarWidget.onShow(
        context,
      ),
      body: GetBuilder<ConnectionController>(id: AppConstant.onSearchConnection, builder: (controller) => SearchConnectionWidget()),
      bottomNavigationBar: GetBuilder<ConnectionController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
