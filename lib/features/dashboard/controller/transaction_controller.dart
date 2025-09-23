import 'package:flutter/material.dart';
import '../model/transaction_model.dart';
import '../../../services/api_service.dart';

class TransactionController extends ChangeNotifier {
  List<TransactionModel> transactions = [];

  void addTransaction(TransactionModel transaction) {
    transactions.add(transaction);
    notifyListeners();
  }

  Future<void> insertTransactionToApi(TransactionModel transaction) async {
    await ApiService.createTransaction(transaction);
    await loadTransactionsFromApi(); // Refresh the list after inserting
  }

  Future<void> loadTransactionsFromApi() async {
    transactions = await ApiService.fetchTransactions();
    notifyListeners();
  }

  double get totalIncome => transactions
      .where((t) => t.type == "income")
      .fold(0, (sum, t) => sum + t.amount);

  double get totalExpense => transactions
      .where((t) => t.type == "expense")
      .fold(0, (sum, t) => sum + t.amount);

  double get total => totalIncome - totalExpense;
}
