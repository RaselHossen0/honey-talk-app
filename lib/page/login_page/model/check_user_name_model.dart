class CheckUserNameModel {
  bool? status;
  bool? available;
  String? message;

  CheckUserNameModel({this.status, this.available, this.message});

  CheckUserNameModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    available = json['available'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['available'] = available;
    data['message'] = message;
    return data;
  }
}
