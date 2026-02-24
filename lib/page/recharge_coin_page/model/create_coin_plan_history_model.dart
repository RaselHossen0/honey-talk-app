class CreateCoinPlanHistoryModel {
  CreateCoinPlanHistoryModel({
    bool? status,
    String? message,
    int? totalCoins,
  }) {
    _status = status;
    _message = message;
    _totalCoins = totalCoins;
  }

  CreateCoinPlanHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _totalCoins = json['totalCoins'];
  }
  bool? _status;
  String? _message;
  int? _totalCoins;
  CreateCoinPlanHistoryModel copyWith({
    bool? status,
    String? message,
    int? totalCoins,
  }) =>
      CreateCoinPlanHistoryModel(
        status: status ?? _status,
        message: message ?? _message,
        totalCoins: totalCoins ?? _totalCoins,
      );
  bool? get status => _status;
  String? get message => _message;
  int? get totalCoins => _totalCoins;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['totalCoins'] = _totalCoins;
    return map;
  }
}
