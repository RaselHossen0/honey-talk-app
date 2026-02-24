class FetchGiftGalleryModel {
  FetchGiftGalleryModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchGiftGalleryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  FetchGiftGalleryModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      FetchGiftGalleryModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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

class Data {
  Data({
    String? id,
    int? totalGiftCount,
    String? latestDate,
    String? giftId,
    String? giftTitle,
    String? giftImage,
    int? giftCoin,
    int? giftType,
  }) {
    _id = id;
    _totalGiftCount = totalGiftCount;
    _latestDate = latestDate;
    _giftId = giftId;
    _giftTitle = giftTitle;
    _giftImage = giftImage;
    _giftCoin = giftCoin;
    _giftType = giftType;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _totalGiftCount = json['totalGiftCount'];
    _latestDate = json['latestDate'];
    _giftId = json['giftId'];
    _giftTitle = json['giftTitle'];
    _giftImage = json['giftImage'];
    _giftCoin = json['giftCoin'];
    _giftType = json['giftType'];
  }
  String? _id;
  int? _totalGiftCount;
  String? _latestDate;
  String? _giftId;
  String? _giftTitle;
  String? _giftImage;
  int? _giftCoin;
  int? _giftType;
  Data copyWith({
    String? id,
    int? totalGiftCount,
    String? latestDate,
    String? giftId,
    String? giftTitle,
    String? giftImage,
    int? giftCoin,
    int? giftType,
  }) =>
      Data(
        id: id ?? _id,
        totalGiftCount: totalGiftCount ?? _totalGiftCount,
        latestDate: latestDate ?? _latestDate,
        giftId: giftId ?? _giftId,
        giftTitle: giftTitle ?? _giftTitle,
        giftImage: giftImage ?? _giftImage,
        giftCoin: giftCoin ?? _giftCoin,
        giftType: giftType ?? _giftType,
      );
  String? get id => _id;
  int? get totalGiftCount => _totalGiftCount;
  String? get latestDate => _latestDate;
  String? get giftId => _giftId;
  String? get giftTitle => _giftTitle;
  String? get giftImage => _giftImage;
  int? get giftCoin => _giftCoin;
  int? get giftType => _giftType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['totalGiftCount'] = _totalGiftCount;
    map['latestDate'] = _latestDate;
    map['giftId'] = _giftId;
    map['giftTitle'] = _giftTitle;
    map['giftImage'] = _giftImage;
    map['giftCoin'] = _giftCoin;
    map['giftType'] = _giftType;
    return map;
  }
}
