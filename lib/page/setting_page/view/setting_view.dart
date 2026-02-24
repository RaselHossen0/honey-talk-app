import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/log_out_dialog_widget.dart';
import 'package:tingle/page/setting_page/controller/setting_controller.dart';
import 'package:tingle/page/setting_page/widget/setting_app_bar_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: SettingAppBarWidget.onShow(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            _ItemWidget(
              name: "Languages",
              isShowRightArrow: true,
              callback: () {},
            ),
            _DividerWidget(),
            _ItemWidget(
              name: "Privacy Policy",
              isShowRightArrow: true,
              callback: () {},
            ),
            _DividerWidget(),
            _ItemWidget(
              name: "Terms Of Use",
              isShowRightArrow: true,
              callback: () {},
            ),
            15.height,
            _ItemWidget(
              name: "Log Out",
              isShowRightArrow: false,
              style: AppFontStyle.styleW600(AppColor.red, 14),
              callback: () => LogOutDialogWidget.onShow(),
            ),
            _DividerWidget(),
            _ItemWidget(
              name: "Delete Account",
              isShowRightArrow: false,
              style: AppFontStyle.styleW600(AppColor.red, 14),
              callback: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({required this.name, required this.isShowRightArrow, this.style, required this.callback});

  final String name;
  final bool isShowRightArrow;
  final TextStyle? style;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 60,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(color: AppColor.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: style ?? AppFontStyle.styleW500(AppColor.black, 14),
            ),
            Visibility(
              visible: isShowRightArrow,
              child: Image.asset(
                AppAssets.icArrowRight,
                width: 8,
                color: AppColor.secondary.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 2,
        color: AppColor.backgroundColor,
      ),
    );
  }
}
