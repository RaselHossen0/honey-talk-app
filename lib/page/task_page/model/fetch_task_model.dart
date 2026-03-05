// Task page model - API-ready with fromJson/toJson.
// Male and female users receive different tasks from API.

class FetchTaskModel {
  FetchTaskModel({
    bool? status,
    String? message,
    TaskPageData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchTaskModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? TaskPageData.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  TaskPageData? _data;

  bool? get status => _status;
  String? get message => _message;
  TaskPageData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) map['data'] = _data!.toJson();
    return map;
  }
}

class TaskPageData {
  TaskPageData({
    this.monthlyCountdown,
    this.checkInBonus,
    this.invitationBonus,
    this.dailyTasks,
  });

  TaskPageData.fromJson(dynamic json) {
    monthlyCountdown = json['monthlyCountdown'] != null
        ? MonthlyCountdown.fromJson(json['monthlyCountdown'])
        : null;
    checkInBonus = json['checkInBonus'] != null
        ? CheckInBonus.fromJson(json['checkInBonus'])
        : null;
    invitationBonus = json['invitationBonus'] != null
        ? InvitationBonus.fromJson(json['invitationBonus'])
        : null;
    if (json['dailyTasks'] != null) {
      dailyTasks = [];
      for (var v in json['dailyTasks']) {
        dailyTasks?.add(DailyTask.fromJson(v));
      }
    }
  }

  MonthlyCountdown? monthlyCountdown;
  CheckInBonus? checkInBonus;
  InvitationBonus? invitationBonus;
  List<DailyTask>? dailyTasks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (monthlyCountdown != null) map['monthlyCountdown'] = monthlyCountdown!.toJson();
    if (checkInBonus != null) map['checkInBonus'] = checkInBonus!.toJson();
    if (invitationBonus != null) map['invitationBonus'] = invitationBonus!.toJson();
    if (dailyTasks != null) map['dailyTasks'] = dailyTasks!.map((v) => v.toJson()).toList();
    return map;
  }
}

class MonthlyCountdown {
  MonthlyCountdown({
    this.daysRemaining,
    this.hoursRemaining,
    this.minutesRemaining,
    this.secondsRemaining,
    this.points,
    this.canClaim,
  });

  MonthlyCountdown.fromJson(dynamic json) {
    daysRemaining = json['daysRemaining'];
    hoursRemaining = json['hoursRemaining'];
    minutesRemaining = json['minutesRemaining'];
    secondsRemaining = json['secondsRemaining'];
    points = json['points'];
    canClaim = json['canClaim'];
  }

  int? daysRemaining;
  int? hoursRemaining;
  int? minutesRemaining;
  int? secondsRemaining;
  int? points;
  bool? canClaim;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['daysRemaining'] = daysRemaining;
    map['hoursRemaining'] = hoursRemaining;
    map['minutesRemaining'] = minutesRemaining;
    map['secondsRemaining'] = secondsRemaining;
    map['points'] = points;
    map['canClaim'] = canClaim;
    return map;
  }
}

class CheckInBonus {
  CheckInBonus({this.amount, this.claimed});

  CheckInBonus.fromJson(dynamic json) {
    amount = json['amount'];
    claimed = json['claimed'];
  }

  int? amount;
  bool? claimed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['claimed'] = claimed;
    return map;
  }
}

class InvitationBonus {
  InvitationBonus({this.amount});

  InvitationBonus.fromJson(dynamic json) {
    amount = json['amount'];
  }

  int? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    return map;
  }
}

/// Daily task - varies by gender (male vs female).
class DailyTask {
  DailyTask({
    this.id,
    this.title,
    this.reward,
    this.multiplier,
    this.progress,
    this.totalRequired,
    this.actionType,
    this.actionRoute,
    this.isCompleted,
  });

  DailyTask.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    reward = json['reward'];
    multiplier = json['multiplier'];
    progress = json['progress'];
    totalRequired = json['totalRequired'];
    actionType = json['actionType'];
    actionRoute = json['actionRoute'];
    isCompleted = json['isCompleted'];
  }

  String? id;
  String? title;
  int? reward;
  int? multiplier;
  int? progress;
  int? totalRequired;
  String? actionType;
  String? actionRoute;
  bool? isCompleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['reward'] = reward;
    map['multiplier'] = multiplier;
    map['progress'] = progress;
    map['totalRequired'] = totalRequired;
    map['actionType'] = actionType;
    map['actionRoute'] = actionRoute;
    map['isCompleted'] = isCompleted;
    return map;
  }
}
