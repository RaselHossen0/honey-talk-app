class FakeFetchGiftCategoryModel {
  FakeFetchGiftCategoryModel({
    bool? status,
    String? message,
    List<Datas>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FakeFetchGiftCategoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Datas.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Datas>? _data;
  FakeFetchGiftCategoryModel copyWith({
    bool? status,
    String? message,
    List<Datas>? data,
  }) =>
      FakeFetchGiftCategoryModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Datas>? get data => _data;

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

class Datas {
  Datas({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Datas.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  Datas copyWith({
    String? id,
    String? name,
  }) =>
      Datas(
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
