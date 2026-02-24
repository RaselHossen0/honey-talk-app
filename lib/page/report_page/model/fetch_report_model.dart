class FetchReportModel {
  bool? status;
  String? message;
  ReportData? data;

  FetchReportModel({this.status, this.message, this.data});

  FetchReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ReportData.fromJson(json['data']) : null;
  }
}

class ReportData {
  List<DailyReport>? thisWeek;
  List<DailyReport>? lastWeek;

  ReportData({this.thisWeek, this.lastWeek});

  ReportData.fromJson(Map<String, dynamic> json) {
    if (json['thisWeek'] != null) {
      thisWeek = (json['thisWeek'] as List).map((v) => DailyReport.fromJson(v)).toList();
    }
    if (json['lastWeek'] != null) {
      lastWeek = (json['lastWeek'] as List).map((v) => DailyReport.fromJson(v)).toList();
    }
  }
}

class DailyReport {
  String? date; // e.g. "02-17"
  String? liveTime; // HH:MM:SS
  int? callDurationLiveMins;
  int? callDurationMins;
  int? negativeReview;
  int? complaint;
  int? partyDuration;
  int? subsidyRevenue;
  int? payingRevenue;
  int? partyRevenue;
  int? benefitsOfPrivateChat;
  int? totalRevenues;
  int? estimatedSettlementAmount;

  DailyReport({
    this.date,
    this.liveTime,
    this.callDurationLiveMins,
    this.callDurationMins,
    this.negativeReview,
    this.complaint,
    this.partyDuration,
    this.subsidyRevenue,
    this.payingRevenue,
    this.partyRevenue,
    this.benefitsOfPrivateChat,
    this.totalRevenues,
    this.estimatedSettlementAmount,
  });

  DailyReport.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    liveTime = json['liveTime'];
    callDurationLiveMins = json['callDurationLiveMins'];
    callDurationMins = json['callDurationMins'];
    negativeReview = json['negativeReview'];
    complaint = json['complaint'];
    partyDuration = json['partyDuration'];
    subsidyRevenue = json['subsidyRevenue'];
    payingRevenue = json['payingRevenue'];
    partyRevenue = json['partyRevenue'];
    benefitsOfPrivateChat = json['benefitsOfPrivateChat'];
    totalRevenues = json['totalRevenues'];
    estimatedSettlementAmount = json['estimatedSettlementAmount'];
  }
}
