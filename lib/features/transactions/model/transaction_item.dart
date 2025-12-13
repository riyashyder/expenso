import 'package:flutter/material.dart';

class TransactionItem {
  final String title;
  final String category;
  final String type;
  final double amount;
  final String dateGroup; // e.g. "Today", "Yesterday"
  final IconData icon;

  TransactionItem({

    required this.title,
    required this.type,
    required this.category,
    required this.amount,
    required this.dateGroup,
    required this.icon,
  });
}
