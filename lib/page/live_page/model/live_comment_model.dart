class LiveCommentModel {
  int type;
  String name;
  String image;
  String commentText;
  bool isBanned;
  String? emoji;

  LiveCommentModel({
    required this.type,
    required this.name,
    required this.image,
    required this.commentText,
    required this.isBanned,
    this.emoji,
  });
}
