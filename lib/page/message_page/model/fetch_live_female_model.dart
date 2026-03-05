/// Model for female users currently live. API-ready for future integration.
class FetchLiveFemaleModel {
  FetchLiveFemaleModel({
    bool? status,
    String? message,
    List<LiveFemaleData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchLiveFemaleModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LiveFemaleData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<LiveFemaleData>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<LiveFemaleData>? get data => _data;
}

class LiveFemaleData {
  LiveFemaleData({
    String? id,
    String? userId,
    String? name,
    String? image,
    bool? isProfilePicBanned,
  }) {
    _id = id;
    _userId = userId;
    _name = name;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
  }

  LiveFemaleData.fromJson(dynamic json) {
    _id = json['_id'] ?? json['id'];
    _userId = json['userId'];
    _name = json['name'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'] ?? json['is_profile_pic_banned'];
  }

  String? _id;
  String? _userId;
  String? _name;
  String? _image;
  bool? _isProfilePicBanned;

  String? get id => _id;
  String? get userId => _userId;
  String? get name => _name;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
}
