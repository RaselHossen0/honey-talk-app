import 'dart:convert';

UploadVideoModel uploadReelsModelFromJson(String str) => UploadVideoModel.fromJson(json.decode(str));
String uploadReelsModelToJson(UploadVideoModel data) => json.encode(data.toJson());

class UploadVideoModel {
  UploadVideoModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  UploadVideoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  UploadVideoModel copyWith({
    bool? status,
    String? message,
  }) =>
      UploadVideoModel(
        status: status ?? _status,
        message: message ?? _message,
      );
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
