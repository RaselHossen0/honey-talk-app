/// Backend API base URL. Change for device: use your machine IP e.g. http://192.168.1.x:3000/api/v1
/// Android emulator: http://10.0.2.2:3000/api/v1
/// iOS simulator / local: http://localhost:3000/api/v1
const String kApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:3000/api/v1',
);

/// Socket.IO base URL (same host as API, without /api/v1). Used for real-time chat.
String get kSocketBaseUrl {
  final u = Uri.parse(kApiBaseUrl);
  return '${u.scheme}://${u.host}${u.hasPort ? ':${u.port}' : ''}';
}
