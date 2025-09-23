import 'package:flutter/material.dart';

import '../../model/budget_model.dart';


class BudgetCard extends StatelessWidget {
  final BudgetModel model;
  final VoidCallback onSetBudget;

  const BudgetCard({
    super.key,
    required this.model,
    required this.onSetBudget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(model.icon, color: Colors.white),
        ),
        title: Text(model.categoryName, style: const TextStyle(color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Limit: ₹${model.limit.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white70)),
            Text("Spent: ₹${model.spent}", style: const TextStyle(color: Colors.green)),
            Text("Remaining: ₹${model.remaining}", style: const TextStyle(color: Colors.greenAccent)),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onSetBudget,
          child: const Text("SET BUDGET"),
        ),
      ),
    );
  }
}
