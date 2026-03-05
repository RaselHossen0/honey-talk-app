import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tingle/core/network/api_config.dart';
import 'package:tingle/utils/database.dart';

/// Shared HTTP client for backend API. Uses [kApiBaseUrl] and optional Bearer token from [Database].
class ApiClient {
  ApiClient._();
  static final ApiClient _instance = ApiClient._();
  static ApiClient get instance => _instance;

  String get baseUrl => kApiBaseUrl;

  Map<String, String> _headers({String? token, bool json = true}) {
    final t = token ?? Database.accessToken;
    final map = <String, String>{
      'Accept': 'application/json',
      if (json) 'Content-Type': 'application/json',
    };
    if (t.isNotEmpty) map['Authorization'] = 'Bearer $t';
    return map;
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
    String? token,
  }) async {
    var uri = Uri.parse('$baseUrl$path');
    if (queryParameters != null && queryParameters.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParameters);
    }
    final r = await http.get(uri, headers: _headers(token: token));
    return _decode(r);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    final r = await http.post(
      uri,
      headers: _headers(token: token),
      body: body != null ? jsonEncode(body) : null,
    );
    return _decode(r);
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    final r = await http.patch(
      uri,
      headers: _headers(token: token),
      body: body != null ? jsonEncode(body) : null,
    );
    return _decode(r);
  }

  static Map<String, dynamic> _decode(http.Response r) {
    final raw = r.body;
    if (raw.isEmpty) return <String, dynamic>{};
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return map;
    } catch (_) {
      return <String, dynamic>{'status': false, 'message': raw};
    }
  }
}
