class FetchCoinHistoryModel {
  FetchCoinHistoryModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchCoinHistoryModel.fromJson(dynamic json) {
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
  FetchCoinHistoryModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      FetchCoinHistoryModel(
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
    int? coin,
    String? createdAt,
    int? payoutStatus,
    String? reason,
    int? type,
    String? uniqueId,
    String? senderName,
    String? receiverName,
    bool? isIncome,
  }) {
    _id = id;
    _coin = coin;
    _createdAt = createdAt;
    _payoutStatus = payoutStatus;
    _reason = reason;
    _type = type;
    _uniqueId = uniqueId;
    _senderName = senderName;
    _receiverName = receiverName;
    _isIncome = isIncome;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _coin = json['coin'];
    _createdAt = json['createdAt'];
    _payoutStatus = json['payoutStatus'];
    _reason = json['reason'];
    _type = json['type'];
    _uniqueId = json['uniqueId'];
    _senderName = json['senderName'];
    _receiverName = json['receiverName'];
    _isIncome = json['isIncome'];
  }
  String? _id;
  int? _coin;
  String? _createdAt;
  int? _payoutStatus;
  String? _reason;
  int? _type;
  String? _uniqueId;
  String? _senderName;
  String? _receiverName;
  bool? _isIncome;
  Data copyWith({
    String? id,
    int? coin,
    String? createdAt,
    int? payoutStatus,
    String? reason,
    int? type,
    String? uniqueId,
    String? senderName,
    String? receiverName,
    bool? isIncome,
  }) =>
      Data(
        id: id ?? _id,
        coin: coin ?? _coin,
        createdAt: createdAt ?? _createdAt,
        payoutStatus: payoutStatus ?? _payoutStatus,
        reason: reason ?? _reason,
        type: type ?? _type,
        uniqueId: uniqueId ?? _uniqueId,
        senderName: senderName ?? _senderName,
        receiverName: receiverName ?? _receiverName,
        isIncome: isIncome ?? _isIncome,
      );
  String? get id => _id;
  int? get coin => _coin;
  String? get createdAt => _createdAt;
  int? get payoutStatus => _payoutStatus;
  String? get reason => _reason;
  int? get type => _type;
  String? get uniqueId => _uniqueId;
  String? get senderName => _senderName;
  String? get receiverName => _receiverName;
  bool? get isIncome => _isIncome;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['coin'] = _coin;
    map['createdAt'] = _createdAt;
    map['payoutStatus'] = _payoutStatus;
    map['reason'] = _reason;
    map['type'] = _type;
    map['uniqueId'] = _uniqueId;
    map['senderName'] = _senderName;
    map['receiverName'] = _receiverName;
    map['isIncome'] = _isIncome;
    return map;
  }
}
