import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/page/connection_page/widget/Following_widget.dart';
import 'package:tingle/page/connection_page/widget/connection_appbar_widget.dart';
import 'package:tingle/page/connection_page/widget/follower_widget.dart';
import 'package:tingle/page/connection_page/widget/friend_widget.dart';
import 'package:tingle/page/connection_page/widget/visiter_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class ConnectionView extends StatelessWidget {
  const ConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: ConnectionAppBarWidget.onShow(
        context,
      ),
      body: GetBuilder<ConnectionController>(
        builder: (controller) => RefreshIndicator(
          onRefresh: () async {
            await controller.onGetData();
            // await controller.onSearchData();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works
            child: SizedBox(
              height: MediaQuery.of(context).size.height, // Ensures full height for scrolling
              child: TabBarView(
                physics: ClampingScrollPhysics(),
                controller: controller.tabController,
                children: [
                  FriendsWidget(),
                  FollowsWidget(),
                  FollowersWidget(),
                  VisitorsWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<ConnectionController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingConnectionPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
