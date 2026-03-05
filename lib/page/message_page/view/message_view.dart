import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/page/message_page/controller/message_controller.dart';
import 'package:tingle/page/message_page/widget/message_app_bar_widget.dart';
import 'package:tingle/page/message_page/widget/message_banners_widget.dart';
import 'package:tingle/page/message_page/widget/message_live_females_widget.dart';
import 'package:tingle/page/message_page/widget/message_user_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<MessageController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessageController>();
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    Utils.onChangeExtendBody(false);
    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const MessageAppBarWidget(),
                if ((Database.fetchLoginUserProfile()?.user?.gender ?? '').toLowerCase() == 'male')
                  const MessageLiveFemalesWidget(),
                const MessageBannersWidget(),
                Expanded(
                  child: GetBuilder<MessageController>(
                    id: AppConstant.onFetchMessageUser,
                    builder: (ctrl) {
                      if (ctrl.isLoading) {
                        return UserListShimmerWidget();
                      }
                      if (ctrl.messageUsers.isEmpty) {
                        return RefreshIndicator(
                          color: AppColor.primary,
                          onRefresh: () async => await controller.onRefresh(millisecondsDelay: 0),
                          child: LayoutBuilder(
                            builder: (context, constraints) => SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                                child: NoDataFoundWidget(title: EnumLocal.txtNoChatsYetStartAConversation.name.tr),
                              ),
                            ),
                          ),
                        );
                      }
                      return RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async => await controller.onRefresh(millisecondsDelay: 0),
                        child: ListView.builder(
                          itemCount: ctrl.messageUsers.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final indexData = ctrl.messageUsers[index];
                            final displayName = indexData.isSystemMessage == true
                                ? EnumLocal.txtSystemMessage.name.tr
                                : indexData.isContactCustomer == true
                                    ? EnumLocal.txtContactCustomer.name.tr
                                    : (indexData.name ?? "");
                            return MessageUserWidget(
                              title: displayName,
                              subTitle: indexData.message ?? "",
                              leading: indexData.image ?? "",
                              dateTime: indexData.time,
                              messageCount: indexData.unreadCount ?? 0,
                              isVerified: indexData.isVerified ?? false,
                              isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                              wealthLevel: indexData.wealthLevel,
                              isOnline: indexData.isOnline,
                              callback: () => indexData.isFake ?? true
                                  ? Get.toNamed(
                                      AppRoutes.fakeChatPage,
                                      arguments: {
                                        ApiParams.roomId: indexData.id ?? "",
                                        ApiParams.receiverUserId: indexData.userId ?? "",
                                        ApiParams.name: indexData.name ?? "",
                                        ApiParams.image: indexData.image ?? "",
                                        ApiParams.isBanned: indexData.isProfilePicBanned ?? false,
                                        ApiParams.isVerify: indexData.isVerified ?? false,
                                      },
                                    )?.then((value) => controller.onRefresh(millisecondsDelay: 1000))
                                  : Get.toNamed(
                                      AppRoutes.chatPage,
                                      arguments: {
                                        ApiParams.roomId: indexData.id ?? "",
                                        ApiParams.receiverUserId: indexData.userId ?? "",
                                        ApiParams.name: indexData.name ?? "",
                                        ApiParams.image: indexData.image ?? "",
                                        ApiParams.isBanned: indexData.isProfilePicBanned ?? false,
                                        ApiParams.isVerify: indexData.isVerified ?? false,
                                      },
                                    )?.then((value) => controller.onRefresh(millisecondsDelay: 1000)),
                            );
                          },
                                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
