class FetchAudioWiseVideosModel {
  bool? status;
  String? message;
  int? totalVideosOfSong;
  List<Videos>? videos;

  FetchAudioWiseVideosModel({this.status, this.message, this.totalVideosOfSong, this.videos});

  FetchAudioWiseVideosModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalVideosOfSong = json['totalVideosOfSong'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['totalVideosOfSong'] = totalVideosOfSong;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  String? id;
  String? caption;
  String? videoUrl;
  String? videoImage;
  String? songId;
  bool? isBanned;
  String? createdAt;
  int? totalLikes;
  bool? isLike;
  int? totalComments;
  int? totalViews;
  String? songTitle;
  String? songImage;
  String? songLink;
  String? singerName;
  List<String>? hashTag;
  String? userId;
  bool? isProfileImageBanned;
  String? name;
  String? userName;
  String? userImage;
  bool? userIsFake;

  Videos(
      {this.id,
      this.caption,
      this.videoUrl,
      this.videoImage,
      this.songId,
      this.isBanned,
      this.createdAt,
      this.totalLikes,
      this.isLike,
      this.totalComments,
      this.totalViews,
      this.songTitle,
      this.songImage,
      this.songLink,
      this.singerName,
      this.hashTag,
      this.userId,
      this.isProfileImageBanned,
      this.name,
      this.userName,
      this.userImage,
      this.userIsFake});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    caption = json['caption'];
    videoUrl = json['videoUrl'];
    videoImage = json['videoImage'];
    songId = json['songId'];
    isBanned = json['isBanned'];
    createdAt = json['createdAt'];
    totalLikes = json['totalLikes'];
    isLike = json['isLike'];
    totalComments = json['totalComments'];
    totalViews = json['totalViews'];
    songTitle = json['songTitle'];
    songImage = json['songImage'];
    songLink = json['songLink'];
    singerName = json['singerName'];
    hashTag = json['hashTag'].cast<String>();
    userId = json['userId'];
    isProfileImageBanned = json['isProfileImageBanned'];
    name = json['name'];
    userName = json['userName'];
    userImage = json['userImage'];
    userIsFake = json['userIsFake'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['caption'] = caption;
    data['videoUrl'] = videoUrl;
    data['videoImage'] = videoImage;
    data['songId'] = songId;
    data['isBanned'] = isBanned;
    data['createdAt'] = createdAt;
    data['totalLikes'] = totalLikes;
    data['isLike'] = isLike;
    data['totalComments'] = totalComments;
    data['totalViews'] = totalViews;
    data['songTitle'] = songTitle;
    data['songImage'] = songImage;
    data['songLink'] = songLink;
    data['singerName'] = singerName;
    data['hashTag'] = hashTag;
    data['userId'] = userId;
    data['isProfileImageBanned'] = isProfileImageBanned;
    data['name'] = name;
    data['userName'] = userName;
    data['userImage'] = userImage;
    data['userIsFake'] = userIsFake;
    return data;
  }
}
