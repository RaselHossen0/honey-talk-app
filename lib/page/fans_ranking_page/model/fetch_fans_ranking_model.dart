class FetchFansRankingModel {
  FetchFansRankingModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchFansRankingModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  FetchFansRankingModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      FetchFansRankingModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    List<DailyWeeklyMonthlyCommonModel>? daily,
    List<DailyWeeklyMonthlyCommonModel>? weekly,
    List<DailyWeeklyMonthlyCommonModel>? monthly,
  }) {
    _daily = daily;
    _weekly = weekly;
    _monthly = monthly;
  }

  Data.fromJson(dynamic json) {
    if (json['daily'] != null) {
      _daily = [];
      json['daily'].forEach((v) {
        _daily?.add(DailyWeeklyMonthlyCommonModel.fromJson(v));
      });
    }
    if (json['weekly'] != null) {
      _weekly = [];
      json['weekly'].forEach((v) {
        _weekly?.add(DailyWeeklyMonthlyCommonModel.fromJson(v));
      });
    }
    if (json['monthly'] != null) {
      _monthly = [];
      json['monthly'].forEach((v) {
        _monthly?.add(DailyWeeklyMonthlyCommonModel.fromJson(v));
      });
    }
  }
  List<DailyWeeklyMonthlyCommonModel>? _daily;
  List<DailyWeeklyMonthlyCommonModel>? _weekly;
  List<DailyWeeklyMonthlyCommonModel>? _monthly;
  Data copyWith({
    List<DailyWeeklyMonthlyCommonModel>? daily,
    List<DailyWeeklyMonthlyCommonModel>? weekly,
    List<DailyWeeklyMonthlyCommonModel>? monthly,
  }) =>
      Data(
        daily: daily ?? _daily,
        weekly: weekly ?? _weekly,
        monthly: monthly ?? _monthly,
      );
  List<DailyWeeklyMonthlyCommonModel>? get daily => _daily;
  List<DailyWeeklyMonthlyCommonModel>? get weekly => _weekly;
  List<DailyWeeklyMonthlyCommonModel>? get monthly => _monthly;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_daily != null) {
      map['daily'] = _daily?.map((v) => v.toJson()).toList();
    }
    if (_weekly != null) {
      map['weekly'] = _weekly?.map((v) => v.toJson()).toList();
    }
    if (_monthly != null) {
      map['monthly'] = _monthly?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DailyWeeklyMonthlyCommonModel {
  DailyWeeklyMonthlyCommonModel({
    String? userId,
    String? name,
    String? image,
    bool? isProfilePicBanned,
    String? gender,
    int? age,
    bool? isVerified,
    String? wealthLevelImage,
    String? avtarFrame,
    int? avtarFrameType,
    int? coin,
  }) {
    _userId = userId;
    _name = name;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _gender = gender;
    _age = age;
    _isVerified = isVerified;
    _wealthLevelImage = wealthLevelImage;
    _avtarFrame = avtarFrame;
    _avtarFrameType = avtarFrameType;
    _coin = coin;
  }

  DailyWeeklyMonthlyCommonModel.fromJson(dynamic json) {
    _userId = json['userId'];
    _name = json['name'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _gender = json['gender'];
    _age = json['age'];
    _isVerified = json['isVerified'];
    _wealthLevelImage = json['wealthLevelImage'];
    _avtarFrame = json['avtarFrame'];
    _avtarFrameType = json['avtarFrameType'];
    _coin = json['coin'];
  }
  String? _userId;
  String? _name;
  String? _image;
  bool? _isProfilePicBanned;
  String? _gender;
  int? _age;
  bool? _isVerified;
  String? _wealthLevelImage;
  String? _avtarFrame;
  int? _avtarFrameType;
  int? _coin;
  DailyWeeklyMonthlyCommonModel copyWith({
    String? userId,
    String? name,
    String? image,
    bool? isProfilePicBanned,
    String? gender,
    int? age,
    bool? isVerified,
    String? wealthLevelImage,
    String? avtarFrame,
    int? avtarFrameType,
    int? coin,
  }) =>
      DailyWeeklyMonthlyCommonModel(
        userId: userId ?? _userId,
        name: name ?? _name,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        gender: gender ?? _gender,
        age: age ?? _age,
        isVerified: isVerified ?? _isVerified,
        wealthLevelImage: wealthLevelImage ?? _wealthLevelImage,
        avtarFrame: avtarFrame ?? _avtarFrame,
        avtarFrameType: avtarFrameType ?? _avtarFrameType,
        coin: coin ?? _coin,
      );
  String? get userId => _userId;
  String? get name => _name;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get gender => _gender;
  int? get age => _age;
  bool? get isVerified => _isVerified;
  String? get wealthLevelImage => _wealthLevelImage;
  String? get avtarFrame => _avtarFrame;
  int? get avtarFrameType => _avtarFrameType;
  int? get coin => _coin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['name'] = _name;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['gender'] = _gender;
    map['age'] = _age;
    map['isVerified'] = _isVerified;
    map['wealthLevelImage'] = _wealthLevelImage;
    map['avtarFrame'] = _avtarFrame;
    map['avtarFrameType'] = _avtarFrameType;
    map['coin'] = _coin;
    return map;
  }
}
