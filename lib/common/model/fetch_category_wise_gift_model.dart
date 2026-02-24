class FetchCategoryWiseGiftModel {
  FetchCategoryWiseGiftModel({
    bool? status,
    String? message,
    List<CategoryWiseGift>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchCategoryWiseGiftModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryWiseGift.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CategoryWiseGift>? _data;
  FetchCategoryWiseGiftModel copyWith({
    bool? status,
    String? message,
    List<CategoryWiseGift>? data,
  }) =>
      FetchCategoryWiseGiftModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<CategoryWiseGift>? get data => _data;

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

class CategoryWiseGift {
  CategoryWiseGift({
    String? id,
    String? title,
    int? type,
    String? image,
    int? coin,
  }) {
    _id = id;
    _title = title;
    _type = type;
    _image = image;
    _coin = coin;
  }

  CategoryWiseGift.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _type = json['type'];
    _image = json['image'];
    _coin = json['coin'];
  }
  String? _id;
  String? _title;
  int? _type;
  String? _image;
  int? _coin;
  CategoryWiseGift copyWith({
    String? id,
    String? title,
    int? type,
    String? image,
    int? coin,
  }) =>
      CategoryWiseGift(
        id: id ?? _id,
        title: title ?? _title,
        type: type ?? _type,
        image: image ?? _image,
        coin: coin ?? _coin,
      );
  String? get id => _id;
  String? get title => _title;
  int? get type => _type;
  String? get image => _image;
  int? get coin => _coin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['type'] = _type;
    map['image'] = _image;
    map['coin'] = _coin;
    return map;
  }
}
