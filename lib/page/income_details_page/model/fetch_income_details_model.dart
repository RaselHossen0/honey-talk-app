/// Model for Income Details (transaction history) - API-ready
class FetchIncomeDetailsModel {
  FetchIncomeDetailsModel({
    bool? status,
    String? message,
    List<IncomeTransaction>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchIncomeDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      for (var v in json['data']) {
        _data?.add(IncomeTransaction.fromJson(v));
      }
    }
  }
  bool? _status;
  String? _message;
  List<IncomeTransaction>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<IncomeTransaction>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) map['data'] = _data?.map((v) => v.toJson()).toList();
    return map;
  }
}

class IncomeTransaction {
  IncomeTransaction({
    String? id,
    String? type,
    String? recipientName,
    String? recipientId,
    String? recipientImage,
    String? createdAt,
    int? subsidy,
    int? revenue,
    int? total,
  }) {
    _id = id;
    _type = type;
    _recipientName = recipientName;
    _recipientId = recipientId;
    _recipientImage = recipientImage;
    _createdAt = createdAt;
    _subsidy = subsidy;
    _revenue = revenue;
    _total = total;
  }

  IncomeTransaction.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _recipientName = json['recipientName'];
    _recipientId = json['recipientId'];
    _recipientImage = json['recipientImage'];
    _createdAt = json['createdAt'];
    _subsidy = json['subsidy'];
    _revenue = json['revenue'];
    _total = json['total'];
  }
  String? _id;
  String? _type;
  String? _recipientName;
  String? _recipientId;
  String? _recipientImage;
  String? _createdAt;
  int? _subsidy;
  int? _revenue;
  int? _total;

  String? get id => _id;
  String? get type => _type;
  String? get recipientName => _recipientName;
  String? get recipientId => _recipientId;
  String? get recipientImage => _recipientImage;
  String? get createdAt => _createdAt;
  int? get subsidy => _subsidy;
  int? get revenue => _revenue;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['recipientName'] = _recipientName;
    map['recipientId'] = _recipientId;
    map['recipientImage'] = _recipientImage;
    map['createdAt'] = _createdAt;
    map['subsidy'] = _subsidy;
    map['revenue'] = _revenue;
    map['total'] = _total;
    return map;
  }
}
