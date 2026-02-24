class LiveViewerUserModel {
  final String? id;
  final String? name;
  final String? userName;
  final String? image;
  final bool? isProfilePicBanned;
  bool? isFollow;
  final String? avatarFrame;
  final int? avtarFrameType;
  final String? userId;

  LiveViewerUserModel({
    this.id,
    this.name,
    this.userName,
    this.image,
    this.isProfilePicBanned,
    this.isFollow,
    this.avatarFrame,
    this.avtarFrameType,
    this.userId,
  });

  factory LiveViewerUserModel.fromJson(Map<String, dynamic> json) {
    return LiveViewerUserModel(
      id: json['_id']?.toString(),
      name: json['name']?.toString(),
      userName: json['userName']?.toString(),
      image: json['image']?.toString(),
      isProfilePicBanned: json['isProfilePicBanned'] as bool?,
      isFollow: json['isFollow'] as bool?,
      avatarFrame: json['avtarFrame']?.toString(),
      avtarFrameType: json['avtarFrameType'],
      userId: json['userId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'userName': userName,
      'image': image,
      'isProfilePicBanned': isProfilePicBanned,
      'isFollow': isFollow,
      'avtarFrame': avatarFrame,
      'avtarFrameType': avtarFrameType,
      'userId': userId,
    };
  }
}
