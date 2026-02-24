class FetchSettingModel {
  FetchSettingModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchSettingModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  FetchSettingModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      FetchSettingModel(
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
    Currency? currency,
    String? id,
    bool? isGooglePlayEnabled,
    bool? isStripeEnabled,
    String? stripePublishableKey,
    String? stripeSecretKey,
    bool? isRazorpayEnabled,
    String? razorPayId,
    String? razorSecretKey,
    bool? isFlutterwaveEnabled,
    String? flutterWaveId,
    String? privacyPolicyLink,
    String? termsOfUsePolicyLink,
    bool? isDummyData,
    int? loginBonus,
    int? privateCallRate,
    int? durationOfShorts,
    int? minCoinsToCashOut,
    int? minCoinsForPayout,
    int? pkEndTime,
    List<String>? videoBanned,
    List<String>? postBanned,
    String? sightengineUser,
    String? sightengineApiSecret,
    bool? shortsEffectEnabled,
    String? androidEffectLicenseKey,
    String? iosEffectLicenseKey,
    bool? watermarkEnabled,
    String? watermarkIcon,
    PrivateKey? privateKey,
    String? createdAt,
    String? updatedAt,
    List<String>? profilePhotoList,
  }) {
    _currency = currency;
    _id = id;
    _isGooglePlayEnabled = isGooglePlayEnabled;
    _isStripeEnabled = isStripeEnabled;
    _stripePublishableKey = stripePublishableKey;
    _stripeSecretKey = stripeSecretKey;
    _isRazorpayEnabled = isRazorpayEnabled;
    _razorPayId = razorPayId;
    _razorSecretKey = razorSecretKey;
    _isFlutterwaveEnabled = isFlutterwaveEnabled;
    _flutterWaveId = flutterWaveId;
    _privacyPolicyLink = privacyPolicyLink;
    _termsOfUsePolicyLink = termsOfUsePolicyLink;
    _isDummyData = isDummyData;
    _loginBonus = loginBonus;
    _privateCallRate = privateCallRate;
    _durationOfShorts = durationOfShorts;
    _minCoinsToCashOut = minCoinsToCashOut;
    _minCoinsForPayout = minCoinsForPayout;
    _pkEndTime = pkEndTime;
    _videoBanned = videoBanned;
    _postBanned = postBanned;
    _sightengineUser = sightengineUser;
    _sightengineApiSecret = sightengineApiSecret;
    _shortsEffectEnabled = shortsEffectEnabled;
    _androidEffectLicenseKey = androidEffectLicenseKey;
    _iosEffectLicenseKey = iosEffectLicenseKey;
    _watermarkEnabled = watermarkEnabled;
    _watermarkIcon = watermarkIcon;
    _privateKey = privateKey;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _profilePhotoList = profilePhotoList;
  }

  Data.fromJson(dynamic json) {
    _currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    _id = json['_id'];
    _isGooglePlayEnabled = json['isGooglePlayEnabled'];
    _isStripeEnabled = json['isStripeEnabled'];
    _stripePublishableKey = json['stripePublishableKey'];
    _stripeSecretKey = json['stripeSecretKey'];
    _isRazorpayEnabled = json['isRazorpayEnabled'];
    _razorPayId = json['razorPayId'];
    _razorSecretKey = json['razorSecretKey'];
    _isFlutterwaveEnabled = json['isFlutterwaveEnabled'];
    _flutterWaveId = json['flutterWaveId'];
    _privacyPolicyLink = json['privacyPolicyLink'];
    _termsOfUsePolicyLink = json['termsOfUsePolicyLink'];
    _isDummyData = json['isDummyData'];
    _loginBonus = json['loginBonus'];
    _privateCallRate = json['privateCallRate'];
    _durationOfShorts = json['durationOfShorts'];
    _minCoinsToCashOut = json['minCoinsToCashOut'];
    _minCoinsForPayout = json['minCoinsForPayout'];
    _pkEndTime = json['pkEndTime'];
    _videoBanned = json['videoBanned'] != null ? json['videoBanned'].cast<String>() : [];
    _postBanned = json['postBanned'] != null ? json['postBanned'].cast<String>() : [];
    _sightengineUser = json['sightengineUser'];
    _sightengineApiSecret = json['sightengineApiSecret'];
    _shortsEffectEnabled = json['shortsEffectEnabled'];
    _androidEffectLicenseKey = json['androidEffectLicenseKey'];
    _iosEffectLicenseKey = json['iosEffectLicenseKey'];
    _watermarkEnabled = json['watermarkEnabled'];
    _watermarkIcon = json['watermarkIcon'];
    _privateKey = json['privateKey'] != null ? PrivateKey.fromJson(json['privateKey']) : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _profilePhotoList = json['profilePhotoList'] != null ? json['profilePhotoList'].cast<String>() : [];
  }
  Currency? _currency;
  String? _id;
  bool? _isGooglePlayEnabled;
  bool? _isStripeEnabled;
  String? _stripePublishableKey;
  String? _stripeSecretKey;
  bool? _isRazorpayEnabled;
  String? _razorPayId;
  String? _razorSecretKey;
  bool? _isFlutterwaveEnabled;
  String? _flutterWaveId;
  String? _privacyPolicyLink;
  String? _termsOfUsePolicyLink;
  bool? _isDummyData;
  int? _loginBonus;
  int? _privateCallRate;
  int? _durationOfShorts;
  int? _minCoinsToCashOut;
  int? _minCoinsForPayout;
  int? _pkEndTime;
  List<String>? _videoBanned;
  List<String>? _postBanned;
  String? _sightengineUser;
  String? _sightengineApiSecret;
  bool? _shortsEffectEnabled;
  String? _androidEffectLicenseKey;
  String? _iosEffectLicenseKey;
  bool? _watermarkEnabled;
  String? _watermarkIcon;
  PrivateKey? _privateKey;
  String? _createdAt;
  String? _updatedAt;
  List<String>? _profilePhotoList;
  Data copyWith({
    Currency? currency,
    String? id,
    bool? isGooglePlayEnabled,
    bool? isStripeEnabled,
    String? stripePublishableKey,
    String? stripeSecretKey,
    bool? isRazorpayEnabled,
    String? razorPayId,
    String? razorSecretKey,
    bool? isFlutterwaveEnabled,
    String? flutterWaveId,
    String? privacyPolicyLink,
    String? termsOfUsePolicyLink,
    bool? isDummyData,
    int? loginBonus,
    int? privateCallRate,
    int? durationOfShorts,
    int? minCoinsToCashOut,
    int? minCoinsForPayout,
    int? pkEndTime,
    List<String>? videoBanned,
    List<String>? postBanned,
    String? sightengineUser,
    String? sightengineApiSecret,
    bool? shortsEffectEnabled,
    String? androidEffectLicenseKey,
    String? iosEffectLicenseKey,
    bool? watermarkEnabled,
    String? watermarkIcon,
    PrivateKey? privateKey,
    String? createdAt,
    String? updatedAt,
    List<String>? profilePhotoList,
  }) =>
      Data(
        currency: currency ?? _currency,
        id: id ?? _id,
        isGooglePlayEnabled: isGooglePlayEnabled ?? _isGooglePlayEnabled,
        isStripeEnabled: isStripeEnabled ?? _isStripeEnabled,
        stripePublishableKey: stripePublishableKey ?? _stripePublishableKey,
        stripeSecretKey: stripeSecretKey ?? _stripeSecretKey,
        isRazorpayEnabled: isRazorpayEnabled ?? _isRazorpayEnabled,
        razorPayId: razorPayId ?? _razorPayId,
        razorSecretKey: razorSecretKey ?? _razorSecretKey,
        isFlutterwaveEnabled: isFlutterwaveEnabled ?? _isFlutterwaveEnabled,
        flutterWaveId: flutterWaveId ?? _flutterWaveId,
        privacyPolicyLink: privacyPolicyLink ?? _privacyPolicyLink,
        termsOfUsePolicyLink: termsOfUsePolicyLink ?? _termsOfUsePolicyLink,
        isDummyData: isDummyData ?? _isDummyData,
        loginBonus: loginBonus ?? _loginBonus,
        privateCallRate: privateCallRate ?? _privateCallRate,
        durationOfShorts: durationOfShorts ?? _durationOfShorts,
        minCoinsToCashOut: minCoinsToCashOut ?? _minCoinsToCashOut,
        minCoinsForPayout: minCoinsForPayout ?? _minCoinsForPayout,
        pkEndTime: pkEndTime ?? _pkEndTime,
        videoBanned: videoBanned ?? _videoBanned,
        postBanned: postBanned ?? _postBanned,
        sightengineUser: sightengineUser ?? _sightengineUser,
        sightengineApiSecret: sightengineApiSecret ?? _sightengineApiSecret,
        shortsEffectEnabled: shortsEffectEnabled ?? _shortsEffectEnabled,
        androidEffectLicenseKey: androidEffectLicenseKey ?? _androidEffectLicenseKey,
        iosEffectLicenseKey: iosEffectLicenseKey ?? _iosEffectLicenseKey,
        watermarkEnabled: watermarkEnabled ?? _watermarkEnabled,
        watermarkIcon: watermarkIcon ?? _watermarkIcon,
        privateKey: privateKey ?? _privateKey,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        profilePhotoList: profilePhotoList ?? _profilePhotoList,
      );
  Currency? get currency => _currency;
  String? get id => _id;
  bool? get isGooglePlayEnabled => _isGooglePlayEnabled;
  bool? get isStripeEnabled => _isStripeEnabled;
  String? get stripePublishableKey => _stripePublishableKey;
  String? get stripeSecretKey => _stripeSecretKey;
  bool? get isRazorpayEnabled => _isRazorpayEnabled;
  String? get razorPayId => _razorPayId;
  String? get razorSecretKey => _razorSecretKey;
  bool? get isFlutterwaveEnabled => _isFlutterwaveEnabled;
  String? get flutterWaveId => _flutterWaveId;
  String? get privacyPolicyLink => _privacyPolicyLink;
  String? get termsOfUsePolicyLink => _termsOfUsePolicyLink;
  bool? get isDummyData => _isDummyData;
  int? get loginBonus => _loginBonus;
  int? get privateCallRate => _privateCallRate;
  int? get durationOfShorts => _durationOfShorts;
  int? get minCoinsToCashOut => _minCoinsToCashOut;
  int? get minCoinsForPayout => _minCoinsForPayout;
  int? get pkEndTime => _pkEndTime;
  List<String>? get videoBanned => _videoBanned;
  List<String>? get postBanned => _postBanned;
  String? get sightengineUser => _sightengineUser;
  String? get sightengineApiSecret => _sightengineApiSecret;
  bool? get shortsEffectEnabled => _shortsEffectEnabled;
  String? get androidEffectLicenseKey => _androidEffectLicenseKey;
  String? get iosEffectLicenseKey => _iosEffectLicenseKey;
  bool? get watermarkEnabled => _watermarkEnabled;
  String? get watermarkIcon => _watermarkIcon;
  PrivateKey? get privateKey => _privateKey;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<String>? get profilePhotoList => _profilePhotoList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_currency != null) {
      map['currency'] = _currency?.toJson();
    }
    map['_id'] = _id;
    map['isGooglePlayEnabled'] = _isGooglePlayEnabled;
    map['isStripeEnabled'] = _isStripeEnabled;
    map['stripePublishableKey'] = _stripePublishableKey;
    map['stripeSecretKey'] = _stripeSecretKey;
    map['isRazorpayEnabled'] = _isRazorpayEnabled;
    map['razorPayId'] = _razorPayId;
    map['razorSecretKey'] = _razorSecretKey;
    map['isFlutterwaveEnabled'] = _isFlutterwaveEnabled;
    map['flutterWaveId'] = _flutterWaveId;
    map['privacyPolicyLink'] = _privacyPolicyLink;
    map['termsOfUsePolicyLink'] = _termsOfUsePolicyLink;
    map['isDummyData'] = _isDummyData;
    map['loginBonus'] = _loginBonus;
    map['privateCallRate'] = _privateCallRate;
    map['durationOfShorts'] = _durationOfShorts;
    map['minCoinsToCashOut'] = _minCoinsToCashOut;
    map['minCoinsForPayout'] = _minCoinsForPayout;
    map['pkEndTime'] = _pkEndTime;
    map['videoBanned'] = _videoBanned;
    map['postBanned'] = _postBanned;
    map['sightengineUser'] = _sightengineUser;
    map['sightengineApiSecret'] = _sightengineApiSecret;
    map['shortsEffectEnabled'] = _shortsEffectEnabled;
    map['androidEffectLicenseKey'] = _androidEffectLicenseKey;
    map['iosEffectLicenseKey'] = _iosEffectLicenseKey;
    map['watermarkEnabled'] = _watermarkEnabled;
    map['watermarkIcon'] = _watermarkIcon;
    if (_privateKey != null) {
      map['privateKey'] = _privateKey?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['profilePhotoList'] = _profilePhotoList;
    return map;
  }
}

class PrivateKey {
  PrivateKey({
    String? type,
    String? projectId,
    String? privateKeyId,
    String? privateKey,
    String? clientEmail,
    String? clientId,
    String? authUri,
    String? tokenUri,
    String? authProviderX509CertUrl,
    String? clientX509CertUrl,
    String? universeDomain,
  }) {
    _type = type;
    _projectId = projectId;
    _privateKeyId = privateKeyId;
    _privateKey = privateKey;
    _clientEmail = clientEmail;
    _clientId = clientId;
    _authUri = authUri;
    _tokenUri = tokenUri;
    _authProviderX509CertUrl = authProviderX509CertUrl;
    _clientX509CertUrl = clientX509CertUrl;
    _universeDomain = universeDomain;
  }

  PrivateKey.fromJson(dynamic json) {
    _type = json['type'];
    _projectId = json['project_id'];
    _privateKeyId = json['private_key_id'];
    _privateKey = json['private_key'];
    _clientEmail = json['client_email'];
    _clientId = json['client_id'];
    _authUri = json['auth_uri'];
    _tokenUri = json['token_uri'];
    _authProviderX509CertUrl = json['auth_provider_x509_cert_url'];
    _clientX509CertUrl = json['client_x509_cert_url'];
    _universeDomain = json['universe_domain'];
  }
  String? _type;
  String? _projectId;
  String? _privateKeyId;
  String? _privateKey;
  String? _clientEmail;
  String? _clientId;
  String? _authUri;
  String? _tokenUri;
  String? _authProviderX509CertUrl;
  String? _clientX509CertUrl;
  String? _universeDomain;
  PrivateKey copyWith({
    String? type,
    String? projectId,
    String? privateKeyId,
    String? privateKey,
    String? clientEmail,
    String? clientId,
    String? authUri,
    String? tokenUri,
    String? authProviderX509CertUrl,
    String? clientX509CertUrl,
    String? universeDomain,
  }) =>
      PrivateKey(
        type: type ?? _type,
        projectId: projectId ?? _projectId,
        privateKeyId: privateKeyId ?? _privateKeyId,
        privateKey: privateKey ?? _privateKey,
        clientEmail: clientEmail ?? _clientEmail,
        clientId: clientId ?? _clientId,
        authUri: authUri ?? _authUri,
        tokenUri: tokenUri ?? _tokenUri,
        authProviderX509CertUrl: authProviderX509CertUrl ?? _authProviderX509CertUrl,
        clientX509CertUrl: clientX509CertUrl ?? _clientX509CertUrl,
        universeDomain: universeDomain ?? _universeDomain,
      );
  String? get type => _type;
  String? get projectId => _projectId;
  String? get privateKeyId => _privateKeyId;
  String? get privateKey => _privateKey;
  String? get clientEmail => _clientEmail;
  String? get clientId => _clientId;
  String? get authUri => _authUri;
  String? get tokenUri => _tokenUri;
  String? get authProviderX509CertUrl => _authProviderX509CertUrl;
  String? get clientX509CertUrl => _clientX509CertUrl;
  String? get universeDomain => _universeDomain;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['project_id'] = _projectId;
    map['private_key_id'] = _privateKeyId;
    map['private_key'] = _privateKey;
    map['client_email'] = _clientEmail;
    map['client_id'] = _clientId;
    map['auth_uri'] = _authUri;
    map['token_uri'] = _tokenUri;
    map['auth_provider_x509_cert_url'] = _authProviderX509CertUrl;
    map['client_x509_cert_url'] = _clientX509CertUrl;
    map['universe_domain'] = _universeDomain;
    return map;
  }
}

class Currency {
  Currency({
    String? name,
    String? symbol,
    String? countryCode,
    String? currencyCode,
    bool? isDefault,
  }) {
    _name = name;
    _symbol = symbol;
    _countryCode = countryCode;
    _currencyCode = currencyCode;
    _isDefault = isDefault;
  }

  Currency.fromJson(dynamic json) {
    _name = json['name'];
    _symbol = json['symbol'];
    _countryCode = json['countryCode'];
    _currencyCode = json['currencyCode'];
    _isDefault = json['isDefault'];
  }
  String? _name;
  String? _symbol;
  String? _countryCode;
  String? _currencyCode;
  bool? _isDefault;
  Currency copyWith({
    String? name,
    String? symbol,
    String? countryCode,
    String? currencyCode,
    bool? isDefault,
  }) =>
      Currency(
        name: name ?? _name,
        symbol: symbol ?? _symbol,
        countryCode: countryCode ?? _countryCode,
        currencyCode: currencyCode ?? _currencyCode,
        isDefault: isDefault ?? _isDefault,
      );
  String? get name => _name;
  String? get symbol => _symbol;
  String? get countryCode => _countryCode;
  String? get currencyCode => _currencyCode;
  bool? get isDefault => _isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['symbol'] = _symbol;
    map['countryCode'] = _countryCode;
    map['currencyCode'] = _currencyCode;
    map['isDefault'] = _isDefault;
    return map;
  }
}
