import 'dart:math';
import 'package:intl/intl.dart';
import 'package:tingle/page/coin_history_page/model/fetch_coin_history_model.dart';

class FetchCoinHistoryApi {
  static Future<FetchCoinHistoryModel?> callApi({
    required String startDate,
    required String endDate,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    // Generate fake data
    final random = Random();
    final dateFormat = DateFormat('yyyy-MM-dd');
    final start = dateFormat.parse(startDate);
    final end = dateFormat.parse(endDate);
    final dateRange = end.difference(start).inDays;

    // List of possible reasons for coin transactions
    final reasons = [
      'Gift from friend',
      'Video call reward',
      'Live stream gift',
      'Daily bonus',
      'Referral bonus',
      'Withdrawal request',
      'Purchase refund',
      'Admin credit',
      'Event reward',
      'System adjustment'
    ];

    // Generate 10-20 random transactions
    final transactionCount = 10 + random.nextInt(10);
    final transactions = List<Data>.generate(transactionCount, (index) {
      final isIncome = random.nextBool();
      final transactionDate = start.add(Duration(days: random.nextInt(dateRange)));
      final formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(transactionDate);

      return Data(
        id: 'trans_pay_${DateTime.now().millisecondsSinceEpoch}_$index',
        coin: (random.nextInt(1000) + 10) * (isIncome ? 1 : -1),
        createdAt: formattedDate,
        payoutStatus: random.nextInt(3), // 0=pending, 1=completed, 2=failed
        reason: reasons[random.nextInt(reasons.length)],
        type: random.nextInt(5), // Different transaction types
        uniqueId: 'unique_${random.nextInt(10000)}',
        senderName: isIncome ? 'User_${random.nextInt(1000)}' : null,
        receiverName: !isIncome ? 'User_${random.nextInt(1000)}' : null,
        isIncome: isIncome,
      );
    });

    // Sort by date (newest first)
    transactions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return FetchCoinHistoryModel(
      status: true,
      message: 'Coin history fetched successfully',
      data: transactions,
    );
  }
}
