import 'package:get/get.dart';

enum LivePictureStatus { approved, rejected, pending }

class LivePictureModel {
  LivePictureModel({
    required this.imageUrl,
    required this.status,
  });

  final String imageUrl;
  final LivePictureStatus status;
}

class MyLivePicturesController extends GetxController {
  late String mainImageUrl;
  late List<LivePictureModel> thumbnails;

  @override
  void onInit() {
    super.onInit();
    _loadPictures();
  }

  void _loadPictures() {
    mainImageUrl = 'https://picsum.photos/400/300';
    thumbnails = [
      LivePictureModel(imageUrl: 'https://picsum.photos/100/100?random=1', status: LivePictureStatus.approved),
      LivePictureModel(imageUrl: 'https://picsum.photos/100/100?random=2', status: LivePictureStatus.rejected),
      LivePictureModel(imageUrl: 'https://picsum.photos/100/100?random=3', status: LivePictureStatus.approved),
      LivePictureModel(imageUrl: 'https://picsum.photos/100/100?random=4', status: LivePictureStatus.pending),
      LivePictureModel(imageUrl: 'https://picsum.photos/100/100?random=5', status: LivePictureStatus.approved),
      LivePictureModel(imageUrl: 'https://picsum.photos/100/100?random=6', status: LivePictureStatus.pending),
    ];
  }

  void onUpload() {
    // TODO: Implement image picker and upload
  }

  void onLive() {
    Get.back();
    // TODO: Navigate to go live
  }
}
