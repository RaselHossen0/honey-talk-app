import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/custom/function/custom_image_picker.dart';
import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';
import 'package:tingle/page/help_page/api/help_api.dart';
import 'package:tingle/page/help_page/model/help_model.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class HelpController extends GetxController {
  TextEditingController complaintController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  HelpModel? helpModel;

  String? pickImage;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    complaintController.clear();
    contactController.clear();
    onCancelImage();
  }

  Future<void> onSendComplaint() async {
    if (complaintController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterYourComplain.name.tr);
    } else if (contactController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterYourContactNumber.name.tr);
    } else {
      Utils.showLog("Complain Sending....");

      FocusManager.instance.primaryFocus?.unfocus();

      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

      helpModel = await HelpApi.callApi(
        complaint: complaintController.text,
        contact: contactController.text,
        image: pickImage,
      );

      if (helpModel?.status ?? false) {
        Utils.showToast(text: EnumLocal.txtYourComplainSendSuccessfully.name.tr);
        Get.back();
      } else {
        Utils.showToast(text: helpModel?.message ?? "");
      }
      Get.back(); // Stop Loading...
    }
  }

  Future<void> onPickImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

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

  Future<void> onCancelImage() async {
    pickImage = null;
    update([AppConstant.onPickImage]);
  }
}
