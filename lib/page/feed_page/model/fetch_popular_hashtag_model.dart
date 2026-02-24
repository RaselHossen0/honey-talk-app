import 'dart:convert';
FetchPopularHashtagModel fetchPopularHashtagModelFromJson(String str) => FetchPopularHashtagModel.fromJson(json.decode(str));
String fetchPopularHashtagModelToJson(FetchPopularHashtagModel data) => json.encode(data.toJson());
class FetchPopularHashtagModel {
  FetchPopularHashtagModel({
      bool? success, 
      String? message, 
      List<Hashtags>? hashtags,}){
    _success = success;
    _message = message;
    _hashtags = hashtags;
}

  FetchPopularHashtagModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['hashtags'] != null) {
      _hashtags = [];
      json['hashtags'].forEach((v) {
        _hashtags?.add(Hashtags.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Hashtags>? _hashtags;
FetchPopularHashtagModel copyWith({  bool? success,
  String? message,
  List<Hashtags>? hashtags,
}) => FetchPopularHashtagModel(  success: success ?? _success,
  message: message ?? _message,
  hashtags: hashtags ?? _hashtags,
);
  bool? get success => _success;
  String? get message => _message;
  List<Hashtags>? get hashtags => _hashtags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_hashtags != null) {
      map['hashtags'] = _hashtags?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Hashtags hashtagsFromJson(String str) => Hashtags.fromJson(json.decode(str));
String hashtagsToJson(Hashtags data) => json.encode(data.toJson());
class Hashtags {
  Hashtags({
      String? id, 
      String? hashTag, 
      num? usageCount,}){
    _id = id;
    _hashTag = hashTag;
    _usageCount = usageCount;
}

  Hashtags.fromJson(dynamic json) {
    _id = json['_id'];
    _hashTag = json['hashTag'];
    _usageCount = json['usageCount'];
  }
  String? _id;
  String? _hashTag;
  num? _usageCount;
Hashtags copyWith({  String? id,
  String? hashTag,
  num? usageCount,
}) => Hashtags(  id: id ?? _id,
  hashTag: hashTag ?? _hashTag,
  usageCount: usageCount ?? _usageCount,
);
  String? get id => _id;
  String? get hashTag => _hashTag;
  num? get usageCount => _usageCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['hashTag'] = _hashTag;
    map['usageCount'] = _usageCount;
    return map;
  }

}