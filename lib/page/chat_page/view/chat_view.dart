import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/chat_page/controller/chat_controller.dart';
import 'package:tingle/page/chat_page/widget/chat_app_bar_widget.dart';
import 'package:tingle/page/chat_page/widget/chat_text_field_widget.dart';
import 'package:tingle/page/chat_page/widget/receiver_image_widget.dart';
import 'package:tingle/page/chat_page/widget/receiver_message_widget.dart';
import 'package:tingle/page/chat_page/widget/receiver_video_call_widget.dart';
import 'package:tingle/page/chat_page/widget/sender_image_widget.dart';
import 'package:tingle/page/chat_page/widget/sender_message_widget.dart';
import 'package:tingle/page/chat_page/widget/sender_video_call_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      appBar: ChatAppBarWidget.appBar(
        context: context,
        name: controller.name,
        image: controller.image,
        isBanned: controller.isBanned,
        isVerify: controller.isVerify,
      ),
      body: Stack(
        children: [
          Image.asset(
            height: Get.height,
            width: Get.width,
            AppAssets.imgChatBg,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  child: GetBuilder<ChatController>(
                    id: AppConstant.onFetchUserChat,
                    builder: (controller) => controller.isLoading
                        ? LoadingWidget()
                        : SingleChildScrollView(
                            controller: controller.scrollController,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                GetBuilder<ChatController>(
                                  id: AppConstant.onPaginationUserChat,
                                  builder: (controller) => Visibility(
                                    visible: controller.isPagination,
                                    child: LinearProgressIndicator(color: AppColor.primary),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.chatList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(top: 15),
                                  itemBuilder: (context, index) {
                                    final indexData = controller.chatList[index];

                                    return indexData.senderId == Database.loginUserId
                                        ? indexData.messageType == 1 // TEXT MESSAGE
                                            ? SenderMessageWidget(
                                                message: indexData.message ?? "",
                                                time: indexData.createdAt ?? "",
                                              )
                                            : indexData.messageType == 2 // IMAGE MESSAGE
                                                ? SenderImageWidget(
                                                    image: indexData.image ?? "",
                                                    time: indexData.createdAt ?? "",
                                                    isBanned: indexData.isMediaBanned ?? false,
                                                  )
                                                : indexData.messageType == 3 // VIDEO CALL MESSAGE
                                                    ? SenderVideoCallWidget(
                                                        time: indexData.createdAt ?? "",
                                                        type: indexData.callType ?? 0,
                                                        callDuration: indexData.callDuration ?? "",
                                                      )
                                                    : Offstage()
                                        : indexData.messageType == 1 // TEXT MESSAGE
                                            ? ReceiverMessageWidget(
                                                message: indexData.message ?? "",
                                                time: indexData.createdAt ?? "",
                                                profileImage: controller.image,
                                                profileImageIsBanned: controller.isBanned,
                                              )
                                            : indexData.messageType == 2 // IMAGE MESSAGE
                                                ? ReceiverImageWidget(
                                                    image: indexData.image ?? "",
                                                    time: indexData.createdAt ?? "",
                                                    isBanned: indexData.isMediaBanned ?? false,
                                                    receiverImage: controller.image,
                                                    receiverImageIsBanned: controller.isBanned,
                                                  )
                                                : indexData.messageType == 3 // VIDEO CALL MESSAGE
                                                    ? ReceiverVideoCallWidget(
                                                        callDuration: indexData.callDuration ?? "",
                                                        type: indexData.callType ?? 0,
                                                        time: indexData.createdAt ?? "",
                                                      )
                                                    : Offstage();
                                  },
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                const ChatTextFieldWidget(),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const ChatBottomBarWidget(),
    );
  }
}
