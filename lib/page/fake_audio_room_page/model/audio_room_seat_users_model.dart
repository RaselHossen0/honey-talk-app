class AudioRoomSeatUsersModel {
  final String? id;
  final SeatUser? seat;

  AudioRoomSeatUsersModel({
    this.id,
    this.seat,
  });

  factory AudioRoomSeatUsersModel.fromJson(Map<String, dynamic> json) {
    return AudioRoomSeatUsersModel(
      id: json['_id'] as String?,
      seat: json['seat'] != null ? SeatUser.fromJson(json['seat']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'seat': seat?.toJson(),
    };
  }

  @override
  String toString() {
    return 'AudioRoomSeatUsersModel{id: $id, seat: $seat}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is AudioRoomSeatUsersModel && runtimeType == other.runtimeType && id == other.id && seat == other.seat;

  @override
  int get hashCode => id.hashCode ^ seat.hashCode;
}

class SeatUser {
  final String? userId;
  final String? name;
  final String? userName;
  final String? image;
  final bool? isProfilePicBanned;
  final bool? isVerified;

  SeatUser({
    this.userId,
    this.name,
    this.userName,
    this.image,
    this.isProfilePicBanned,
    this.isVerified,
  });

  factory SeatUser.fromJson(Map<String, dynamic> json) {
    return SeatUser(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      image: json['image'] as String?,
      isProfilePicBanned: json['isProfilePicBanned'] as bool?,
      isVerified: json['isVerified'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'userName': userName,
      'image': image,
      'isProfilePicBanned': isProfilePicBanned,
      'isVerified': isVerified,
    };
  }

  @override
  String toString() {
    return 'SeatUser{userId: $userId, name: $name, userName: $userName, image: $image, isProfilePicBanned: $isProfilePicBanned, isVerified: $isVerified}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatUser &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          userName == other.userName &&
          image == other.image &&
          isProfilePicBanned == other.isProfilePicBanned &&
          isVerified == other.isVerified;

  @override
  int get hashCode => userId.hashCode ^ name.hashCode ^ userName.hashCode ^ image.hashCode ^ isProfilePicBanned.hashCode ^ isVerified.hashCode;
}
