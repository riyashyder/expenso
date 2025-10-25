import 'package:flutter/material.dart';
import '../model/transaction_item.dart';
import 'transaction_api_controller.dart';

class TransactionsController extends ChangeNotifier {
  final TransactionApiController apiController = TransactionApiController();

  String selectedFilter = "All";
  List<TransactionItem> transactions = [];

  double totalIncome = 0;
  double totalExpense = 0;
  double netTotal = 0;

  bool get isLoading => apiController.isLoading;

  void changeFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  List<TransactionItem> get filteredTransactions {
    if (selectedFilter == "All") return transactions;
    if (selectedFilter == "Income") {
      return transactions.where((t) => t.amount > 0).toList();
    }
    if (selectedFilter == "Expenses") {
      return transactions.where((t) => t.amount < 0).toList();
    }
    return transactions;
  }

  Future<void> fetchTransactions({String? from, String? to}) async {
    final result = await apiController.fetchTransactions(
      from: from ?? "", // send empty string if not provided
      to: to ?? "",
    );

    print("fetchTransactions result");
    print(result);

    if (result["success"]) {
      final summary = result["summary"];
      totalIncome = (summary["totalIncome"] ?? 0).toDouble();
      totalExpense = (summary["totalExpense"] ?? 0).toDouble();
      netTotal = (summary["netTotal"] ?? 0).toDouble();

      final expenses = result["expenses"] as List<dynamic>;
      transactions = expenses.map((e) {
        return TransactionItem(
          title: e["category"] ?? "Transaction",
          category: e["category"] ?? "",
          amount: double.tryParse(e["amount"].toString()) ?? 0,
          dateGroup: e["expenseDate"]?.split("T")[0] ?? "Unknown",
          icon: e["type"] == "income"
              ? Icons.arrow_downward
              : Icons.arrow_upward,
        );
      }).toList();
      notifyListeners();
    } else {
      debugPrint("Fetch failed: ${result['message']}");
    }
  }

  Future<void> createTransaction({
    required String expenseDate,
    required String type,
    required String category,
    required double amount,
  }) async {
    final result = await apiController.createTransaction(
      expenseDate: expenseDate,
      type: type,
      category: category,
      amount: amount,
    );

    if (result["success"]) {
      await fetchTransactions(); // refresh list after creating new transaction
    } else {
      debugPrint("Error: ${result['message']}");
    }
  }
}
