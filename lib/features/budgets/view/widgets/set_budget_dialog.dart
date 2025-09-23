import 'package:flutter/material.dart';

class SetBudgetDialog extends StatelessWidget {
  final String category;
  final void Function(double limit) onSet;

  const SetBudgetDialog({super.key, required this.category, required this.onSet});

  @override
  Widget build(BuildContext context) {
    final limitController = TextEditingController();

    return AlertDialog(
      title: const Text("Set budget"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt, size: 40),
              const SizedBox(width: 12),
              Text(category, style: const TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: limitController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Limit"),
          ),
          const SizedBox(height: 6),
          Text("Month: ${DateTime.now().month}, ${DateTime.now().year}")
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
        ElevatedButton(
          onPressed: () {
            final limit = double.tryParse(limitController.text) ?? 0;
            onSet(limit);
            Navigator.pop(context);
          },
          child: const Text("SET"),
        ),
      ],
    );
  }
}
