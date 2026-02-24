import 'dart:convert';

UploadFeedModel uploadFeedModelFromJson(String str) => UploadFeedModel.fromJson(json.decode(str));
String uploadFeedModelToJson(UploadFeedModel data) => json.encode(data.toJson());

class UploadFeedModel {
  UploadFeedModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  UploadFeedModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  UploadFeedModel copyWith({
    bool? status,
    String? message,
  }) =>
      UploadFeedModel(
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
