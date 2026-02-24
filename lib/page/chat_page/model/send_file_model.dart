class SendFileModel {
  bool? status;
  String? message;
  SendFileData? chat;

  SendFileModel({this.status, this.message, this.chat});

  SendFileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    chat = json['chat'] != null ? SendFileData.fromJson(json['chat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (chat != null) {
      data['chat'] = chat!.toJson();
    }
    return data;
  }
}

class SendFileData {
  String? chatRequestTopicId;
  String? message;
  String? audio;
  String? image;
  bool? isChatMediaBanned;
  bool? isRead;
  String? date;
  String? id;
  String? senderUserId;
  int? messageType;
  String? createdAt;
  String? updatedAt;

  SendFileData(
      {this.chatRequestTopicId,
      this.message,
      this.audio,
      this.image,
      this.isChatMediaBanned,
      this.isRead,
      this.date,
      this.id,
      this.senderUserId,
      this.messageType,
      this.createdAt,
      this.updatedAt});

  SendFileData.fromJson(Map<String, dynamic> json) {
    chatRequestTopicId = json['chatRequestTopicId'];
    message = json['message'];
    audio = json['audio'];
    image = json['image'];
    isChatMediaBanned = json['isChatMediaBanned'];
    isRead = json['isRead'];
    date = json['date'];
    id = json['_id'];
    senderUserId = json['senderUserId'];
    messageType = json['messageType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatRequestTopicId'] = chatRequestTopicId;
    data['message'] = message;
    data['audio'] = audio;
    data['image'] = image;
    data['isChatMediaBanned'] = isChatMediaBanned;
    data['isRead'] = isRead;
    data['date'] = date;
    data['_id'] = id;
    data['senderUserId'] = senderUserId;
    data['messageType'] = messageType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
