import 'package:flutter/material.dart';

import '../model/budget_model.dart';


class BudgetController extends ChangeNotifier {
  List<BudgetModel> _budgets = [];

  List<BudgetModel> get budgets => _budgets;

  void addBudget(BudgetModel model) {
    _budgets.add(model);
    notifyListeners();
  }

  void updateBudget(String id, double limit) {
    final index = _budgets.indexWhere((b) => b.id == id);
    if (index != -1) {
      _budgets[index] = BudgetModel(
        id: _budgets[index].id,
        categoryName: _budgets[index].categoryName,
        icon: _budgets[index].icon,
        limit: limit,
        spent: _budgets[index].spent,
        month: _budgets[index].month,
        type: _budgets[index].type,
      );
      notifyListeners();
    }
  }

  void removeBudget(String id) {
    _budgets.removeWhere((b) => b.id == id);
    notifyListeners();
  }
}
