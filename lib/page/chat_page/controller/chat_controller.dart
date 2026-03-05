import 'dart:async';
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
import 'package:tingle/core/network/chat_socket_service.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/page/chat_page/api/fetch_user_chat_api.dart';
import 'package:tingle/page/chat_page/api/mark_conversation_read_api.dart';
import 'package:tingle/page/chat_page/api/send_message_api.dart';
import 'package:tingle/page/chat_page/model/fetch_user_chat_model.dart';
import 'package:tingle/page/chat_page/model/send_file_to_chat_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/permission.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';
import 'package:vibration/vibration.dart';
import 'package:tingle/page/chat_page/api/reaction_api.dart';

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

  StreamSubscription<Map<String, dynamic>>? _socketMessageSub;
  StreamSubscription<Map<String, dynamic>>? _socketPresenceSub;
  StreamSubscription<Map<String, dynamic>>? _socketTypingSub;
  StreamSubscription<Map<String, dynamic>>? _socketReactionSub;

  OtherUserInfo? otherUser;
  bool get isOnline => otherUser?.isOnline ?? false;
  bool isTyping = false;
  Chat? replyToMessage;
  Timer? _typingDebounce;
  static const _typingDebounceDuration = Duration(milliseconds: 400);

  @override
  void onInit() {
    final argument = Get.arguments;
    Utils.showLog("CHAT ARGUMENT => $argument");

    final Map<String, dynamic> map = argument is Map
        ? Map<String, dynamic>.from(argument)
        : <String, dynamic>{};
    roomId = map[ApiParams.roomId]?.toString() ?? "";
    receiverUserId = map[ApiParams.receiverUserId]?.toString() ?? map['userId']?.toString() ?? "";
    name = map[ApiParams.name]?.toString() ?? "";
    image = map[ApiParams.image]?.toString() ?? "";
    isBanned = map[ApiParams.isBanned] == true;
    isVerify = map[ApiParams.isVerify] == true;

    scrollController.addListener(onPaginationUserChat);
    channelName = GenerateRandomName.onGenerate();
    _initChatAndSocket();
    super.onInit();
  }

  @override
  void onClose() {
    _typingDebounce?.cancel();
    _socketMessageSub?.cancel();
    _socketPresenceSub?.cancel();
    _socketTypingSub?.cancel();
    _socketReactionSub?.cancel();
    if (roomId.isNotEmpty) {
      ChatSocketService.instance.emitTyping(roomId, false);
      ChatSocketService.instance.leaveTopic(roomId);
    }
    super.onClose();
  }

  void setReplyToMessage(Chat? message) {
    replyToMessage = message;
    update([AppConstant.onFetchUserChat]);
  }

  void clearReplyToMessage() {
    replyToMessage = null;
    update([AppConstant.onFetchUserChat]);
  }

  void onTypingDebounce() {
    _typingDebounce?.cancel();
    _typingDebounce = Timer(_typingDebounceDuration, () {
      if (roomId.isNotEmpty) {
        final isTypingNow = messageController.text.trim().isNotEmpty;
        ChatSocketService.instance.emitTyping(roomId, isTypingNow);
      }
    });
  }

  void updateReactionFromSocket(String messageId, String userId, String emoji, bool added) {
    final idx = chatList.indexWhere((c) => c.id == messageId);
    if (idx < 0) return;
    final chat = chatList[idx];
    final newReactions = List<MessageReaction>.from(chat.reactions);
    if (added) {
      newReactions.removeWhere((r) => r.userId == userId);
      newReactions.add(MessageReaction(userId: userId, emoji: emoji));
    } else {
      newReactions.removeWhere((r) => r.userId == userId);
    }
    chatList[idx] = chat.copyWith(reactions: newReactions);
    update([AppConstant.onFetchUserChat]);
  }

  Future<void> addReaction(String messageId, String emoji) async {
    final token = await _getToken();
    if (token == null || messageId.isEmpty) return;
    final ok = await ReactionApi.addReaction(token: token, messageId: messageId, emoji: emoji);
    if (ok) {
      final idx = chatList.indexWhere((c) => c.id == messageId);
      if (idx >= 0) {
        final chat = chatList[idx];
        final newReactions = List<MessageReaction>.from(chat.reactions);
        newReactions.removeWhere((r) => r.userId == Database.loginUserId);
        newReactions.add(MessageReaction(userId: Database.loginUserId, emoji: emoji));
        chatList[idx] = chat.copyWith(reactions: newReactions);
        update([AppConstant.onFetchUserChat]);
      }
    }
  }

  Future<void> removeReaction(String messageId) async {
    final token = await _getToken();
    if (token == null || messageId.isEmpty) return;
    final ok = await ReactionApi.removeReaction(token: token, messageId: messageId);
    if (ok) {
      final idx = chatList.indexWhere((c) => c.id == messageId);
      if (idx >= 0) {
        final chat = chatList[idx];
        final newReactions = chat.reactions.where((r) => r.userId != Database.loginUserId).toList();
        chatList[idx] = chat.copyWith(reactions: newReactions);
        update([AppConstant.onFetchUserChat]);
      }
    }
  }

  Future<void> _initChatAndSocket() async {
    final token = await _getToken();
    if (token != null && token.isNotEmpty) {
      ChatSocketService.instance.connect(token);
    }
    await onRefreshUserChat();
    otherUser = fetchUserChatModel?.otherUser;
    update([AppConstant.onFetchUserChat]);
    if (roomId.isNotEmpty) {
      ChatSocketService.instance.joinTopic(roomId);
      _socketMessageSub = ChatSocketService.instance.onMessage.listen(_onSocketMessage);
      _socketPresenceSub = ChatSocketService.instance.onPresence.listen((data) {
        final uid = data['userId'] as String?;
        if (uid == receiverUserId && otherUser != null) {
          otherUser = otherUser!.copyWith(isOnline: data['isOnline'] as bool? ?? false);
          update([AppConstant.onFetchUserChat]);
        }
      });
      _socketTypingSub = ChatSocketService.instance.onTyping.listen((data) {
        if (data['chatTopicId'] != roomId) return;
        if (data['userId'] == Database.loginUserId) return;
        isTyping = data['isTyping'] as bool? ?? false;
        update([AppConstant.onFetchUserChat]);
      });
      _socketReactionSub = ChatSocketService.instance.onReaction.listen((data) {
        final topicId = data['chatTopicId'] as String?;
        if (topicId != roomId) return;
        final msgId = data['messageId'] as String?;
        final uid = data['userId'] as String?;
        final emoji = data['emoji'] as String? ?? '';
        final added = data['added'] as bool? ?? true;
        if (msgId != null && uid != null) updateReactionFromSocket(msgId, uid, emoji, added);
      });
    }
  }

  void _onSocketMessage(Map<String, dynamic> data) {
    final topicId = data['chatTopicId'] as String?;
    if (topicId == null || topicId != roomId) return;
    try {
      final chat = Chat.fromJson(data);
      if (chatList.any((c) => c.id == chat.id)) return;
      chatList.add(chat);
      update([AppConstant.onFetchUserChat]);
      onScrollDown();
    } catch (e) {
      Utils.showLog("Socket message parse error: $e");
    }
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

  Future<String?> _getToken() async => await FirebaseAccessToken.onGet();

  Future<void> onRefreshUserChat() async {
    isLoading = true;
    chatList.clear();
    update([AppConstant.onFetchUserChat]);

    final token = await _getToken();
    if (token == null || token.isEmpty) {
      isLoading = false;
      update([AppConstant.onFetchUserChat]);
      return;
    }

    fetchUserChatModel = await FetchUserChatApi.callApi(
      token: token,
      chatTopicId: roomId.isNotEmpty ? roomId : null,
      otherUserId: receiverUserId.isNotEmpty ? receiverUserId : null,
      limit: FetchUserChatApi.defaultLimit,
      offset: 0,
    );

    roomId = fetchUserChatModel?.chatTopic ?? roomId;
    otherUser = fetchUserChatModel?.otherUser ?? otherUser;
    final chat = fetchUserChatModel?.chat ?? [];
    chatList.insertAll(0, chat.reversed);
    isLoading = false;
    update([AppConstant.onFetchUserChat]);
    onScrollDown();
    if (roomId.isNotEmpty) {
      MarkConversationReadApi.callApi(token: token, chatTopicId: roomId);
    }
  }

  Future<void> onFetchUserChat() async {
    roomId = fetchUserChatModel?.chatTopic ?? roomId;
    final chat = fetchUserChatModel?.chat ?? [];
    chatList.insertAll(0, chat.reversed);
    isLoading = false;
    update([AppConstant.onFetchUserChat]);
  }

  Future<void> onPaginationUserChat() async {
    if (scrollController.position.pixels != scrollController.position.minScrollExtent) return;
    if (chatList.isEmpty) return;

    final token = await _getToken();
    if (token == null || token.isEmpty) return;

    isPagination = true;
    update([AppConstant.onPaginationUserChat]);

    final firstId = chatList.first.id;
    fetchUserChatModel = await FetchUserChatApi.callApi(
      token: token,
      chatTopicId: roomId.isNotEmpty ? roomId : null,
      otherUserId: receiverUserId.isNotEmpty ? receiverUserId : null,
      limit: FetchUserChatApi.defaultLimit,
      before: firstId,
    );

    final older = fetchUserChatModel?.chat ?? [];
    if (older.isNotEmpty) {
      chatList.insertAll(0, older.reversed);
    }

    isPagination = false;
    update([AppConstant.onPaginationUserChat]);
  }

  //******************************************************************************************************************************************

  Future<void> onClickSend() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final token = await _getToken();
    if (token == null || token.isEmpty) return;

    final replyToId = replyToMessage?.id;
    if (roomId.isNotEmpty) ChatSocketService.instance.emitTyping(roomId, false);

    final optimistic = Chat(
      messageType: 1,
      message: text,
      date: DateTime.now().toIso8601String(),
      senderId: Database.loginUserId,
      replyTo: replyToMessage?.replyTo,
    );
    chatList.add(optimistic);
    messageController.clear();
    setReplyToMessage(null);
    update([AppConstant.onFetchUserChat]);
    onScrollDown();

    final result = await SendMessageApi.sendText(
      token: token,
      chatTopicId: roomId.isNotEmpty ? roomId : null,
      otherUserId: receiverUserId.isNotEmpty ? receiverUserId : null,
      message: text,
      replyToId: replyToId,
    );
    if (result.chatTopicId != null && roomId.isEmpty) {
      roomId = result.chatTopicId!;
      ChatSocketService.instance.joinTopic(roomId);
      _socketMessageSub?.cancel();
      _socketMessageSub = ChatSocketService.instance.onMessage.listen(_onSocketMessage);
    }
    if (result.chat != null) {
      final idx = chatList.indexWhere((c) => c.message == text && (c.id == null || c.id!.isEmpty));
      if (idx >= 0) chatList[idx] = result.chat!;
      update([AppConstant.onFetchUserChat]);
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
