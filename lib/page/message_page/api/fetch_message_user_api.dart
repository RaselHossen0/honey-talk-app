import 'dart:async';
import 'dart:math';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/message_page/model/fetch_message_user_model.dart';

class FetchMessageUserApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchMessageUserModel> callApi({
    required String uid,
    required String token,
    required String type, // all, online, unread
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

    final isFirstPage = startPagination == 0;
    startPagination += 1;

    final random = Random();
    final now = DateTime.now();
    FakeProfilesSet.sampleNames.shuffle();
    final systemEntry = MessageData(
      id: 'system_msg',
      chatTopicId: 'system',
      senderId: 'system',
      message: 'USA Hot list for 20260215! The platform will giv....',
      unreadCount: 0,
      userId: 'system',
      name: 'System message',
      userName: 'system',
      image: '',
      isProfilePicBanned: false,
      isVerified: false,
      isFake: true,
      time: '02-16',
      wealthLevel: null,
      isSystemMessage: true,
      isContactCustomer: false,
    );

    final contactEntry = MessageData(
      id: 'contact_customer',
      chatTopicId: 'contact',
      senderId: 'contact',
      message: 'Happy Valentine babe mmmuuu...',
      unreadCount: 0,
      userId: 'contact',
      name: 'Contact customer...',
      userName: 'contact',
      image: '',
      isProfilePicBanned: false,
      isVerified: false,
      isFake: true,
      time: '02-08',
      wealthLevel: null,
      isSystemMessage: false,
      isContactCustomer: true,
    );

    List<MessageData> generateDummyMessages(int count) {
      return List.generate(count, (index) {
        final userId = 'user_${startPagination}_${index + 1}';
        final messageId = 'msg_${startPagination}_${index + 1}';
        final senderId = 'sender_${random.nextInt(1000)}';
        final name = FakeProfilesSet.sampleNames[index];
        final userName = 'user${random.nextInt(10000)}';
        final profileImage = 'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${random.nextInt(90)}.jpg';
        final msgDate = now.subtract(Duration(days: random.nextInt(10)));
        final timeStr = '${msgDate.month.toString().padLeft(2, '0')}-${msgDate.day.toString().padLeft(2, '0')}';

        return MessageData(
          id: messageId,
          chatTopicId: 'topic_${random.nextInt(5000)}',
          senderId: senderId,
          message: 'Hello! This is a dummy message ${index + 1}',
          unreadCount: index == 0 ? 1 : random.nextInt(3),
          userId: userId,
          name: name,
          userName: userName,
          image: profileImage,
          isProfilePicBanned: random.nextBool(),
          isVerified: random.nextBool(),
          isFake: random.nextBool(),
          time: timeStr,
          wealthLevel: index < 5 ? (random.nextInt(15) + 1) : null,
          isSystemMessage: false,
          isContactCustomer: false,
        );
      });
    }

    final regularMessages = generateDummyMessages(isFirstPage ? 6 + random.nextInt(4) : 8 + random.nextInt(5));
    final messages = isFirstPage ? [systemEntry, contactEntry, ...regularMessages] : regularMessages;

    return FetchMessageUserModel(
      status: true,
      message: 'Dummy message users fetched successfully',
      data: messages,
    );
  }
}
