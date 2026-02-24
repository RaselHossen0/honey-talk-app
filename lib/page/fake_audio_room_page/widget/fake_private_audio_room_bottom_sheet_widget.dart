import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakePrivateAudioRoomBottomSheetWidget {
  static TextEditingController passwordController = TextEditingController();

  static Future<void> show({required int password, required Callback callBack}) async {
    passwordController.clear();
    await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 50,
              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            ),
            child: Container(
              height: 270,
              width: Get.width,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 65,
                    color: AppColor.secondary.withValues(alpha: 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        50.width,
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 4,
                              width: 35,
                              decoration: BoxDecoration(
                                color: AppColor.grayText.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            10.height,
                            Text(
                              "Private Room",
                              style: AppFontStyle.styleW700(AppColor.black, 17),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.only(right: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.secondary.withValues(alpha: 0.6),
                            ),
                            child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            25.height,
                            Row(
                              children: [
                                Text(
                                  "Password ",
                                  style: AppFontStyle.styleW700(AppColor.black, 15),
                                ),
                                5.width,
                                Text(
                                  "(4 digits)",
                                  style: AppFontStyle.styleW400(AppColor.grayText, 15),
                                ),
                              ],
                            ),
                            8.height,
                            GestureDetector(
                              child: TextFieldUi(controller: passwordController),
                            ),
                            25.height,
                            GestureDetector(
                              onTap: () {
                                if (passwordController.text.trim().isEmpty) {
                                  Utils.showToast(text: "Please enter password");
                                } else if (password != int.parse(passwordController.text.trim())) {
                                  Utils.showToast(text: "Please enter current password");
                                } else {
                                  Get.back();
                                  callBack.call();
                                }
                              },
                              child: Container(
                                height: 55,
                                width: Get.width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  gradient: AppColor.primaryGradient,
                                ),
                                child: Text(
                                  "Submit",
                                  style: AppFontStyle.styleW700(AppColor.white, 17),
                                ),
                              ),
                            ),
                            15.height,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldUi extends StatelessWidget {
  const TextFieldUi({super.key, this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 20, right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        style: AppFontStyle.styleW700(AppColor.black, 15),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        cursorColor: AppColor.grayText,
        maxLines: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 3),
          hintText: "Enter room password..",
          hintStyle: AppFontStyle.styleW500(AppColor.secondary, 15),
        ),
      ),
    );
  }
}
