import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/wealth_level_page/controller/wealth_level_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class WealthLevelView extends GetView<WealthLevelController> {
  const WealthLevelView({super.key});

  static const _gradient = LinearGradient(
    colors: [Color(0xFFF6740A), Color(0xFFFF6B6B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<WealthLevelController>(
        id: AppConstant.onGetFeed,
        builder: (ctrl) => ctrl.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColor.primary))
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context, ctrl)),
                  SliverToBoxAdapter(child: _buildLevelSection(ctrl)),
                  SliverToBoxAdapter(child: _buildLvRewardSection(ctrl)),
                  SliverToBoxAdapter(child: _buildLevelRulesSection(ctrl)),
                ],
              ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WealthLevelController ctrl) {
    return Container(
      decoration: const BoxDecoration(gradient: _gradient),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top + 12,
        left: 15,
        right: 15,
        bottom: 12,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.arrow_back_ios, color: AppColor.white, size: 20),
            ),
          ),
          Expanded(
            child: Text(
              EnumLocal.txtWealthLevel.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.styleW700(AppColor.white, 18),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildLevelSection(WealthLevelController ctrl) {
    return Container(
      decoration: const BoxDecoration(gradient: _gradient),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColor.lightYellow.withValues(alpha: 0.95),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.workspace_premium, color: AppColor.darkYellow, size: 48),
                Positioned(
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Lv.${ctrl.currentLevel}",
                      style: AppFontStyle.styleW700(AppColor.orange, 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.height,
          Row(
            children: [
              Text("Lv.${ctrl.currentLevel}", style: AppFontStyle.styleW600(AppColor.white, 12)),
              8.width,
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: ctrl.progress,
                        minHeight: 24,
                        backgroundColor: AppColor.white.withValues(alpha: 0.4),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColor.white),
                      ),
                    ),
                    Text(
                      "${CustomFormatNumber.onConvert(ctrl.currentToken)}Token",
                      style: AppFontStyle.styleW600(AppColor.white, 11),
                    ),
                  ],
                ),
              ),
              8.width,
              Text("Lv.${ctrl.nextLevel}", style: AppFontStyle.styleW600(AppColor.white, 12)),
            ],
          ),
          8.height,
          Text(
            "Recharge ${CustomFormatNumber.onConvert(ctrl.tokenToNextLevel)} Token to Level up",
            style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.95), 13),
          ),
        ],
      ),
    );
  }

  Widget _buildLvRewardSection(WealthLevelController ctrl) {
    final tabs = [
      "Name",
      EnumLocal.txtGiftTab.name.tr,
      EnumLocal.txtRoomsPrivilege.name.tr,
      EnumLocal.txtAvatarsFrame.name.tr,
      EnumLocal.txtCarTab.name.tr,
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocal.txtLvReward.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
          12.height,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabs.asMap().entries.map((e) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: e.key == 0 ? AppColor.primary.withValues(alpha: 0.15) : AppColor.lightGrayBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    e.value,
                    style: AppFontStyle.styleW500(
                      e.key == 0 ? AppColor.primary : AppColor.darkGrey,
                      13,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ctrl.rewardTiers.asMap().entries.map((e) {
              final colors = [AppColor.orange, AppColor.pink, AppColor.primary];
              final c = colors[e.key % colors.length];
              return Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.workspace_premium, color: c, size: 22),
                        2.height,
                        Text(
                          "${e.value.count}",
                          style: AppFontStyle.styleW700(c, 14),
                        ),
                      ],
                    ),
                  ),
                  8.height,
                  Text(
                    e.value.levelRange ?? "",
                    style: AppFontStyle.styleW500(AppColor.darkGrey, 12),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelRulesSection(WealthLevelController ctrl) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocal.txtLevelRules.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
          8.height,
          Text(
            EnumLocal.txtLvWillBeZero.name.tr,
            style: AppFontStyle.styleW400(AppColor.darkGray, 12),
          ),
          16.height,
          Container(
            decoration: BoxDecoration(
              color: AppColor.lightGrayBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _levelRuleHeader(),
                ...ctrl.levelRules.map((r) => _levelRuleRow(
                  r.level == 0 ? "-" : "W${r.level}",
                  CustomFormatNumber.onConvert(r.rechargeToken ?? 0),
                )),
              ],
            ),
          ),
          16.height,
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.rechargeCoinPage),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: _gradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  EnumLocal.txtRecharge.name.tr,
                  style: AppFontStyle.styleW700(AppColor.white, 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _levelRuleHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.colorBorder,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(EnumLocal.txtLevel.name.tr, style: AppFontStyle.styleW600(AppColor.darkGrey, 13))),
          Expanded(child: Text(EnumLocal.txtRechargeToken.name.tr, style: AppFontStyle.styleW600(AppColor.darkGrey, 13), textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  Widget _levelRuleRow(String level, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(level, style: AppFontStyle.styleW500(AppColor.black, 13))),
          Expanded(child: Text(value, style: AppFontStyle.styleW500(AppColor.black, 13), textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}
