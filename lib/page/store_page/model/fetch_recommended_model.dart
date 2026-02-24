class FetchRecommendedModel {
  FetchRecommendedModel({
    bool? status,
    String? message,
    List<TopFrames>? topFrames,
    List<Recommended>? recommended,
  }) {
    _status = status;
    _message = message;
    _topFrames = topFrames;
    _recommended = recommended;
  }

  FetchRecommendedModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['topFrames'] != null) {
      _topFrames = [];
      json['topFrames'].forEach((v) {
        _topFrames?.add(TopFrames.fromJson(v));
      });
    }
    if (json['recommended'] != null) {
      _recommended = [];
      json['recommended'].forEach((v) {
        _recommended?.add(Recommended.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<TopFrames>? _topFrames;
  List<Recommended>? _recommended;
  FetchRecommendedModel copyWith({
    bool? status,
    String? message,
    List<TopFrames>? topFrames,
    List<Recommended>? recommended,
  }) =>
      FetchRecommendedModel(
        status: status ?? _status,
        message: message ?? _message,
        topFrames: topFrames ?? _topFrames,
        recommended: recommended ?? _recommended,
      );
  bool? get status => _status;
  String? get message => _message;
  List<TopFrames>? get topFrames => _topFrames;
  List<Recommended>? get recommended => _recommended;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_topFrames != null) {
      map['topFrames'] = _topFrames?.map((v) => v.toJson()).toList();
    }
    if (_recommended != null) {
      map['recommended'] = _recommended?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Recommended {
  Recommended({
    String? id,
    String? name,
    String? image,
    int? coin,
    int? validity,
    int? validityType,
    bool? isPurchased,
    String? itemType,
    String? svgaImage,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _coin = coin;
    _validity = validity;
    _validityType = validityType;
    _isPurchased = isPurchased;
    _itemType = itemType;
    _svgaImage = svgaImage;
  }

  Recommended.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
    _coin = json['coin'];
    _validity = json['validity'];
    _validityType = json['validityType'];
    _isPurchased = json['isPurchased'];
    _itemType = json['itemType'];
    _svgaImage = json['svgaImage'];
  }
  String? _id;
  String? _name;
  String? _image;
  int? _coin;
  int? _validity;
  int? _validityType;
  bool? _isPurchased;
  String? _itemType;
  String? _svgaImage;
  Recommended copyWith({
    String? id,
    String? name,
    String? image,
    int? coin,
    int? validity,
    int? validityType,
    bool? isPurchased,
    String? itemType,
    String? svgaImage,
  }) =>
      Recommended(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        coin: coin ?? _coin,
        validity: validity ?? _validity,
        validityType: validityType ?? _validityType,
        isPurchased: isPurchased ?? _isPurchased,
        itemType: itemType ?? _itemType,
        svgaImage: svgaImage ?? _svgaImage,
      );
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  int? get coin => _coin;
  int? get validity => _validity;
  int? get validityType => _validityType;
  bool? get isPurchased => _isPurchased;
  String? get itemType => _itemType;
  String? get svgaImage => _svgaImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['coin'] = _coin;
    map['validity'] = _validity;
    map['validityType'] = _validityType;
    map['isPurchased'] = _isPurchased;
    map['itemType'] = _itemType;
    map['svgaImage'] = _svgaImage;
    return map;
  }
}

class TopFrames {
  TopFrames({
    String? id,
    String? name,
    int? type,
    String? image,
    String? svgaImage,
    int? coin,
    int? validity,
    int? validityType,
    bool? isPurchased,
  }) {
    _id = id;
    _name = name;
    _type = type;
    _image = image;
    _svgaImage = svgaImage;
    _coin = coin;
    _validity = validity;
    _validityType = validityType;
    _isPurchased = isPurchased;
  }

  TopFrames.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _type = json['type'];
    _image = json['image'];
    _svgaImage = json['svgaImage'];
    _coin = json['coin'];
    _validity = json['validity'];
    _validityType = json['validityType'];
    _isPurchased = json['isPurchased'];
  }
  String? _id;
  String? _name;
  int? _type;
  String? _image;
  String? _svgaImage;
  int? _coin;
  int? _validity;
  int? _validityType;
  bool? _isPurchased;
  TopFrames copyWith({
    String? id,
    String? name,
    int? type,
    String? image,
    String? svgaImage,
    int? coin,
    int? validity,
    int? validityType,
    bool? isPurchased,
  }) =>
      TopFrames(
        id: id ?? _id,
        name: name ?? _name,
        type: type ?? _type,
        image: image ?? _image,
        svgaImage: svgaImage ?? _svgaImage,
        coin: coin ?? _coin,
        validity: validity ?? _validity,
        validityType: validityType ?? _validityType,
        isPurchased: isPurchased ?? _isPurchased,
      );
  String? get id => _id;
  String? get name => _name;
  int? get type => _type;
  String? get image => _image;
  String? get svgaImage => _svgaImage;
  int? get coin => _coin;
  int? get validity => _validity;
  int? get validityType => _validityType;
  bool? get isPurchased => _isPurchased;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['type'] = _type;
    map['image'] = _image;
    map['svgaImage'] = _svgaImage;
    map['coin'] = _coin;
    map['validity'] = _validity;
    map['validityType'] = _validityType;
    map['isPurchased'] = _isPurchased;
    return map;
  }
}
