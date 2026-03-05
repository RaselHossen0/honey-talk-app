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

String _emojiChar(String name) {
  const m = {
    'like': '👍',
    'love': '❤️',
    'laugh': '😂',
    'wow': '😮',
    'sad': '😢',
    'angry': '😠',
    'heart': '❤️',
    'thumbsup': '👍',
  };
  return m[name] ?? '👍';
}

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
        isOnline: controller.isOnline,
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
                GetBuilder<ChatController>(
                  id: AppConstant.onFetchUserChat,
                  builder: (c) => c.isTyping
                      ? Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${c.name} is typing...",
                            style: TextStyle(color: AppColor.secondary, fontSize: 12),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
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
                                    final replyPreview = indexData.replyTo?.message;
                                    final reactionEmojis = indexData.reactions.map((r) => r.emoji ?? '').where((e) => e.isNotEmpty).toList();

                                    Widget senderText() => SenderMessageWidget(
                                          message: indexData.message ?? "",
                                          time: indexData.createdAt ?? "",
                                          replyToMessage: replyPreview,
                                          reactions: reactionEmojis,
                                        );
                                    Widget receiverText() => ReceiverMessageWidget(
                                          message: indexData.message ?? "",
                                          time: indexData.createdAt ?? "",
                                          profileImage: controller.image,
                                          profileImageIsBanned: controller.isBanned,
                                          replyToMessage: replyPreview,
                                          reactions: reactionEmojis,
                                        );

                                    void showMessageActions() {
                                      if (indexData.id == null || indexData.id!.isEmpty) return;
                                      Get.bottomSheet(
                                        Container(
                                          color: AppColor.white,
                                          padding: const EdgeInsets.symmetric(vertical: 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: const Icon(Icons.reply),
                                                title: const Text('Reply'),
                                                onTap: () {
                                                  Get.back();
                                                  controller.setReplyToMessage(indexData);
                                                },
                                              ),
                                              const Divider(height: 1),
                                              const Padding(
                                                padding: EdgeInsets.only(left: 16, top: 8, bottom: 4),
                                                child: Align(alignment: Alignment.centerLeft, child: Text('React', style: TextStyle(fontWeight: FontWeight.w600))),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: ['like', 'love', 'laugh', 'wow', 'sad', 'angry', 'heart', 'thumbsup']
                                                      .map((emoji) => InkWell(
                                                            onTap: () {
                                                              Get.back();
                                                              controller.addReaction(indexData.id!, emoji);
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8),
                                                              child: Text(_emojiChar(emoji), style: const TextStyle(fontSize: 28)),
                                                            ),
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                              if (indexData.reactions.any((r) => r.userId == Database.loginUserId))
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                    controller.removeReaction(indexData.id!);
                                                  },
                                                  child: const Text('Remove my reaction'),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }

                                    return indexData.senderId == Database.loginUserId
                                        ? indexData.messageType == 1
                                            ? GestureDetector(onLongPress: showMessageActions, child: senderText())
                                            : indexData.messageType == 2
                                                ? SenderImageWidget(image: indexData.image ?? "", time: indexData.createdAt ?? "", isBanned: indexData.isMediaBanned ?? false)
                                                : indexData.messageType == 3
                                                    ? SenderVideoCallWidget(time: indexData.createdAt ?? "", type: indexData.callType ?? 0, callDuration: indexData.callDuration ?? "")
                                                    : Offstage()
                                        : indexData.messageType == 1
                                            ? GestureDetector(onLongPress: showMessageActions, child: receiverText())
                                            : indexData.messageType == 2
                                                ? ReceiverImageWidget(image: indexData.image ?? "", time: indexData.createdAt ?? "", isBanned: indexData.isMediaBanned ?? false, receiverImage: controller.image, receiverImageIsBanned: controller.isBanned)
                                                : indexData.messageType == 3
                                                    ? ReceiverVideoCallWidget(callDuration: indexData.callDuration ?? "", type: indexData.callType ?? 0, time: indexData.createdAt ?? "")
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
