class FetchSongModel {
  FetchSongModel({
    bool? status,
    String? message,
    List<SongData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchSongModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SongData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<SongData>? _data;
  FetchSongModel copyWith({
    bool? status,
    String? message,
    List<SongData>? data,
  }) =>
      FetchSongModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<SongData>? get data => _data;

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

class SongData {
  SongData({
    String? id,
    String? songTitle,
    String? songImage,
    String? singerName,
    String? songLink,
    double? songTime,
    String? createdAt,
    String? songCategoryName,
    String? songCategoryImage,
    bool? isFavorite,
  }) {
    _id = id;
    _songTitle = songTitle;
    _songImage = songImage;
    _singerName = singerName;
    _songLink = songLink;
    _songTime = songTime;
    _createdAt = createdAt;
    _songCategoryName = songCategoryName;
    _songCategoryImage = songCategoryImage;
    _isFavorite = isFavorite;
  }

  SongData.fromJson(dynamic json) {
    _id = json['_id'];
    _songTitle = json['songTitle'];
    _songImage = json['songImage'];
    _singerName = json['singerName'];
    _songLink = json['songLink'];
    _songTime = json['songTime'];
    _createdAt = json['createdAt'];
    _songCategoryName = json['songCategoryName'];
    _songCategoryImage = json['songCategoryImage'];
    _isFavorite = json['isFavorite'];
  }
  String? _id;
  String? _songTitle;
  String? _songImage;
  String? _singerName;
  String? _songLink;
  double? _songTime;
  String? _createdAt;
  String? _songCategoryName;
  String? _songCategoryImage;
  bool? _isFavorite;
  SongData copyWith({
    String? id,
    String? songTitle,
    String? songImage,
    String? singerName,
    String? songLink,
    double? songTime,
    String? createdAt,
    String? songCategoryName,
    String? songCategoryImage,
    bool? isFavorite,
  }) =>
      SongData(
        id: id ?? _id,
        songTitle: songTitle ?? _songTitle,
        songImage: songImage ?? _songImage,
        singerName: singerName ?? _singerName,
        songLink: songLink ?? _songLink,
        songTime: songTime ?? _songTime,
        createdAt: createdAt ?? _createdAt,
        songCategoryName: songCategoryName ?? _songCategoryName,
        songCategoryImage: songCategoryImage ?? _songCategoryImage,
        isFavorite: isFavorite ?? _isFavorite,
      );
  String? get id => _id;
  String? get songTitle => _songTitle;
  String? get songImage => _songImage;
  String? get singerName => _singerName;
  String? get songLink => _songLink;
  double? get songTime => _songTime;
  String? get createdAt => _createdAt;
  String? get songCategoryName => _songCategoryName;
  String? get songCategoryImage => _songCategoryImage;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['songTitle'] = _songTitle;
    map['songImage'] = _songImage;
    map['singerName'] = _singerName;
    map['songLink'] = _songLink;
    map['songTime'] = _songTime;
    map['createdAt'] = _createdAt;
    map['songCategoryName'] = _songCategoryName;
    map['songCategoryImage'] = _songCategoryImage;
    map['isFavorite'] = _isFavorite;
    return map;
  }
}
