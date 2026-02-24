class ReactionModel {
  int position;
  String image;
  String senderName;
  String senderImage;
  bool senderProfilePicBanned;
  int time;

  ReactionModel({
    required this.position,
    required this.image,
    required this.senderName,
    required this.senderImage,
    required this.senderProfilePicBanned,
    required this.time,
  });
}
