import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/message_page/widget/message_user_widget.dart';
import 'package:tingle/page/search_message_user_page/controller/search_message_user_controller.dart';
import 'package:tingle/page/search_message_user_page/widget/search_message_user_app_bar_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class SearchMessageUserView extends GetView<SearchMessageUserController> {
  const SearchMessageUserView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: SearchMessageUserAppBarWidget.onShow(context),
      body: GetBuilder<SearchMessageUserController>(
        id: AppConstant.onFetchMessageUser,
        builder: (controller) => controller.isLoading
            ? UserListShimmerWidget()
            : controller.messageUsers.isEmpty
                ? NoDataFoundWidget(title: EnumLocal.txtNoChatsYetStartAConversation.name.tr)
                : SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.messageUsers.length,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final indexData = controller.messageUsers[index];
                        return MessageUserWidget(
                          title: indexData.name ?? "",
                          subTitle: indexData.userName ?? "",
                          leading: indexData.image ?? "",
                          dateTime: "2024-04-05",
                          messageCount: 0,
                          isVerified: indexData.isVerified ?? false,
                          isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                          callback: () => Get.toNamed(
                            AppRoutes.chatPage,
                            arguments: {
                              ApiParams.roomId: indexData.id ?? "",
                              ApiParams.receiverUserId: indexData.id ?? "",
                              ApiParams.name: indexData.name ?? "",
                              ApiParams.image: indexData.image ?? "",
                              ApiParams.isBanned: indexData.isProfilePicBanned ?? false,
                              ApiParams.isVerify: indexData.isVerified ?? false,
                            },
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
