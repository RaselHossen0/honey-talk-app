import 'dart:async';

import 'package:get/get.dart';
import 'package:tingle/page/task_page/api/fetch_task_api.dart';
import 'package:tingle/page/task_page/model/fetch_task_model.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';

class TaskController extends GetxController {
  int selectedTabIndex = 0; // 0: Tasks, 1: Rewards
  bool isLoading = true;
  FetchTaskModel? fetchTaskModel;
  Timer? countdownTimer;

  TaskPageData? get data => fetchTaskModel?.data;
  MonthlyCountdown? get monthlyCountdown => data?.monthlyCountdown;
  CheckInBonus? get checkInBonus => data?.checkInBonus;
  InvitationBonus? get invitationBonus => data?.invitationBonus;
  List<DailyTask>? get dailyTasks => data?.dailyTasks;

  int get dailyTaskProgress =>
      dailyTasks?.fold<int>(0, (sum, t) => sum + (t.progress ?? 0)) ?? 0;
  int get dailyTaskTotal =>
      dailyTasks?.fold<int>(0, (sum, t) => sum + (t.totalRequired ?? 0) * (t.multiplier ?? 1)) ?? 300;

  int _countdownDays = 0;
  int _countdownHours = 0;
  int _countdownMins = 0;
  int _countdownSecs = 0;

  String get countdownText =>
      "${_countdownDays}Day(s) "
      "${_countdownHours.toString().padLeft(2, '0')}:"
      "${_countdownMins.toString().padLeft(2, '0')}:"
      "${_countdownSecs.toString().padLeft(2, '0')}";

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    super.onClose();
  }

  Future<void> init() async {
    isLoading = true;
    update([AppConstant.onGetTaskPage]);
    await onFetchTask();
    _syncCountdownFromApi();
    isLoading = false;
    update([AppConstant.onGetTaskPage]);
    startCountdownTimer();
  }

  void _syncCountdownFromApi() {
    final c = monthlyCountdown;
    _countdownDays = c?.daysRemaining ?? 0;
    _countdownHours = c?.hoursRemaining ?? 0;
    _countdownMins = c?.minutesRemaining ?? 0;
    _countdownSecs = c?.secondsRemaining ?? 0;
  }

  Future<void> onFetchTask() async {
    final gender = Database.fetchLoginUserProfile()?.user?.gender;
    fetchTaskModel = await FetchTaskApi.callApi(
      uid: Database.loginUserId,
      token: Database.fcmToken,
      gender: gender,
    );
  }

  void startCountdownTimer() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_countdownSecs > 0) {
        _countdownSecs--;
      } else if (_countdownMins > 0) {
        _countdownMins--;
        _countdownSecs = 59;
      } else if (_countdownHours > 0) {
        _countdownHours--;
        _countdownMins = 59;
        _countdownSecs = 59;
      } else if (_countdownDays > 0) {
        _countdownDays--;
        _countdownHours = 23;
        _countdownMins = 59;
        _countdownSecs = 59;
      }
      update([AppConstant.onGetTaskPage]);
    });
  }

  void onSelectTab(int index) {
    selectedTabIndex = index;
    update([AppConstant.onGetTaskPage]);
  }

  void onGetReward() {
    // API: claim monthly reward
    update([AppConstant.onGetTaskPage]);
  }

  void onClaimCheckIn() {
    // API: claim check-in
    update([AppConstant.onGetTaskPage]);
  }

  void onTaskGo(DailyTask task) {
    final route = task.actionRoute ?? '';
    if (route.isNotEmpty) {
      Get.toNamed(route);
    } else {
      Get.toNamed('/stream_page');
    }
  }
}
