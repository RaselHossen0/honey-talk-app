import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

/// Response shape from GET /agora/rtc-token.
class AgoraRtcTokenPayload {
  final String appId;
  final String token;
  final String channelName;
  final int uid;
  final String role;
  final String? expireAt;

  AgoraRtcTokenPayload({
    required this.appId,
    required this.token,
    required this.channelName,
    required this.uid,
    required this.role,
    this.expireAt,
  });

  factory AgoraRtcTokenPayload.fromJson(Map<String, dynamic> json) {
    return AgoraRtcTokenPayload(
      appId: json['appId'] as String? ?? '',
      token: json['token'] as String? ?? '',
      channelName: json['channelName'] as String? ?? '',
      uid: (json['uid'] is int) ? json['uid'] as int : int.tryParse(json['uid']?.toString() ?? '0') ?? 0,
      role: json['role'] as String? ?? 'publisher',
      expireAt: json['expireAt'] as String?,
    );
  }
}

/// Fetches RTC token from backend for live, video/audio call, or audio room.
class FetchAgoraTokenApi {
  /// GET /agora/rtc-token?channelName=...&uid=...&role=publisher|subscriber
  /// Returns null on failure or if backend returns status: false.
  static Future<AgoraRtcTokenPayload?> callApi({
    required String channelName,
    required int uid,
    String role = 'publisher',
    int expireSeconds = 3600,
  }) async {
    try {
      final res = await ApiClient.instance.get(
        '/agora/rtc-token',
        queryParameters: {
          'channelName': channelName,
          'uid': uid.toString(),
          'role': role,
          'expireSeconds': expireSeconds.toString(),
        },
      );
      final status = res['status'] as bool?;
      final data = res['data'];
      if (status != true || data == null || data is! Map<String, dynamic>) {
        Utils.showLog('Agora token API error: ${res['message']}');
        return null;
      }
      return AgoraRtcTokenPayload.fromJson(data);
    } catch (e) {
      Utils.showLog('FetchAgoraTokenApi error: $e');
      return null;
    }
  }
}
