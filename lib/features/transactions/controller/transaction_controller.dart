import 'package:flutter/material.dart';

import '../model/transaction_item.dart';

class TransactionsController extends ChangeNotifier {
  String selectedFilter = "All";

  List<TransactionItem> transactions = [
    TransactionItem(title: "Groceries", category: "Food", amount: -25.00, dateGroup: "Today", icon: Icons.shopping_cart),
    TransactionItem(title: "Dinner", category: "Food", amount: -45.00, dateGroup: "Today", icon: Icons.restaurant),
    TransactionItem(title: "Transportation", category: "Travel", amount: -15.00, dateGroup: "Today", icon: Icons.directions_car),

    TransactionItem(title: "Coffee", category: "Food", amount: -5.00, dateGroup: "Yesterday", icon: Icons.coffee),
    TransactionItem(title: "Lunch", category: "Food", amount: -20.00, dateGroup: "Yesterday", icon: Icons.fastfood),
    TransactionItem(title: "Entertainment", category: "Leisure", amount: -30.00, dateGroup: "Yesterday", icon: Icons.movie),
  ];

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
}
