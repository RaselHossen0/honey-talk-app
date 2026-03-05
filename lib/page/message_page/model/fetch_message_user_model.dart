class FetchMessageUserModel {
  FetchMessageUserModel({
    bool? status,
    String? message,
    List<MessageData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchMessageUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MessageData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<MessageData>? _data;
  FetchMessageUserModel copyWith({
    bool? status,
    String? message,
    List<MessageData>? data,
  }) =>
      FetchMessageUserModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<MessageData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MessageData {
  MessageData({
    String? id,
    String? chatTopicId,
    String? senderId,
    String? message,
    int? unreadCount,
    String? userId,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isVerified,
    bool? isFake,
    String? time,
    int? wealthLevel,
    bool? isSystemMessage,
    bool? isContactCustomer,
    bool? isOnline,
  }) {
    _id = id;
    _chatTopicId = chatTopicId;
    _senderId = senderId;
    _message = message;
    _unreadCount = unreadCount;
    _userId = userId;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _isVerified = isVerified;
    _isFake = isFake;
    _time = time;
    _wealthLevel = wealthLevel;
    _isSystemMessage = isSystemMessage;
    _isContactCustomer = isContactCustomer;
    _isOnline = isOnline;
  }

  MessageData.fromJson(dynamic json) {
    _id = json['_id'];
    _chatTopicId = json['chatTopicId'];
    _senderId = json['senderId'];
    _message = json['message'];
    _unreadCount = json['unreadCount'];
    _userId = json['userId'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _isVerified = json['isVerified'];
    _isFake = json['isFake'];
    _time = json['time'];
    _wealthLevel = json['wealthLevel'];
    _isSystemMessage = json['isSystemMessage'];
    _isContactCustomer = json['isContactCustomer'];
    // API-ready: supports isOnline, is_online
    _isOnline = json['isOnline'] ?? json['is_online'];
  }
  String? _id;
  String? _chatTopicId;
  String? _senderId;
  String? _message;
  int? _unreadCount;
  String? _userId;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  bool? _isVerified;
  bool? _isFake;
  String? _time;
  int? _wealthLevel;
  bool? _isSystemMessage;
  bool? _isContactCustomer;
  bool? _isOnline;

  int? get wealthLevel => _wealthLevel;
  bool? get isSystemMessage => _isSystemMessage;
  bool? get isContactCustomer => _isContactCustomer;
  bool? get isOnline => _isOnline;

  MessageData copyWith({
    String? id,
    String? chatTopicId,
    String? senderId,
    String? message,
    int? unreadCount,
    String? userId,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isVerified,
    bool? isFake,
    String? time,
    int? wealthLevel,
    bool? isSystemMessage,
    bool? isContactCustomer,
    bool? isOnline,
  }) =>
      MessageData(
        id: id ?? _id,
        chatTopicId: chatTopicId ?? _chatTopicId,
        senderId: senderId ?? _senderId,
        message: message ?? _message,
        unreadCount: unreadCount ?? _unreadCount,
        userId: userId ?? _userId,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        isVerified: isVerified ?? _isVerified,
    isFake: isFake ?? _isFake,
    time: time ?? _time,
    wealthLevel: wealthLevel ?? _wealthLevel,
    isSystemMessage: isSystemMessage ?? _isSystemMessage,
    isContactCustomer: isContactCustomer ?? _isContactCustomer,
    isOnline: isOnline ?? _isOnline,
  );
  String? get id => _id;
  String? get chatTopicId => _chatTopicId;
  String? get senderId => _senderId;
  String? get message => _message;
  int? get unreadCount => _unreadCount;
  String? get userId => _userId;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  bool? get isVerified => _isVerified;
  bool? get isFake => _isFake;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['chatTopicId'] = _chatTopicId;
    map['senderId'] = _senderId;
    map['message'] = _message;
    map['unreadCount'] = _unreadCount;
    map['userId'] = _userId;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['isVerified'] = _isVerified;
    map['isFake'] = _isFake;
    map['time'] = _time;
    map['wealthLevel'] = _wealthLevel;
    map['isSystemMessage'] = _isSystemMessage;
    map['isContactCustomer'] = _isContactCustomer;
    map['isOnline'] = _isOnline;
    return map;
  }
}
