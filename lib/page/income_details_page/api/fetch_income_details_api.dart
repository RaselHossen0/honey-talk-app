import 'dart:async';

import 'package:intl/intl.dart';
import 'package:tingle/page/income_details_page/model/fetch_income_details_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchIncomeDetailsApi {
  static Future<FetchIncomeDetailsModel> callApi({String? filter}) async {
    Utils.showLog("Fetch Income Details API Calling... filter=$filter");
    await Future.delayed(const Duration(milliseconds: 200));

    final now = DateTime.now();

    final transactions = <IncomeTransaction>[
      IncomeTransaction(
        id: "1",
        type: "agent_transfer",
        recipientName: "sudiptadas...",
        recipientId: "12/62135",
        recipientImage: null,
        createdAt: "${DateFormat("yyyy-MM-dd").format(now.subtract(const Duration(hours: 1)))}T${DateFormat("HH:mm:ss").format(now.subtract(const Duration(hours: 1)))}",
        subsidy: null,
        revenue: 100000,
        total: 100000,
      ),
      IncomeTransaction(
        id: "2",
        type: "agent_transfer",
        recipientName: "Aarohi O...",
        recipientId: "12187554",
        recipientImage: null,
        createdAt: "${DateFormat("yyyy-MM-dd").format(now.subtract(const Duration(hours: 2)))}T${DateFormat("HH:mm:ss").format(now.subtract(const Duration(hours: 2)))}",
        subsidy: 4660,
        revenue: 315340,
        total: 320000,
      ),
      IncomeTransaction(
        id: "3",
        type: "commission",
        recipientName: null,
        recipientId: null,
        recipientImage: null,
        createdAt: "${DateFormat("yyyy-MM-dd").format(now.subtract(const Duration(days: 1)))}T${DateFormat("HH:mm:ss").format(now.subtract(const Duration(days: 1)))}",
        subsidy: null,
        revenue: 950000,
        total: 950000,
      ),
      IncomeTransaction(
        id: "4",
        type: "agent_transfer",
        recipientName: "rasnibaby",
        recipientId: "15633823",
        recipientImage: null,
        createdAt: "${DateFormat("yyyy-MM-dd").format(now.subtract(const Duration(days: 1, hours: 2)))}T${DateFormat("HH:mm:ss").format(now.subtract(const Duration(days: 1, hours: 2)))}",
        subsidy: 466,
        revenue: 99534,
        total: 100000,
      ),
      IncomeTransaction(
        id: "5",
        type: "withdrawal",
        recipientName: null,
        recipientId: null,
        recipientImage: null,
        createdAt: "${DateFormat("yyyy-MM-dd").format(now.subtract(const Duration(days: 1, hours: 3)))}T${DateFormat("HH:mm:ss").format(now.subtract(const Duration(days: 1, hours: 3)))}",
        subsidy: -183047,
        revenue: -10596953,
        total: -10780000,
      ),
      IncomeTransaction(
        id: "6",
        type: "agent_transfer",
        recipientName: "prithi❤️...",
        recipientId: "15638146",
        recipientImage: null,
        createdAt: "${DateFormat("yyyy-MM-dd").format(now.subtract(const Duration(days: 1, hours: 4)))}T${DateFormat("HH:mm:ss").format(now.subtract(const Duration(days: 1, hours: 4)))}",
        subsidy: null,
        revenue: 300000,
        total: 300000,
      ),
      IncomeTransaction(
        id: "7",
        type: "agent_transfer",
        recipientName: "mouGBZ",
        recipientId: "15634307",
        recipientImage: null,
        createdAt: "${DateFormat("yyyy-MM-dd").format(now.subtract(const Duration(days: 1, hours: 5)))}T${DateFormat("HH:mm:ss").format(now.subtract(const Duration(days: 1, hours: 5)))}",
        subsidy: 15478,
        revenue: 104522,
        total: 120000,
      ),
      IncomeTransaction(
        id: "8",
        type: "agent_transfer",
        recipientName: "lovelypriya...",
        recipientId: "15419690",
        recipientImage: null,
        createdAt: "${DateFormat("yyyy-MM-dd").format(now.subtract(const Duration(days: 1, hours: 5)))}T${DateFormat("HH:mm:ss").format(now.subtract(const Duration(days: 1, hours: 5)))}",
        subsidy: null,
        revenue: 120000,
        total: 120000,
      ),
      IncomeTransaction(
        id: "9",
        type: "agent_transfer",
        recipientName: "Lia...",
        recipientId: "15091459",
        recipientImage: null,
        createdAt: "${DateFormat("yyyy-MM-dd").format(now.subtract(const Duration(days: 1, hours: 5)))}T${DateFormat("HH:mm:ss").format(now.subtract(const Duration(days: 1, hours: 5)))}",
        subsidy: 2133,
        revenue: 747867,
        total: 750000,
      ),
    ];

    return FetchIncomeDetailsModel(status: true, message: "Success", data: transactions);
  }
}
