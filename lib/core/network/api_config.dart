/// Backend API base URL. Default: remote API (same as admin panel production).
/// Override for local dev: build with --dart-define=API_BASE_URL=http://10.0.2.2:3000/api/v1 (Android emulator)
/// or --dart-define=API_BASE_URL=http://localhost:3000/api/v1 (iOS simulator).
const String kApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://217.216.78.43:3000/api/v1',
);

/// Socket.IO base URL (same host as API, without /api/v1). Used for real-time chat.
String get kSocketBaseUrl {
  final u = Uri.parse(kApiBaseUrl);
  return '${u.scheme}://${u.host}${u.hasPort ? ':${u.port}' : ''}';
}
