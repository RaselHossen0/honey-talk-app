import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/other_user_connection_page/controller/other_user_connection_controller.dart';
import 'package:tingle/page/other_user_connection_page/widget/other_user_connection_appbar_widget.dart';
import 'package:tingle/page/other_user_connection_page/widget/other_user_follower_widget.dart';
import 'package:tingle/page/other_user_connection_page/widget/other_user_following_widget.dart';
import 'package:tingle/page/other_user_connection_page/widget/other_user_friend_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class OtherUserConnectionView extends StatelessWidget {
  const OtherUserConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 300);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: OtherUserConnectionAppBarWidget.onShow(
        context,
      ),
      body: GetBuilder<OtherUserConnectionController>(
        builder: (controller) => RefreshIndicator(
          onRefresh: () async {
            await controller.onGetData();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works
            child: SizedBox(
              height: MediaQuery.of(context).size.height, // Ensures full height for scrolling
              child: TabBarView(
                physics: ClampingScrollPhysics(),
                controller: controller.tabController,
                children: [
                  OtherUserFriendsWidget(),
                  OtherUserFollowsWidget(),
                  OtherUserFollowersWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<OtherUserConnectionController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingConnectionPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
