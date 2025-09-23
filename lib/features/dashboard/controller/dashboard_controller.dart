import 'package:flutter/material.dart';

import '../model/accounts.dart';
import '../model/transcation.dart';

class DashboardController extends ChangeNotifier {
  double totalSpending = 1250.00;
  double budget = 2000.00;

  List<Account> accounts = [
    Account(name: "Bank of America", type: "Checking", balance: 3500.00, icon: "bank"),
    Account(name: "Chase", type: "Savings", balance: 10200.00, icon: "savings"),
    Account(name: "Capital One", type: "Credit Card", balance: 500.00, icon: "card"),
  ];

  List<TransactionModelDemo> transactions = [
    TransactionModelDemo(title: "Whole Foods", category: "Groceries", amount: -120.00, icon: "cart"),
    TransactionModelDemo(title: "The Italian Place", category: "Dining", amount: -75.00, icon: "restaurant"),
  ];

  double get remainingBudget => budget - totalSpending;

  double get budgetProgress => totalSpending / budget;
}
