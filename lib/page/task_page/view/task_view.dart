import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/task_page/controller/task_controller.dart';
import 'package:tingle/page/task_page/model/fetch_task_model.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.colorScaffold,
      body: GetBuilder<TaskController>(
        id: AppConstant.onGetTaskPage,
        builder: (ctrl) => ctrl.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColor.primary))
            : ctrl.selectedTabIndex == 1
                ? _buildRewardsTab(context, ctrl)
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: _buildHeader(context, ctrl)),
                      SliverToBoxAdapter(child: _buildTabs(ctrl)),
                      SliverToBoxAdapter(child: _buildMonthlyCountdown(ctrl)),
                      SliverToBoxAdapter(child: _buildCheckInInvitation(ctrl)),
                      SliverToBoxAdapter(child: _buildDailyTasks(ctrl)),
                    ],
                  ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TaskController ctrl) {
    return Container(
      color: AppColor.colorScaffold,
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
              child: Icon(Icons.arrow_back_ios, color: AppColor.black, size: 20),
            ),
          ),
          Expanded(
            child: Text(
              EnumLocal.txtTasks.name.tr,
              textAlign: TextAlign.center,
              style: AppFontStyle.styleW700(AppColor.black, 18),
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _buildTabs(TaskController ctrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: _tabButton(
              EnumLocal.txtTasks.name.tr,
              ctrl.selectedTabIndex == 0,
              () => ctrl.onSelectTab(0),
            ),
          ),
          10.width,
          Expanded(
            child: _tabButton(
              EnumLocal.txtRewards.name.tr,
              ctrl.selectedTabIndex == 1,
              () => ctrl.onSelectTab(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : AppColor.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppColor.primary : AppColor.transparent),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppFontStyle.styleW600(isSelected ? AppColor.white : AppColor.grey, 14),
        ),
      ),
    );
  }

  Widget _buildMonthlyCountdown(TaskController ctrl) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF9A56), Color(0xFFE84393), Color(0xFF9848FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: AppColor.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocal.txtMonthlyEndCountdown.name.tr,
            style: AppFontStyle.styleW700(AppColor.white, 16),
          ),
          12.height,
          Text(
            ctrl.countdownText,
            style: AppFontStyle.styleW800(AppColor.white, 20),
          ),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.icMyDiamond, width: 24, color: AppColor.lightYellow),
                  8.width,
                  Text(
                    CustomFormatNumber.onConvert(ctrl.monthlyCountdown?.points ?? 0),
                    style: AppFontStyle.styleW700(AppColor.white, 16),
                  ),
                ],
              ),
              GestureDetector(
                onTap: ctrl.onGetReward,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    EnumLocal.txtGetReward.name.tr,
                    style: AppFontStyle.styleW600(AppColor.white, 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInInvitation(TaskController ctrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(child: _bonusCard(EnumLocal.txtCheckIn.name.tr, Icons.check_circle, AppColor.green, ctrl.checkInBonus?.amount ?? 50, ctrl.checkInBonus?.claimed ?? false, ctrl.onClaimCheckIn)),
          10.width,
          Expanded(child: _bonusCard(EnumLocal.txtInvitation.name.tr, Icons.mail_outline, AppColor.blue, ctrl.invitationBonus?.amount ?? 200, false, () {})),
        ],
      ),
    );
  }

  Widget _bonusCard(String title, IconData icon, Color iconColor, int amount, bool claimed, VoidCallback onTap) {
    return GestureDetector(
      onTap: claimed ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: AppColor.secondary.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 28),
            8.height,
            Text(title, style: AppFontStyle.styleW600(AppColor.black, 14)),
            6.height,
            Row(
              children: [
                Text("+$amount", style: AppFontStyle.styleW700(AppColor.orange, 16)),
                4.width,
                Image.asset(AppAssets.icMyDiamond, width: 16, color: AppColor.lightYellow),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyTasks(TaskController ctrl) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColor.secondary.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                EnumLocal.txtDailyTasks.name.tr,
                style: AppFontStyle.styleW700(AppColor.primary, 16),
              ),
              Row(
                children: [
                  Text(
                    "(${ctrl.dailyTaskProgress}/${ctrl.dailyTaskTotal})",
                    style: AppFontStyle.styleW500(AppColor.grey, 14),
                  ),
                  4.width,
                  Image.asset(AppAssets.icMyDiamond, width: 18, color: AppColor.lightYellow),
                ],
              ),
            ],
          ),
          4.height,
          Text(ctrl.countdownText, style: AppFontStyle.styleW500(AppColor.grey, 12)),
          16.height,
          ...(ctrl.dailyTasks ?? []).map((task) => _taskItem(ctrl, task)),
        ],
      ),
    );
  }

  Widget _buildRewardsTab(BuildContext context, TaskController ctrl) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader(context, ctrl)),
        SliverToBoxAdapter(child: _buildTabs(ctrl)),
        SliverFillRemaining(
          child: Center(
            child: Text(
              EnumLocal.txtRewards.name.tr,
              style: AppFontStyle.styleW500(AppColor.grey, 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _taskItem(TaskController ctrl, DailyTask task) {
    final progress = task.progress ?? 0;
    final total = task.totalRequired ?? 1;
    final mult = task.multiplier ?? 1;
    final isDone = task.isCompleted ?? (progress >= total);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.secondary.withValues(alpha: 0.1))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title ?? "",
                  style: AppFontStyle.styleW500(AppColor.black, 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                8.height,
                Row(
                  children: [
                    Text(
                      "${task.reward ?? 0} x$mult",
                      style: AppFontStyle.styleW600(AppColor.orange, 13),
                    ),
                    4.width,
                    Image.asset(AppAssets.icMyDiamond, width: 14, color: AppColor.lightYellow),
                  ],
                ),
                4.height,
                Text("$progress/$total", style: AppFontStyle.styleW500(AppColor.grey, 12)),
              ],
            ),
          ),
          12.width,
          GestureDetector(
            onTap: isDone ? null : () => ctrl.onTaskGo(task),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isDone ? AppColor.grey.withValues(alpha: 0.3) : AppColor.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                EnumLocal.txtGo.name.tr,
                style: AppFontStyle.styleW600(isDone ? AppColor.grey : AppColor.white, 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
