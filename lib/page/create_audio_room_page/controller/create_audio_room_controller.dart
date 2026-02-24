import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/custom/function/custom_image_picker.dart';
import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';

import 'package:tingle/page/audio_room_page/model/audio_room_model.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class CreateAudioRoomController extends GetxController {
  String channelId = "";
  int agoraId = 0;

  String? pickImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isPrivate = false;
  int privateCode = 0;

  @override
  void onInit() {
    channelId = onGenerateRandomNumber();
    agoraId = 100000 + Random().nextInt(900000);
    privateCode = 1000 + Random().nextInt(9000);

    Utils.showLog("Generate AgoraUid => $agoraId **** ChannelId => $channelId");

    super.onInit();
  }

  @override
  void onClose() {
    Utils.showLog("Dispose Create Audio Room Success");
    super.onClose();
  }

  Future<void> onClickGoLive() async {
    onAudioLive();
  }

  void onChangeRoomType(bool value) {
    isPrivate = value;
    update([AppConstant.onChangeRoomType]);
  }

  Future<void> onPickImage(BuildContext context) async {
    await CustomImagePickerBottomSheetWidget.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

        if (imagePath != null) {
          pickImage = imagePath;
          update([AppConstant.onPickImage]);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);
        if (imagePath != null) {
          pickImage = imagePath;
          update([AppConstant.onPickImage]);
        }
      },
    );
  }

  Future<void> onAudioLive() async {
    if (pickImage == null) {
      Utils.showToast(text: "Please select room image");
    } else if (nameController.text.trim().isEmpty) {
      Utils.showToast(text: "Please enter room name");
    } else {
      Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingWidget())); // Start Loading...

      // createLiveUserModel = await CreateAudioRoomApi.callApi(
      //   token: token,
      //   uid: uid,
      //   channel: channelId,
      //   liveType: 2, // Audio Live
      //   agoraUID: agoraId,
      //   audioLiveType: isPrivate ? 1 : 2,
      //   privateCode: isPrivate ? privateCode : 0,
      //   roomName: nameController.text.trim(),
      //   roomWelcome: descriptionController.text.trim(),
      //   roomImage: pickImage ?? "",
      //   bgTheme: Database.fetchLoginUserProfile()?.user?.activeTheme?.image ?? "",
      // );

      Get.back(); // Stop Loading...

      Get.offAndToNamed(
        AppRoutes.audioRoomPage,
        arguments: AudioRoomModel(
          isHost: true,
          hostUserId: "user_12345",
          hostUid: 56789,
          hostIsMuted: false,
          liveHistoryId: "live_history_98765",
          liveUserObjId: "live_user_obj_123",
          roomName: "Chill Vibes Room 🎶",
          roomImage: "https://picsum.photos/400/400?random=1",
          roomWelcome: "Welcome to the best chill zone!",
          token: "dummy_agora_token_abc123",
          channel: "chill_vibes_channel",
          userUid: 0,
          mute: 0,
          audioLiveType: 1, // 1 = public, 2 = private (example)
          audioRoomPrivateCode: 123456, // if private room
          audioRoomSeats: List.generate(8, (index) {
            bool isOccupied = index < 3; // Let's say first 3 seats are occupied

            return Seat()
              ..id = "seat_${index + 1}"
              ..position = index
              ..mute = isOccupied ? 0 : null
              ..lock = false
              ..reserved = false
              ..speaking = isOccupied ? (index == 0) : false
              ..invite = false
              ..isProfilePicBanned = false
              ..userId = isOccupied ? "user_${1000 + index}" : null
              ..name = isOccupied ? "User ${index + 1}" : null
              ..image = isOccupied ? "https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index + 10}.jpg" : null
              ..avtarFrame = isOccupied ? "frame_${index + 1}.png" : null
              ..agoraUid = isOccupied ? (5000 + index) : null
              ..coin = isOccupied ? (randomCoin()) : null
              ..avtarFrameType = isOccupied ? (index % 3) : null;
          }),
          isFollow: false,
          bgTheme: "default_theme_background.jpg",
          hostUniqueId: "host_unique_id_123",
          seatLength: 8,
        ),
      );
    }
  }

  int randomCoin() {
    final random = Random();
    return 100 + random.nextInt(5000); // 100 to 5000 coins
  }

  String onGenerateRandomNumber() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return List.generate(
      25,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}
