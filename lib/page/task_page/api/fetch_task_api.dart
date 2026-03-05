import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/task_page/model/fetch_task_model.dart';
import 'package:tingle/utils/utils.dart';

/// API for Task page. Uses GET /tasks and maps to TaskPageData.
/// Pass [gender] for future gender-specific filtering if backend supports it.
class FetchTaskApi {
  static Future<FetchTaskModel> callApi({
    String? uid,
    String? token,
    String? gender,
  }) async {
    Utils.showLog("Fetch Task API Calling... gender=$gender");
    try {
      final res = await ApiClient.instance.get('/tasks');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final dailyTasks = list.map((m) {
        final id = m['id'] as String?;
        final title = m['title'] as String? ?? '';
        final reward = (m['rewardAmount'] as num?)?.toInt() ?? 0;
        final totalRequired = (m['targetQuantity'] as num?)?.toInt() ?? 0;
        return DailyTask(
          id: id,
          title: title,
          reward: reward,
          multiplier: 1,
          progress: 0,
          totalRequired: totalRequired,
          actionType: m['type'] as String?,
          actionRoute: null,
          isCompleted: false,
        );
      }).toList();

      return FetchTaskModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: TaskPageData(
          monthlyCountdown: MonthlyCountdown(
            daysRemaining: 7,
            hoursRemaining: 3,
            minutesRemaining: 29,
            secondsRemaining: 22,
            points: 2590,
            canClaim: false,
          ),
          checkInBonus: CheckInBonus(amount: 50, claimed: false),
          invitationBonus: InvitationBonus(amount: 200),
          dailyTasks: dailyTasks.isEmpty ? null : dailyTasks,
        ),
      );
    } catch (e) {
      Utils.showLog("Fetch Task API Error: $e");
      return FetchTaskModel(
        status: false,
        message: e.toString(),
        data: TaskPageData(
          monthlyCountdown: null,
          checkInBonus: null,
          invitationBonus: null,
          dailyTasks: null,
        ),
      );
    }
  }
}
