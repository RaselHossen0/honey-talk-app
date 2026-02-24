class FetchUserCoinModel {
  FetchUserCoinModel({
    bool? status,
    String? message,
    int? coinBalance,
  }) {
    _status = status;
    _message = message;
    _coinBalance = coinBalance;
  }

  FetchUserCoinModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _coinBalance = json['coinBalance'];
  }
  bool? _status;
  String? _message;
  int? _coinBalance;
  FetchUserCoinModel copyWith({
    bool? status,
    String? message,
    int? coinBalance,
  }) =>
      FetchUserCoinModel(
        status: status ?? _status,
        message: message ?? _message,
        coinBalance: coinBalance ?? _coinBalance,
      );
  bool? get status => _status;
  String? get message => _message;
  int? get coinBalance => _coinBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['coinBalance'] = _coinBalance;
    return map;
  }
}
