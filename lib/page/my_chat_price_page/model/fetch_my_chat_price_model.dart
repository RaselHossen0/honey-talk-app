/// Model for My Chat Price - structured for easy API integration
class FetchMyChatPriceModel {
  FetchMyChatPriceModel({
    bool? status,
    String? message,
    MyChatPriceData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchMyChatPriceModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? MyChatPriceData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  MyChatPriceData? _data;

  bool? get status => _status;
  String? get message => _message;
  MyChatPriceData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) map['data'] = _data?.toJson();
    return map;
  }
}

class MyChatPriceData {
  MyChatPriceData({
    int? videoCallPricePerMin,
    int? userLevel,
    List<LevelPriceTier>? highestCallPriceTiers,
    List<int>? availablePriceOptions,
    int? defaultNewHostPrice,
    int? freeCallEarning,
    int? priceRaiseCountThisWeek,
    int? priceRaiseOpportunitiesPerWeek,
  }) {
    _videoCallPricePerMin = videoCallPricePerMin;
    _userLevel = userLevel;
    _highestCallPriceTiers = highestCallPriceTiers;
    _availablePriceOptions = availablePriceOptions ?? [1750, 2450, 2800, 3500, 3850, 4200, 5000];
    _defaultNewHostPrice = defaultNewHostPrice ?? 1750;
    _freeCallEarning = freeCallEarning ?? 700;
    _priceRaiseCountThisWeek = priceRaiseCountThisWeek ?? 0;
    _priceRaiseOpportunitiesPerWeek = priceRaiseOpportunitiesPerWeek ?? 2;
  }

  MyChatPriceData.fromJson(dynamic json) {
    _videoCallPricePerMin = json['videoCallPricePerMin'] ?? json['privateCallRate'];
    _userLevel = json['userLevel'];
    if (json['highestCallPriceTiers'] != null) {
      _highestCallPriceTiers = [];
      for (var v in json['highestCallPriceTiers']) {
        _highestCallPriceTiers?.add(LevelPriceTier.fromJson(v));
      }
    }
    if (json['availablePriceOptions'] != null) {
      _availablePriceOptions = List<int>.from(json['availablePriceOptions']);
    } else {
      _availablePriceOptions = [1750, 2450, 2800, 3500, 3850, 4200, 5000];
    }
    _defaultNewHostPrice = json['defaultNewHostPrice'] ?? 1750;
    _freeCallEarning = json['freeCallEarning'] ?? 700;
    _priceRaiseCountThisWeek = json['priceRaiseCountThisWeek'] ?? 0;
    _priceRaiseOpportunitiesPerWeek = json['priceRaiseOpportunitiesPerWeek'] ?? 2;
  }
  int? _videoCallPricePerMin;
  int? _userLevel;
  List<LevelPriceTier>? _highestCallPriceTiers;
  List<int>? _availablePriceOptions;
  int? _defaultNewHostPrice;
  int? _freeCallEarning;
  int? _priceRaiseCountThisWeek;
  int? _priceRaiseOpportunitiesPerWeek;

  int? get videoCallPricePerMin => _videoCallPricePerMin;
  int? get userLevel => _userLevel;
  List<LevelPriceTier>? get highestCallPriceTiers => _highestCallPriceTiers;
  List<int> get availablePriceOptions => _availablePriceOptions ?? [1750, 2450, 2800, 3500, 3850, 4200, 5000];
  int get defaultNewHostPrice => _defaultNewHostPrice ?? 1750;
  int get freeCallEarning => _freeCallEarning ?? 700;
  int get priceRaiseCountThisWeek => _priceRaiseCountThisWeek ?? 0;
  int get priceRaiseOpportunitiesPerWeek => _priceRaiseOpportunitiesPerWeek ?? 2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['videoCallPricePerMin'] = _videoCallPricePerMin;
    map['userLevel'] = _userLevel;
    if (_highestCallPriceTiers != null) {
      map['highestCallPriceTiers'] = _highestCallPriceTiers?.map((v) => v.toJson()).toList();
    }
    map['availablePriceOptions'] = _availablePriceOptions;
    map['defaultNewHostPrice'] = _defaultNewHostPrice;
    map['freeCallEarning'] = _freeCallEarning;
    map['priceRaiseCountThisWeek'] = _priceRaiseCountThisWeek;
    return map;
  }
}

class LevelPriceTier {
  LevelPriceTier({
    String? levelRange,
    int? maxPrice,
  }) {
    _levelRange = levelRange;
    _maxPrice = maxPrice;
  }

  LevelPriceTier.fromJson(dynamic json) {
    _levelRange = json['levelRange'];
    _maxPrice = json['maxPrice'];
  }
  String? _levelRange;
  int? _maxPrice;

  String? get levelRange => _levelRange;
  int? get maxPrice => _maxPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['levelRange'] = _levelRange;
    map['maxPrice'] = _maxPrice;
    return map;
  }
}
