import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:tingle/core/network/api_config.dart';
import 'package:tingle/utils/utils.dart';

/// Real-time chat over Socket.IO. Connect with JWT; listen for [chat:message];
/// optionally join topic room and emit typing.
class ChatSocketService {
  ChatSocketService._();
  static final ChatSocketService _instance = ChatSocketService._();
  static ChatSocketService get instance => _instance;

  IO.Socket? _socket;
  String? _currentToken;
  final StreamController<Map<String, dynamic>> _messageController = StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _typingController = StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _presenceController = StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _reactionController = StreamController<Map<String, dynamic>>.broadcast();

  /// Stream of incoming chat messages (from socket). Each event is the raw payload (includes chatTopicId).
  Stream<Map<String, dynamic>> get onMessage => _messageController.stream;

  /// Stream of typing events: { userId, chatTopicId, isTyping }.
  Stream<Map<String, dynamic>> get onTyping => _typingController.stream;

  /// Stream of presence: { userId, isOnline }.
  Stream<Map<String, dynamic>> get onPresence => _presenceController.stream;

  /// Stream of reactions: { messageId, chatTopicId, userId, emoji, added }.
  Stream<Map<String, dynamic>> get onReaction => _reactionController.stream;

  bool get isConnected => _socket?.connected ?? false;

  /// Connect with Bearer token. Idempotent: if already connected with same token, no-op.
  void connect(String token) {
    if (token.isEmpty) return;
    final t = token.startsWith('Bearer ') ? token : 'Bearer $token';
    if (_socket != null && _currentToken == t) return;

    disconnect();
    _currentToken = t;

    try {
      _socket = IO.io(
        kSocketBaseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setAuth({'token': t})
            .build(),
      );

      _socket!.onConnect((_) {
        Utils.showLog('ChatSocketService: connected');
      });
      _socket!.onDisconnect((_) {
        Utils.showLog('ChatSocketService: disconnected');
      });
      _socket!.onConnectError((e) {
        Utils.showLog('ChatSocketService: connect error $e');
      });

      _socket!.on('chat:message', (data) {
        try {
          if (data is! Map<String, dynamic>) return;
          _messageController.add(Map<String, dynamic>.from(data));
        } catch (e) {
          Utils.showLog('ChatSocketService: chat:message error $e');
        }
      });

      _socket!.on('chat:typing', (data) {
        try {
          if (data is Map<String, dynamic>) {
            _typingController.add(Map<String, dynamic>.from(data));
          }
        } catch (_) {}
      });

      _socket!.on('user:presence', (data) {
        try {
          if (data is Map<String, dynamic>) {
            _presenceController.add(Map<String, dynamic>.from(data));
          }
        } catch (_) {}
      });

      _socket!.on('chat:reaction', (data) {
        try {
          if (data is Map<String, dynamic>) {
            _reactionController.add(Map<String, dynamic>.from(data));
          }
        } catch (_) {}
      });
    } catch (e) {
      Utils.showLog('ChatSocketService: connect error $e');
    }
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    _currentToken = null;
  }

  /// Join topic room (optional; for typing and future features). Call when opening a chat.
  void joinTopic(String chatTopicId) {
    if (chatTopicId.isEmpty) return;
    _socket?.emit('chat:join_topic', {'chatTopicId': chatTopicId});
  }

  /// Leave topic room. Call when leaving chat screen.
  void leaveTopic(String chatTopicId) {
    if (chatTopicId.isEmpty) return;
    _socket?.emit('chat:leave_topic', {'chatTopicId': chatTopicId});
  }

  /// Emit typing indicator.
  void emitTyping(String chatTopicId, bool isTyping) {
    if (chatTopicId.isEmpty) return;
    _socket?.emit('chat:typing', {'chatTopicId': chatTopicId, 'isTyping': isTyping});
  }

  void dispose() {
    disconnect();
    _messageController.close();
    _typingController.close();
    _presenceController.close();
    _reactionController.close();
  }
}
