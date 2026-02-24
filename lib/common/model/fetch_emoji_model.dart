class FetchEmojiModel {
  FetchEmojiModel({
    bool? status,
    String? message,
    List<EmojiData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchEmojiModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(EmojiData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<EmojiData>? _data;
  FetchEmojiModel copyWith({
    bool? status,
    String? message,
    List<EmojiData>? data,
  }) =>
      FetchEmojiModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<EmojiData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class EmojiData {
  EmojiData({
    String? id,
    String? title,
    String? image,
  }) {
    _id = id;
    _title = title;
    _image = image;
  }

  EmojiData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _image = json['image'];
  }
  String? _id;
  String? _title;
  String? _image;
  EmojiData copyWith({
    String? id,
    String? title,
    String? image,
  }) =>
      EmojiData(
        id: id ?? _id,
        title: title ?? _title,
        image: image ?? _image,
      );
  String? get id => _id;
  String? get title => _title;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    return map;
  }
}
