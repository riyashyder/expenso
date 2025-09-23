import 'package:flutter/cupertino.dart';

enum BudgetType { income, expense }

class BudgetModel {
  final String id;
  final String categoryName;
  final IconData icon;
  final double limit;
  final double spent;
  final DateTime month;
  final BudgetType type;

  BudgetModel({
    required this.id,
    required this.categoryName,
    required this.icon,
    required this.limit,
    required this.spent,
    required this.month,
    required this.type,
  });

  double get remaining => limit - spent;
}
