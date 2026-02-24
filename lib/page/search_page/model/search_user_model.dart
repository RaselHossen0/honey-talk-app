class SearchUserModel {
  SearchUserModel({
    bool? status,
    String? message,
    List<SearchUserData>? searchData,
  }) {
    _status = status;
    _message = message;
    _searchData = searchData;
  }

  SearchUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['searchData'] != null) {
      _searchData = [];
      json['searchData'].forEach((v) {
        _searchData?.add(SearchUserData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<SearchUserData>? _searchData;
  SearchUserModel copyWith({
    bool? status,
    String? message,
    List<SearchUserData>? searchData,
  }) =>
      SearchUserModel(
        status: status ?? _status,
        message: message ?? _message,
        searchData: searchData ?? _searchData,
      );
  bool? get status => _status;
  String? get message => _message;
  List<SearchUserData>? get searchData => _searchData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_searchData != null) {
      map['searchData'] = _searchData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SearchUserData {
  SearchUserData({
    String? id,
    String? name,
    String? userName,
    int? age,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    String? uniqueId,
    int? coin,
    String? wealthLevel,
    bool? isFake,
    bool? isVerified,
    bool? isOnline,
    String? createdAt,
    bool? isFollow,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _age = age;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _uniqueId = uniqueId;
    _coin = coin;
    _wealthLevel = wealthLevel;
    _isFake = isFake;
    _isVerified = isVerified;
    _isOnline = isOnline;
    _createdAt = createdAt;
    _isFollow = isFollow;
  }

  SearchUserData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _age = json['age'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _uniqueId = json['uniqueId'];
    _coin = json['coin'];
    _wealthLevel = json['wealthLevel'];
    _isFake = json['isFake'];
    _isVerified = json['isVerified'];
    _isOnline = json['isOnline'];
    _createdAt = json['createdAt'];
    _isFollow = json['isFollow'];
  }
  String? _id;
  String? _name;
  String? _userName;
  int? _age;
  String? _image;
  bool? _isProfilePicBanned;
  String? _countryFlagImage;
  String? _country;
  String? _uniqueId;
  int? _coin;
  String? _wealthLevel;
  bool? _isFake;
  bool? _isVerified;
  bool? _isOnline;
  String? _createdAt;
  bool? _isFollow;
  SearchUserData copyWith({
    String? id,
    String? name,
    String? userName,
    int? age,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    String? uniqueId,
    int? coin,
    String? wealthLevel,
    bool? isFake,
    bool? isVerified,
    bool? isOnline,
    String? createdAt,
    bool? isFollow,
  }) =>
      SearchUserData(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        age: age ?? _age,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        uniqueId: uniqueId ?? _uniqueId,
        coin: coin ?? _coin,
        wealthLevel: wealthLevel ?? _wealthLevel,
        isFake: isFake ?? _isFake,
        isVerified: isVerified ?? _isVerified,
        isOnline: isOnline ?? _isOnline,
        createdAt: createdAt ?? _createdAt,
        isFollow: isFollow ?? _isFollow,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  int? get age => _age;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  String? get uniqueId => _uniqueId;
  int? get coin => _coin;
  String? get wealthLevel => _wealthLevel;
  bool? get isFake => _isFake;
  bool? get isVerified => _isVerified;
  bool? get isOnline => _isOnline;
  String? get createdAt => _createdAt;
  bool? get isFollow => _isFollow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['age'] = _age;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    map['uniqueId'] = _uniqueId;
    map['coin'] = _coin;
    map['wealthLevel'] = _wealthLevel;
    map['isFake'] = _isFake;
    map['isVerified'] = _isVerified;
    map['isOnline'] = _isOnline;
    map['createdAt'] = _createdAt;
    map['isFollow'] = _isFollow;
    return map;
  }
}
