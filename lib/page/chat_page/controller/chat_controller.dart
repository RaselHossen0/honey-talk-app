import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingle/common/function/generate_random_name.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/custom/function/custom_image_picker.dart';
import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';
import 'package:tingle/page/chat_page/model/fetch_user_chat_model.dart';
import 'package:tingle/page/chat_page/model/send_file_to_chat_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/permission.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';
import 'package:vibration/vibration.dart';

class ChatController extends GetxController {
  // GET ARGUMENT FROM [MESSAGE_PAGE, SEARCH_PAGE]

  String roomId = "";
  String receiverUserId = "";
  String name = "";
  String image = "";
  bool isBanned = false;
  bool isVerify = false;

  // FETCH OLD CHAT BETWEEN TWO USER
  bool isLoading = false;
  FetchUserChatModel? fetchUserChatModel;
  bool isPagination = false;

  List<Chat> chatList = [];

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  // SEND FILE ON CHAT

  SendFileToChatModel? sendFileToChatModel;

  //--------------

  String channelName = "";

  @override
  void onInit() {
    final argument = Get.arguments;
    Utils.showLog("CHAT ARGUMENT => $argument");

    roomId = argument[ApiParams.roomId]; // IF USER ALREADY CREATE ROOM THEN GET ROOM ID ELSE GET ROOM ID IN FETCH CHAT API...
    receiverUserId = argument[ApiParams.receiverUserId]; // SENDER MEAN LOGIN USER AND RECEIVER MEAN OTHER USER...
    name = argument[ApiParams.name];
    image = argument[ApiParams.image];
    isBanned = argument[ApiParams.isBanned];
    isVerify = argument[ApiParams.isVerify];

    onRefreshUserChat();
    scrollController.addListener(onPaginationUserChat);
    channelName = channelName = GenerateRandomName.onGenerate();
    super.onInit();
  }

  @override
  void onClose() {
    onRefreshUserChat(); // Use To Read Latest Messages...
    super.onClose();
  }

  Future<void> onClickVideoCall() async {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

    Utils.showLog("Video Calling...");

    Vibration.vibrate(duration: 50, amplitude: 128);

    AppPermission.onGetCameraPermission(
      onGranted: () {
        AppPermission.onGetMicrophonePermission(
          onGranted: () async {
            await Random().nextInt(500).milliseconds.delay();
            Get.back(); // Stop Loading...
          },
          onDenied: () => Get.back(), // Stop Loading...
        );
      },
      onDenied: () => Get.back(), // Stop Loading...
    );
  }

  // *****************************************************************************************************************************

  Future<void> onRefreshUserChat() async {
    isLoading = true;
    chatList.clear();
    update([AppConstant.onFetchUserChat]);
    await onFetchUserChat();
    onScrollDown();
  }

  Future<void> onFetchUserChat() async {
    roomId = fetchUserChatModel?.chatTopic ?? "";
    final chat = fetchUserChatModel?.chat ?? [];
    chatList.insertAll(0, chat.reversed); // REVERSED USE TO SHOW NEW MESSAGE ON TOP...
    isLoading = false;
    update([AppConstant.onFetchUserChat]);
    if (fetchUserChatModel?.chat?.isEmpty ?? true) {}
  }

  Future<void> onPaginationUserChat() async {
    if (scrollController.position.pixels == scrollController.position.minScrollExtent) {
      isPagination = true;
      update([AppConstant.onPaginationUserChat]);
      await onFetchUserChat();
      isPagination = false;
      update([AppConstant.onPaginationUserChat]);
    }
  }

  //******************************************************************************************************************************************

  Future<void> onClickSend() async {
    if (messageController.text.trim().isNotEmpty) {
      chatList.add(
        // ADD FAKE TEXT MESSAGE FOR REAL TIME UPDATE..

        Chat(
          messageType: 1,
          message: messageController.text.trim(),
          date: DateTime.now().toString(),
          senderId: Database.loginUserId,
        ),
      );

      onScrollDown();

      update([AppConstant.onFetchUserChat]);

      messageController.clear();
    }
  }

  Future<void> onClickImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await CustomImagePickerBottomSheetWidget.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);
        if (imagePath != null) onSendImage(imagePath);
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);
        if (imagePath != null) onSendImage(imagePath);
      },
    );
  }

  Future<void> onSendImage(String imagePath) async {
    chatList.add(Chat(messageType: 2, date: DateTime.now().toString(), senderId: Database.loginUserId)); // USE TO => (ADD) IMAGE UPLOAD TIME SHOW PLACEHOLDER...
    update([AppConstant.onFetchUserChat]);

    onScrollDown();

    chatList.removeLast(); // USE TO => (REMOVE) IMAGE UPLOAD TIME SHOW PLACEHOLDER...
  }

  //******************************************************************************************************************************************

  Future<void> onGetMessageFromSocket({required Map message}) async {
    try {
      chatList.removeWhere((chat) => chat.createdAt?.isEmpty ?? true); // FAKE SHOW TEXT MESSAGE REMOVE FROM LIST...

      chatList.add(
        Chat(
          message: message[SocketParams.message],
          messageType: message[SocketParams.messageType],
          senderId: message[SocketParams.senderId],
          image: message[SocketParams.message],
          date: message[SocketParams.date],
          createdAt: message[SocketParams.date],
        ),
      );

      update([AppConstant.onFetchUserChat]);

      await onScrollDown();

      // if (message[SocketParams.messageId] != null) SocketEmit.onMessageSeen(messageId: message[SocketParams.messageId]); // READ NEW INCOMING MESSAGE...
    } catch (e) {
      Utils.showLog("New Message Get Filed => $e");
    }
  }

  //******************************************************************************************************************************************

  Future<void> onScrollDown() async {
    try {
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      update([AppConstant.onFetchUserChat]);
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }
}
