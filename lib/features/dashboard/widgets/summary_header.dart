import 'package:flutter/material.dart';
import '../controller/transaction_controller.dart';

class SummaryHeader extends StatelessWidget {
  final TransactionController controller;

  const SummaryHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: const Color(0xFF2B2B2B),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.arrow_back_ios, size: 16, color: Colors.white),
              Text("July, 2025", style: TextStyle(color: Colors.white, fontSize: 18)),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildStat("EXPENSE", controller.totalExpense, Colors.red),
              buildStat("INCOME", controller.totalIncome, Colors.green),
              buildStat("TOTAL", controller.total, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildStat(String label, double value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white54)),
        Text(
          '₹${value.toStringAsFixed(2)}',
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
