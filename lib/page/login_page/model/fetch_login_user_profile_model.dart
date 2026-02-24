class FetchLoginUserProfileModel {
  FetchLoginUserProfileModel({
    bool? status,
    String? message,
    MyUser? user,
  }) {
    _status = status;
    _message = message;
    _user = user;
  }

  FetchLoginUserProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _user = json['user'] != null ? MyUser.fromJson(json['user']) : null;
  }
  bool? _status;
  String? _message;
  MyUser? _user;
  FetchLoginUserProfileModel copyWith({
    bool? status,
    String? message,
    MyUser? user,
  }) =>
      FetchLoginUserProfileModel(
        status: status ?? _status,
        message: message ?? _message,
        user: user ?? _user,
      );
  bool? get status => _status;
  String? get message => _message;
  MyUser? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class MyUser {
  MyUser({
    String? id,
    String? name,
    String? userName,
    String? gender,
    String? bio,
    int? age,
    String? image,
    bool? isProfilePicBanned,
    String? email,
    String? mobileNumber,
    String? countryFlagImage,
    String? country,
    String? ipAddress,
    String? identity,
    String? fcmToken,
    String? uniqueId,
    String? firebaseUid,
    String? provider,
    int? coin,
    int? topUpCoins,
    int? spentCoins,
    int? receivedCoins,
    int? receivedGifts,
    int? withdrawnCoins,
    int? withdrawnAmount,
    String? wealthLevel,
    ActiveAvtarFrame? activeAvtarFrame,
    ActiveTheme? activeTheme,
    ActiveRide? activeRide,
    bool? isBlock,
    bool? isFake,
    bool? isVerified,
    bool? isOnline,
    bool? isBusy,
    bool? isVIP,
    int? role,
    String? agencyId,
    String? agencyOwnerId,
    bool? isLive,
    String? liveHistoryId,
    String? callId,
    String? lastlogin,
    String? date,
    String? referralCode,
    int? loginType,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _gender = gender;
    _bio = bio;
    _age = age;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _email = email;
    _mobileNumber = mobileNumber;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _ipAddress = ipAddress;
    _identity = identity;
    _fcmToken = fcmToken;
    _uniqueId = uniqueId;
    _firebaseUid = firebaseUid;
    _provider = provider;
    _coin = coin;
    _topUpCoins = topUpCoins;
    _spentCoins = spentCoins;
    _receivedCoins = receivedCoins;
    _receivedGifts = receivedGifts;
    _withdrawnCoins = withdrawnCoins;
    _withdrawnAmount = withdrawnAmount;
    _wealthLevel = wealthLevel;
    _activeAvtarFrame = activeAvtarFrame;
    _activeTheme = activeTheme;
    _activeRide = activeRide;
    _isBlock = isBlock;
    _isFake = isFake;
    _isVerified = isVerified;
    _isOnline = isOnline;
    _isBusy = isBusy;
    _isVIP = isVIP;
    _role = role;
    _agencyId = agencyId;
    _agencyOwnerId = agencyOwnerId;
    _isLive = isLive;
    _liveHistoryId = liveHistoryId;
    _callId = callId;
    _lastlogin = lastlogin;
    _date = date;
    _referralCode = referralCode;
    _loginType = loginType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  MyUser.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _gender = json['gender'];
    _bio = json['bio'];
    _age = json['age'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _email = json['email'];
    _mobileNumber = json['mobileNumber'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _ipAddress = json['ipAddress'];
    _identity = json['identity'];
    _fcmToken = json['fcmToken'];
    _uniqueId = json['uniqueId'];
    _firebaseUid = json['firebaseUid'];
    _provider = json['provider'];
    _coin = json['coin'];
    _topUpCoins = json['topUpCoins'];
    _spentCoins = json['spentCoins'];
    _receivedCoins = json['receivedCoins'];
    _receivedGifts = json['receivedGifts'];
    _withdrawnCoins = json['withdrawnCoins'];
    _withdrawnAmount = json['withdrawnAmount'];
    _wealthLevel = json['wealthLevel'];
    _activeAvtarFrame = json['activeAvtarFrame'] != null ? ActiveAvtarFrame.fromJson(json['activeAvtarFrame']) : null;
    _activeTheme = json['activeTheme'] != null ? ActiveTheme.fromJson(json['activeTheme']) : null;
    _activeRide = json['activeRide'] != null ? ActiveRide.fromJson(json['activeRide']) : null;
    _isBlock = json['isBlock'];
    _isFake = json['isFake'];
    _isVerified = json['isVerified'];
    _isOnline = json['isOnline'];
    _isBusy = json['isBusy'];
    _isVIP = json['isVIP'];
    _role = json['role'];
    _agencyId = json['agencyId'];
    _agencyOwnerId = json['agencyOwnerId'];
    _isLive = json['isLive'];
    _liveHistoryId = json['liveHistoryId'];
    _callId = json['callId'];
    _lastlogin = json['lastlogin'];
    _date = json['date'];
    _referralCode = json['referralCode'];
    _loginType = json['loginType'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _gender;
  String? _bio;
  int? _age;
  String? _image;
  bool? _isProfilePicBanned;
  String? _email;
  String? _mobileNumber;
  String? _countryFlagImage;
  String? _country;
  String? _ipAddress;
  String? _identity;
  String? _fcmToken;
  String? _uniqueId;
  String? _firebaseUid;
  String? _provider;
  int? _coin;
  int? _topUpCoins;
  int? _spentCoins;
  int? _receivedCoins;
  int? _receivedGifts;
  int? _withdrawnCoins;
  int? _withdrawnAmount;
  String? _wealthLevel;
  ActiveAvtarFrame? _activeAvtarFrame;
  ActiveTheme? _activeTheme;
  ActiveRide? _activeRide;
  bool? _isBlock;
  bool? _isFake;
  bool? _isVerified;
  bool? _isOnline;
  bool? _isBusy;
  bool? _isVIP;
  int? _role;
  String? _agencyId;
  String? _agencyOwnerId;
  bool? _isLive;
  String? _liveHistoryId;
  String? _callId;
  String? _lastlogin;
  String? _date;
  String? _referralCode;
  int? _loginType;
  String? _createdAt;
  String? _updatedAt;
  MyUser copyWith({
    String? id,
    String? name,
    String? userName,
    String? gender,
    String? bio,
    int? age,
    String? image,
    bool? isProfilePicBanned,
    String? email,
    String? mobileNumber,
    String? countryFlagImage,
    String? country,
    String? ipAddress,
    String? identity,
    String? fcmToken,
    String? uniqueId,
    String? firebaseUid,
    String? provider,
    int? coin,
    int? topUpCoins,
    int? spentCoins,
    int? receivedCoins,
    int? receivedGifts,
    int? withdrawnCoins,
    int? withdrawnAmount,
    String? wealthLevel,
    ActiveAvtarFrame? activeAvtarFrame,
    ActiveTheme? activeTheme,
    ActiveRide? activeRide,
    bool? isBlock,
    bool? isFake,
    bool? isVerified,
    bool? isOnline,
    bool? isBusy,
    bool? isVIP,
    int? role,
    String? agencyId,
    String? agencyOwnerId,
    bool? isLive,
    String? liveHistoryId,
    String? callId,
    String? lastlogin,
    String? date,
    String? referralCode,
    int? loginType,
    String? createdAt,
    String? updatedAt,
  }) =>
      MyUser(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        gender: gender ?? _gender,
        bio: bio ?? _bio,
        age: age ?? _age,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        email: email ?? _email,
        mobileNumber: mobileNumber ?? _mobileNumber,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        ipAddress: ipAddress ?? _ipAddress,
        identity: identity ?? _identity,
        fcmToken: fcmToken ?? _fcmToken,
        uniqueId: uniqueId ?? _uniqueId,
        firebaseUid: firebaseUid ?? _firebaseUid,
        provider: provider ?? _provider,
        coin: coin ?? _coin,
        topUpCoins: topUpCoins ?? _topUpCoins,
        spentCoins: spentCoins ?? _spentCoins,
        receivedCoins: receivedCoins ?? _receivedCoins,
        receivedGifts: receivedGifts ?? _receivedGifts,
        withdrawnCoins: withdrawnCoins ?? _withdrawnCoins,
        withdrawnAmount: withdrawnAmount ?? _withdrawnAmount,
        wealthLevel: wealthLevel ?? _wealthLevel,
        activeAvtarFrame: activeAvtarFrame ?? _activeAvtarFrame,
        activeTheme: activeTheme ?? _activeTheme,
        activeRide: activeRide ?? _activeRide,
        isBlock: isBlock ?? _isBlock,
        isFake: isFake ?? _isFake,
        isVerified: isVerified ?? _isVerified,
        isOnline: isOnline ?? _isOnline,
        isBusy: isBusy ?? _isBusy,
        isVIP: isVIP ?? _isVIP,
        role: role ?? _role,
        agencyId: agencyId ?? _agencyId,
        agencyOwnerId: agencyOwnerId ?? _agencyOwnerId,
        isLive: isLive ?? _isLive,
        liveHistoryId: liveHistoryId ?? _liveHistoryId,
        callId: callId ?? _callId,
        lastlogin: lastlogin ?? _lastlogin,
        date: date ?? _date,
        referralCode: referralCode ?? _referralCode,
        loginType: loginType ?? _loginType,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get gender => _gender;
  String? get bio => _bio;
  int? get age => _age;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get email => _email;
  String? get mobileNumber => _mobileNumber;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  String? get ipAddress => _ipAddress;
  String? get identity => _identity;
  String? get fcmToken => _fcmToken;
  String? get uniqueId => _uniqueId;
  String? get firebaseUid => _firebaseUid;
  String? get provider => _provider;
  int? get coin => _coin;
  int? get topUpCoins => _topUpCoins;
  int? get spentCoins => _spentCoins;
  int? get receivedCoins => _receivedCoins;
  int? get receivedGifts => _receivedGifts;
  int? get withdrawnCoins => _withdrawnCoins;
  int? get withdrawnAmount => _withdrawnAmount;
  String? get wealthLevel => _wealthLevel;
  ActiveAvtarFrame? get activeAvtarFrame => _activeAvtarFrame;
  ActiveTheme? get activeTheme => _activeTheme;
  ActiveRide? get activeRide => _activeRide;
  bool? get isBlock => _isBlock;
  bool? get isFake => _isFake;
  bool? get isVerified => _isVerified;
  bool? get isOnline => _isOnline;
  bool? get isBusy => _isBusy;
  bool? get isVIP => _isVIP;
  int? get role => _role;
  String? get agencyId => _agencyId;
  String? get agencyOwnerId => _agencyOwnerId;
  bool? get isLive => _isLive;
  String? get liveHistoryId => _liveHistoryId;
  String? get callId => _callId;
  String? get lastlogin => _lastlogin;
  String? get date => _date;
  String? get referralCode => _referralCode;
  int? get loginType => _loginType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['gender'] = _gender;
    map['bio'] = _bio;
    map['age'] = _age;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['email'] = _email;
    map['mobileNumber'] = _mobileNumber;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    map['ipAddress'] = _ipAddress;
    map['identity'] = _identity;
    map['fcmToken'] = _fcmToken;
    map['uniqueId'] = _uniqueId;
    map['firebaseUid'] = _firebaseUid;
    map['provider'] = _provider;
    map['coin'] = _coin;
    map['topUpCoins'] = _topUpCoins;
    map['spentCoins'] = _spentCoins;
    map['receivedCoins'] = _receivedCoins;
    map['receivedGifts'] = _receivedGifts;
    map['withdrawnCoins'] = _withdrawnCoins;
    map['withdrawnAmount'] = _withdrawnAmount;
    map['wealthLevel'] = _wealthLevel;
    if (_activeAvtarFrame != null) {
      map['activeAvtarFrame'] = _activeAvtarFrame?.toJson();
    }
    if (_activeTheme != null) {
      map['activeTheme'] = _activeTheme?.toJson();
    }
    if (_activeRide != null) {
      map['activeRide'] = _activeRide?.toJson();
    }
    map['isBlock'] = _isBlock;
    map['isFake'] = _isFake;
    map['isVerified'] = _isVerified;
    map['isOnline'] = _isOnline;
    map['isBusy'] = _isBusy;
    map['isVIP'] = _isVIP;
    map['role'] = _role;
    map['agencyId'] = _agencyId;
    map['agencyOwnerId'] = _agencyOwnerId;
    map['isLive'] = _isLive;
    map['liveHistoryId'] = _liveHistoryId;
    map['callId'] = _callId;
    map['lastlogin'] = _lastlogin;
    map['date'] = _date;
    map['referralCode'] = _referralCode;
    map['loginType'] = _loginType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

class ActiveRide {
  ActiveRide({
    String? id,
    int? type,
    String? image,
  }) {
    _id = id;
    _type = type;
    _image = image;
  }

  ActiveRide.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _image = json['image'];
  }
  String? _id;
  int? _type;
  String? _image;
  ActiveRide copyWith({
    String? id,
    int? type,
    String? image,
  }) =>
      ActiveRide(
        id: id ?? _id,
        type: type ?? _type,
        image: image ?? _image,
      );
  String? get id => _id;
  int? get type => _type;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['image'] = _image;
    return map;
  }
}

class ActiveTheme {
  ActiveTheme({
    String? id,
    String? image,
  }) {
    _id = id;
    _image = image;
  }

  ActiveTheme.fromJson(dynamic json) {
    _id = json['_id'];
    _image = json['image'];
  }
  String? _id;
  String? _image;
  ActiveTheme copyWith({
    String? id,
    String? image,
  }) =>
      ActiveTheme(
        id: id ?? _id,
        image: image ?? _image,
      );
  String? get id => _id;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image'] = _image;
    return map;
  }
}

class ActiveAvtarFrame {
  ActiveAvtarFrame({
    String? id,
    int? type,
    String? image,
  }) {
    _id = id;
    _type = type;
    _image = image;
  }

  ActiveAvtarFrame.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _image = json['image'];
  }
  String? _id;
  int? _type;
  String? _image;
  ActiveAvtarFrame copyWith({
    String? id,
    int? type,
    String? image,
  }) =>
      ActiveAvtarFrame(
        id: id ?? _id,
        type: type ?? _type,
        image: image ?? _image,
      );
  String? get id => _id;
  int? get type => _type;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['image'] = _image;
    return map;
  }
}
