/// Model for My Income - API-ready with fromJson/toJson
class FetchMyIncomeModel {
  FetchMyIncomeModel({
    bool? status,
    String? message,
    MyIncomeData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchMyIncomeModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? MyIncomeData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  MyIncomeData? _data;

  bool? get status => _status;
  String? get message => _message;
  MyIncomeData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) map['data'] = _data?.toJson();
    return map;
  }
}

class MyIncomeData {
  MyIncomeData({
    int? totalBonus,
    int? subsidyRevenue,
    int? payingRevenue,
    TodayReport? todayReport,
  }) {
    _totalBonus = totalBonus;
    _subsidyRevenue = subsidyRevenue;
    _payingRevenue = payingRevenue;
    _todayReport = todayReport;
  }

  MyIncomeData.fromJson(dynamic json) {
    _totalBonus = json['totalBonus'];
    _subsidyRevenue = json['subsidyRevenue'];
    _payingRevenue = json['payingRevenue'];
    _todayReport = json['todayReport'] != null ? TodayReport.fromJson(json['todayReport']) : null;
  }
  int? _totalBonus;
  int? _subsidyRevenue;
  int? _payingRevenue;
  TodayReport? _todayReport;

  int? get totalBonus => _totalBonus;
  int? get subsidyRevenue => _subsidyRevenue;
  int? get payingRevenue => _payingRevenue;
  TodayReport? get todayReport => _todayReport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalBonus'] = _totalBonus;
    map['subsidyRevenue'] = _subsidyRevenue;
    map['payingRevenue'] = _payingRevenue;
    if (_todayReport != null) map['todayReport'] = _todayReport?.toJson();
    return map;
  }
}

class TodayReport {
  TodayReport({
    int? totalRevenues,
    String? liveTime,
    int? todaySubsidyRevenue,
    int? todayPayingRevenue,
    int? callDurationLiveMins,
    int? callDurationMins,
    int? todayPartyDuration,
    int? effectiveDurationLive,
    int? todayPartyRevenue,
  }) {
    _totalRevenues = totalRevenues;
    _liveTime = liveTime;
    _todaySubsidyRevenue = todaySubsidyRevenue;
    _todayPayingRevenue = todayPayingRevenue;
    _callDurationLiveMins = callDurationLiveMins;
    _callDurationMins = callDurationMins;
    _todayPartyDuration = todayPartyDuration;
    _effectiveDurationLive = effectiveDurationLive;
    _todayPartyRevenue = todayPartyRevenue;
  }

  TodayReport.fromJson(dynamic json) {
    _totalRevenues = json['totalRevenues'];
    _liveTime = json['liveTime'];
    _todaySubsidyRevenue = json['todaySubsidyRevenue'];
    _todayPayingRevenue = json['todayPayingRevenue'];
    _callDurationLiveMins = json['callDurationLiveMins'];
    _callDurationMins = json['callDurationMins'];
    _todayPartyDuration = json['todayPartyDuration'];
    _effectiveDurationLive = json['effectiveDurationLive'];
    _todayPartyRevenue = json['todayPartyRevenue'];
  }
  int? _totalRevenues;
  String? _liveTime;
  int? _todaySubsidyRevenue;
  int? _todayPayingRevenue;
  int? _callDurationLiveMins;
  int? _callDurationMins;
  int? _todayPartyDuration;
  int? _effectiveDurationLive;
  int? _todayPartyRevenue;

  int? get totalRevenues => _totalRevenues;
  String? get liveTime => _liveTime;
  int? get todaySubsidyRevenue => _todaySubsidyRevenue;
  int? get todayPayingRevenue => _todayPayingRevenue;
  int? get callDurationLiveMins => _callDurationLiveMins;
  int? get callDurationMins => _callDurationMins;
  int? get todayPartyDuration => _todayPartyDuration;
  int? get effectiveDurationLive => _effectiveDurationLive;
  int? get todayPartyRevenue => _todayPartyRevenue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalRevenues'] = _totalRevenues;
    map['liveTime'] = _liveTime;
    map['todaySubsidyRevenue'] = _todaySubsidyRevenue;
    map['todayPayingRevenue'] = _todayPayingRevenue;
    map['callDurationLiveMins'] = _callDurationLiveMins;
    map['callDurationMins'] = _callDurationMins;
    map['todayPartyDuration'] = _todayPartyDuration;
    map['effectiveDurationLive'] = _effectiveDurationLive;
    map['todayPartyRevenue'] = _todayPartyRevenue;
    return map;
  }
}
