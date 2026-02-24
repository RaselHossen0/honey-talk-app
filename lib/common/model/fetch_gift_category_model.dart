class FetchGiftCategoryModel {
  FetchGiftCategoryModel({
    bool? status,
    String? message,
    List<GiftData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchGiftCategoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GiftData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GiftData>? _data;
  FetchGiftCategoryModel copyWith({
    bool? status,
    String? message,
    List<GiftData>? data,
  }) =>
      FetchGiftCategoryModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GiftData>? get data => _data;

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

class GiftData {
  GiftData({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  GiftData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  GiftData copyWith({
    String? id,
    String? name,
  }) =>
      GiftData(
        id: id ?? _id,
        name: name ?? _name,
      );
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }
}
