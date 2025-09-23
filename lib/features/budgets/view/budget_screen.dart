import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/budget_controller.dart';
import '../model/budget_model.dart';
import 'widgets/budget_card.dart';
import 'widgets/set_budget_dialog.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BudgetController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // example dummy add
          showDialog(
            context: context,
            builder: (_) => SetBudgetDialog(
              category: "New Category",
              onSet: (limit) {
                controller.addBudget(
                  BudgetModel(
                    id: DateTime.now().toString(),
                    categoryName: "New Category",
                    icon: Icons.new_label,
                    limit: limit,
                    spent: 0,
                    month: DateTime.now(),
                    type: BudgetType.expense,
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text("Budgeted categories: July 2025", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 12),
                ...controller.budgets.map((b) => BudgetCard(
                  model: b,
                  onSetBudget: () => showDialog(
                    context: context,
                    builder: (_) => SetBudgetDialog(
                      category: b.categoryName,
                      onSet: (newLimit) => controller.updateBudget(b.id, newLimit),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
