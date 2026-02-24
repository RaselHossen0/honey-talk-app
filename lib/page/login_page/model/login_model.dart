class LoginModel {
  bool? status;
  String? message;
  bool? signUp;
  UserData? user;

  LoginModel({this.status, this.message, this.signUp, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    signUp = json['signUp'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['signUp'] = signUp;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserData {
  String? name;
  String? userName;
  String? gender;
  String? bio;
  int? age;
  String? image;
  bool? isProfilePicBanned;
  String? email;
  String? mobileNumber;
  String? countryFlagImage;
  String? country;
  String? ipAddress;
  String? identity;
  String? fcmToken;
  String? uniqueId;
  String? uid;
  String? provider;
  int? coin;
  int? consumedCoins;
  int? purchasedCoin;
  int? receivedCoin;
  int? receivedGift;
  int? totalWithdrawalCoin;
  int? totalWithdrawalAmount;
  bool? isLive;
  String? liveHistoryId;
  bool? isBlock;
  bool? isOnline;
  bool? isFake;
  bool? isVerified;
  String? lastlogin;
  String? date;
  String? sId;
  int? loginType;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.name,
      this.userName,
      this.gender,
      this.bio,
      this.age,
      this.image,
      this.isProfilePicBanned,
      this.email,
      this.mobileNumber,
      this.countryFlagImage,
      this.country,
      this.ipAddress,
      this.identity,
      this.fcmToken,
      this.uniqueId,
      this.uid,
      this.provider,
      this.coin,
      this.consumedCoins,
      this.purchasedCoin,
      this.receivedCoin,
      this.receivedGift,
      this.totalWithdrawalCoin,
      this.totalWithdrawalAmount,
      this.isLive,
      this.liveHistoryId,
      this.isBlock,
      this.isOnline,
      this.isFake,
      this.isVerified,
      this.lastlogin,
      this.date,
      this.sId,
      this.loginType,
      this.createdAt,
      this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['userName'];
    gender = json['gender'];
    bio = json['bio'];
    age = json['age'];
    image = json['image'];
    isProfilePicBanned = json['isProfilePicBanned'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    countryFlagImage = json['countryFlagImage'];
    country = json['country'];
    ipAddress = json['ipAddress'];
    identity = json['identity'];
    fcmToken = json['fcmToken'];
    uniqueId = json['uniqueId'];
    uid = json['uid'];
    provider = json['provider'];
    coin = json['coin'];
    consumedCoins = json['consumedCoins'];
    purchasedCoin = json['purchasedCoin'];
    receivedCoin = json['receivedCoin'];
    receivedGift = json['receivedGift'];
    totalWithdrawalCoin = json['totalWithdrawalCoin'];
    totalWithdrawalAmount = json['totalWithdrawalAmount'];
    isLive = json['isLive'];
    liveHistoryId = json['liveHistoryId'];
    isBlock = json['isBlock'];
    isOnline = json['isOnline'];
    isFake = json['isFake'];
    isVerified = json['isVerified'];
    lastlogin = json['lastlogin'];
    date = json['date'];
    sId = json['_id'];
    loginType = json['loginType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['userName'] = userName;
    data['gender'] = gender;
    data['bio'] = bio;
    data['age'] = age;
    data['image'] = image;
    data['isProfilePicBanned'] = isProfilePicBanned;
    data['email'] = email;
    data['mobileNumber'] = mobileNumber;
    data['countryFlagImage'] = countryFlagImage;
    data['country'] = country;
    data['ipAddress'] = ipAddress;
    data['identity'] = identity;
    data['fcmToken'] = fcmToken;
    data['uniqueId'] = uniqueId;
    data['uid'] = uid;
    data['provider'] = provider;
    data['coin'] = coin;
    data['consumedCoins'] = consumedCoins;
    data['purchasedCoin'] = purchasedCoin;
    data['receivedCoin'] = receivedCoin;
    data['receivedGift'] = receivedGift;
    data['totalWithdrawalCoin'] = totalWithdrawalCoin;
    data['totalWithdrawalAmount'] = totalWithdrawalAmount;
    data['isLive'] = isLive;
    data['liveHistoryId'] = liveHistoryId;
    data['isBlock'] = isBlock;
    data['isOnline'] = isOnline;
    data['isFake'] = isFake;
    data['isVerified'] = isVerified;
    data['lastlogin'] = lastlogin;
    data['date'] = date;
    data['_id'] = sId;
    data['loginType'] = loginType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
