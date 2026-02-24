// class Aaa {
//   Aaa({
//     bool? status,
//     String? message,
//     List<LiveUserList>? liveUserList,
//   }) {
//     _status = status;
//     _message = message;
//     _liveUserList = liveUserList;
//   }
//
//   Aaa.fromJson(dynamic json) {
//     _status = json['status'];
//     _message = json['message'];
//     if (json['liveUserList'] != null) {
//       _liveUserList = [];
//       json['liveUserList'].forEach((v) {
//         _liveUserList?.add(LiveUserList.fromJson(v));
//       });
//     }
//   }
//   bool? _status;
//   String? _message;
//   List<LiveUserList>? _liveUserList;
//   Aaa copyWith({
//     bool? status,
//     String? message,
//     List<LiveUserList>? liveUserList,
//   }) =>
//       Aaa(
//         status: status ?? _status,
//         message: message ?? _message,
//         liveUserList: liveUserList ?? _liveUserList,
//       );
//   bool? get status => _status;
//   String? get message => _message;
//   List<LiveUserList>? get liveUserList => _liveUserList;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = _status;
//     map['message'] = _message;
//     if (_liveUserList != null) {
//       map['liveUserList'] = _liveUserList?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// class LiveUserList {
//   LiveUserList({
//     String? id,
//     String? userId,
//     String? liveHistoryId,
//     int? agoraUid,
//     String? channel,
//     String? token,
//     int? view,
//     int? liveType,
//     bool? isPkMode,
//     int? audioLiveType,
//     int? privateCode,
//     String? roomName,
//     String? roomWelcome,
//     String? roomImage,
//     bool? isAudio,
//     int? hostIsMuted,
//     List<Seat>? seat,
//     String? name,
//     String? userName,
//     String? image,
//     String? countryFlagImage,
//     String? country,
//     bool? isVerified,
//     dynamic host2Id,
//     dynamic host2UniqueId,
//     String? host2Name,
//     String? host2userName,
//     String? host2Image,
//     String? host2Channel,
//     String? host2LiveId,
//     String? host2Token,
//     bool? host2IsFollow,
//     bool? isFollow,
//     List<Viewers>? viewers,
//   }) {
//     _id = id;
//     _userId = userId;
//     _liveHistoryId = liveHistoryId;
//     _agoraUid = agoraUid;
//     _channel = channel;
//     _token = token;
//     _view = view;
//     _liveType = liveType;
//     _isPkMode = isPkMode;
//     _audioLiveType = audioLiveType;
//     _privateCode = privateCode;
//     _roomName = roomName;
//     _roomWelcome = roomWelcome;
//     _roomImage = roomImage;
//     _isAudio = isAudio;
//     _hostIsMuted = hostIsMuted;
//     _seat = seat;
//     _name = name;
//     _userName = userName;
//     _image = image;
//     _countryFlagImage = countryFlagImage;
//     _country = country;
//     _isVerified = isVerified;
//     _host2Id = host2Id;
//     _host2UniqueId = host2UniqueId;
//     _host2Name = host2Name;
//     _host2userName = host2userName;
//     _host2Image = host2Image;
//     _host2Channel = host2Channel;
//     _host2LiveId = host2LiveId;
//     _host2Token = host2Token;
//     _host2IsFollow = host2IsFollow;
//     _isFollow = isFollow;
//     _viewers = viewers;
//   }
//
//   LiveUserList.fromJson(dynamic json) {
//     _id = json['_id'];
//     _userId = json['userId'];
//     _liveHistoryId = json['liveHistoryId'];
//     _agoraUid = json['agoraUid'];
//     _channel = json['channel'];
//     _token = json['token'];
//     _view = json['view'];
//     _liveType = json['liveType'];
//     _isPkMode = json['isPkMode'];
//     _audioLiveType = json['audioLiveType'];
//     _privateCode = json['privateCode'];
//     _roomName = json['roomName'];
//     _roomWelcome = json['roomWelcome'];
//     _roomImage = json['roomImage'];
//     _isAudio = json['isAudio'];
//     _hostIsMuted = json['hostIsMuted'];
//     if (json['seat'] != null) {
//       _seat = [];
//       json['seat'].forEach((v) {
//         _seat?.add(Seat.fromJson(v));
//       });
//     }
//     _name = json['name'];
//     _userName = json['userName'];
//     _image = json['image'];
//     _countryFlagImage = json['countryFlagImage'];
//     _country = json['country'];
//     _isVerified = json['isVerified'];
//     _host2Id = json['host2Id'];
//     _host2UniqueId = json['host2UniqueId'];
//     _host2Name = json['host2Name'];
//     _host2userName = json['host2userName'];
//     _host2Image = json['host2Image'];
//     _host2Channel = json['host2Channel'];
//     _host2LiveId = json['host2LiveId'];
//     _host2Token = json['host2Token'];
//     _host2IsFollow = json['host2IsFollow'];
//     _isFollow = json['isFollow'];
//     if (json['viewers'] != null) {
//       _viewers = [];
//       json['viewers'].forEach((v) {
//         _viewers?.add(Viewers.fromJson(v));
//       });
//     }
//   }
//   String? _id;
//   String? _userId;
//   String? _liveHistoryId;
//   int? _agoraUid;
//   String? _channel;
//   String? _token;
//   int? _view;
//   int? _liveType;
//   bool? _isPkMode;
//   int? _audioLiveType;
//   int? _privateCode;
//   String? _roomName;
//   String? _roomWelcome;
//   String? _roomImage;
//   bool? _isAudio;
//   int? _hostIsMuted;
//   List<Seat>? _seat;
//   String? _name;
//   String? _userName;
//   String? _image;
//   String? _countryFlagImage;
//   String? _country;
//   bool? _isVerified;
//   dynamic _host2Id;
//   dynamic _host2UniqueId;
//   String? _host2Name;
//   String? _host2userName;
//   String? _host2Image;
//   String? _host2Channel;
//   String? _host2LiveId;
//   String? _host2Token;
//   bool? _host2IsFollow;
//   bool? _isFollow;
//   List<Viewers>? _viewers;
//   LiveUserList copyWith({
//     String? id,
//     String? userId,
//     String? liveHistoryId,
//     int? agoraUid,
//     String? channel,
//     String? token,
//     int? view,
//     int? liveType,
//     bool? isPkMode,
//     int? audioLiveType,
//     int? privateCode,
//     String? roomName,
//     String? roomWelcome,
//     String? roomImage,
//     bool? isAudio,
//     int? hostIsMuted,
//     List<Seat>? seat,
//     String? name,
//     String? userName,
//     String? image,
//     String? countryFlagImage,
//     String? country,
//     bool? isVerified,
//     dynamic host2Id,
//     dynamic host2UniqueId,
//     String? host2Name,
//     String? host2userName,
//     String? host2Image,
//     String? host2Channel,
//     String? host2LiveId,
//     String? host2Token,
//     bool? host2IsFollow,
//     bool? isFollow,
//     List<Viewers>? viewers,
//   }) =>
//       LiveUserList(
//         id: id ?? _id,
//         userId: userId ?? _userId,
//         liveHistoryId: liveHistoryId ?? _liveHistoryId,
//         agoraUid: agoraUid ?? _agoraUid,
//         channel: channel ?? _channel,
//         token: token ?? _token,
//         view: view ?? _view,
//         liveType: liveType ?? _liveType,
//         isPkMode: isPkMode ?? _isPkMode,
//         audioLiveType: audioLiveType ?? _audioLiveType,
//         privateCode: privateCode ?? _privateCode,
//         roomName: roomName ?? _roomName,
//         roomWelcome: roomWelcome ?? _roomWelcome,
//         roomImage: roomImage ?? _roomImage,
//         isAudio: isAudio ?? _isAudio,
//         hostIsMuted: hostIsMuted ?? _hostIsMuted,
//         seat: seat ?? _seat,
//         name: name ?? _name,
//         userName: userName ?? _userName,
//         image: image ?? _image,
//         countryFlagImage: countryFlagImage ?? _countryFlagImage,
//         country: country ?? _country,
//         isVerified: isVerified ?? _isVerified,
//         host2Id: host2Id ?? _host2Id,
//         host2UniqueId: host2UniqueId ?? _host2UniqueId,
//         host2Name: host2Name ?? _host2Name,
//         host2userName: host2userName ?? _host2userName,
//         host2Image: host2Image ?? _host2Image,
//         host2Channel: host2Channel ?? _host2Channel,
//         host2LiveId: host2LiveId ?? _host2LiveId,
//         host2Token: host2Token ?? _host2Token,
//         host2IsFollow: host2IsFollow ?? _host2IsFollow,
//         isFollow: isFollow ?? _isFollow,
//         viewers: viewers ?? _viewers,
//       );
//   String? get id => _id;
//   String? get userId => _userId;
//   String? get liveHistoryId => _liveHistoryId;
//   int? get agoraUid => _agoraUid;
//   String? get channel => _channel;
//   String? get token => _token;
//   int? get view => _view;
//   int? get liveType => _liveType;
//   bool? get isPkMode => _isPkMode;
//   int? get audioLiveType => _audioLiveType;
//   int? get privateCode => _privateCode;
//   String? get roomName => _roomName;
//   String? get roomWelcome => _roomWelcome;
//   String? get roomImage => _roomImage;
//   bool? get isAudio => _isAudio;
//   int? get hostIsMuted => _hostIsMuted;
//   List<Seat>? get seat => _seat;
//   String? get name => _name;
//   String? get userName => _userName;
//   String? get image => _image;
//   String? get countryFlagImage => _countryFlagImage;
//   String? get country => _country;
//   bool? get isVerified => _isVerified;
//   dynamic get host2Id => _host2Id;
//   dynamic get host2UniqueId => _host2UniqueId;
//   String? get host2Name => _host2Name;
//   String? get host2userName => _host2userName;
//   String? get host2Image => _host2Image;
//   String? get host2Channel => _host2Channel;
//   String? get host2LiveId => _host2LiveId;
//   String? get host2Token => _host2Token;
//   bool? get host2IsFollow => _host2IsFollow;
//   bool? get isFollow => _isFollow;
//   List<Viewers>? get viewers => _viewers;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = _id;
//     map['userId'] = _userId;
//     map['liveHistoryId'] = _liveHistoryId;
//     map['agoraUid'] = _agoraUid;
//     map['channel'] = _channel;
//     map['token'] = _token;
//     map['view'] = _view;
//     map['liveType'] = _liveType;
//     map['isPkMode'] = _isPkMode;
//     map['audioLiveType'] = _audioLiveType;
//     map['privateCode'] = _privateCode;
//     map['roomName'] = _roomName;
//     map['roomWelcome'] = _roomWelcome;
//     map['roomImage'] = _roomImage;
//     map['isAudio'] = _isAudio;
//     map['hostIsMuted'] = _hostIsMuted;
//     if (_seat != null) {
//       map['seat'] = _seat?.map((v) => v.toJson()).toList();
//     }
//     map['name'] = _name;
//     map['userName'] = _userName;
//     map['image'] = _image;
//     map['countryFlagImage'] = _countryFlagImage;
//     map['country'] = _country;
//     map['isVerified'] = _isVerified;
//     map['host2Id'] = _host2Id;
//     map['host2UniqueId'] = _host2UniqueId;
//     map['host2Name'] = _host2Name;
//     map['host2userName'] = _host2userName;
//     map['host2Image'] = _host2Image;
//     map['host2Channel'] = _host2Channel;
//     map['host2LiveId'] = _host2LiveId;
//     map['host2Token'] = _host2Token;
//     map['host2IsFollow'] = _host2IsFollow;
//     map['isFollow'] = _isFollow;
//     if (_viewers != null) {
//       map['viewers'] = _viewers?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// class Viewers {
//   Viewers({
//     String? image,
//   }) {
//     _image = image;
//   }
//
//   Viewers.fromJson(dynamic json) {
//     _image = json['image'];
//   }
//   String? _image;
//   Viewers copyWith({
//     String? image,
//   }) =>
//       Viewers(
//         image: image ?? _image,
//       );
//   String? get image => _image;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['image'] = _image;
//     return map;
//   }
// }
//
// class Seat {
//   Seat({
//     String? id,
//     int? position,
//     bool? invite,
//     bool? reserved,
//     bool? speaking,
//     int? mute,
//     bool? lock,
//     int? agoraUid,
//     dynamic userId,
//     String? name,
//     String? userName,
//     String? image,
//     bool? isProfilePicBanned,
//     String? gender,
//     int? age,
//     String? countryFlagImage,
//     String? country,
//     String? uniqueId,
//     bool? isVerified,
//     int? coin,
//   }) {
//     _id = id;
//     _position = position;
//     _invite = invite;
//     _reserved = reserved;
//     _speaking = speaking;
//     _mute = mute;
//     _lock = lock;
//     _agoraUid = agoraUid;
//     _userId = userId;
//     _name = name;
//     _userName = userName;
//     _image = image;
//     _isProfilePicBanned = isProfilePicBanned;
//     _gender = gender;
//     _age = age;
//     _countryFlagImage = countryFlagImage;
//     _country = country;
//     _uniqueId = uniqueId;
//     _isVerified = isVerified;
//     _coin = coin;
//   }
//
//   Seat.fromJson(dynamic json) {
//     _id = json['_id'];
//     _position = json['position'];
//     _invite = json['invite'];
//     _reserved = json['reserved'];
//     _speaking = json['speaking'];
//     _mute = json['mute'];
//     _lock = json['lock'];
//     _agoraUid = json['agoraUid'];
//     _userId = json['userId'];
//     _name = json['name'];
//     _userName = json['userName'];
//     _image = json['image'];
//     _isProfilePicBanned = json['isProfilePicBanned'];
//     _gender = json['gender'];
//     _age = json['age'];
//     _countryFlagImage = json['countryFlagImage'];
//     _country = json['country'];
//     _uniqueId = json['uniqueId'];
//     _isVerified = json['isVerified'];
//     _coin = json['coin'];
//   }
//   String? _id;
//   int? _position;
//   bool? _invite;
//   bool? _reserved;
//   bool? _speaking;
//   int? _mute;
//   bool? _lock;
//   int? _agoraUid;
//   dynamic _userId;
//   String? _name;
//   String? _userName;
//   String? _image;
//   bool? _isProfilePicBanned;
//   String? _gender;
//   int? _age;
//   String? _countryFlagImage;
//   String? _country;
//   String? _uniqueId;
//   bool? _isVerified;
//   int? _coin;
//   Seat copyWith({
//     String? id,
//     int? position,
//     bool? invite,
//     bool? reserved,
//     bool? speaking,
//     int? mute,
//     bool? lock,
//     int? agoraUid,
//     dynamic userId,
//     String? name,
//     String? userName,
//     String? image,
//     bool? isProfilePicBanned,
//     String? gender,
//     int? age,
//     String? countryFlagImage,
//     String? country,
//     String? uniqueId,
//     bool? isVerified,
//     int? coin,
//   }) =>
//       Seat(
//         id: id ?? _id,
//         position: position ?? _position,
//         invite: invite ?? _invite,
//         reserved: reserved ?? _reserved,
//         speaking: speaking ?? _speaking,
//         mute: mute ?? _mute,
//         lock: lock ?? _lock,
//         agoraUid: agoraUid ?? _agoraUid,
//         userId: userId ?? _userId,
//         name: name ?? _name,
//         userName: userName ?? _userName,
//         image: image ?? _image,
//         isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
//         gender: gender ?? _gender,
//         age: age ?? _age,
//         countryFlagImage: countryFlagImage ?? _countryFlagImage,
//         country: country ?? _country,
//         uniqueId: uniqueId ?? _uniqueId,
//         isVerified: isVerified ?? _isVerified,
//         coin: coin ?? _coin,
//       );
//   String? get id => _id;
//   int? get position => _position;
//   bool? get invite => _invite;
//   bool? get reserved => _reserved;
//   bool? get speaking => _speaking;
//   int? get mute => _mute;
//   bool? get lock => _lock;
//   int? get agoraUid => _agoraUid;
//   dynamic get userId => _userId;
//   String? get name => _name;
//   String? get userName => _userName;
//   String? get image => _image;
//   bool? get isProfilePicBanned => _isProfilePicBanned;
//   String? get gender => _gender;
//   int? get age => _age;
//   String? get countryFlagImage => _countryFlagImage;
//   String? get country => _country;
//   String? get uniqueId => _uniqueId;
//   bool? get isVerified => _isVerified;
//   int? get coin => _coin;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = _id;
//     map['position'] = _position;
//     map['invite'] = _invite;
//     map['reserved'] = _reserved;
//     map['speaking'] = _speaking;
//     map['mute'] = _mute;
//     map['lock'] = _lock;
//     map['agoraUid'] = _agoraUid;
//     map['userId'] = _userId;
//     map['name'] = _name;
//     map['userName'] = _userName;
//     map['image'] = _image;
//     map['isProfilePicBanned'] = _isProfilePicBanned;
//     map['gender'] = _gender;
//     map['age'] = _age;
//     map['countryFlagImage'] = _countryFlagImage;
//     map['country'] = _country;
//     map['uniqueId'] = _uniqueId;
//     map['isVerified'] = _isVerified;
//     map['coin'] = _coin;
//     return map;
//   }
// }
