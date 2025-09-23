import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/transaction_controller.dart';
import '../model/transaction_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionsController>();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Transactions", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.filter_list, color: Colors.black),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: ListView(
        children: [
          _buildSummaryCard(),
          _buildTabs(controller),
          ..._buildGroupedTransactions(controller.filteredTransactions),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 1,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
      //     BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: "Transactions"),
      //     BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
      //     BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      //   ],
      // ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text("Date Range: ", style: TextStyle(color: Colors.grey)),
              Text("This Month", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Change", style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Column(
                children: [
                  Text("Income", style: TextStyle(color: Colors.grey)),
                  Text("\$1,200.00", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              Column(
                children: [
                  Text("Expenses", style: TextStyle(color: Colors.grey)),
                  Text("-\$850.00", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(TransactionsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTab("All", controller),
        _buildTab("Income", controller),
        _buildTab("Expenses", controller),
      ],
    );
  }

  Widget _buildTab(String label, TransactionsController controller) {
    final isSelected = controller.selectedFilter == label;
    return GestureDetector(
      onTap: () => controller.changeFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: isSelected ? Colors.blue : Colors.transparent, width: 2)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGroupedTransactions(List<TransactionItem> transactions) {
    final grouped = <String, List<TransactionItem>>{};
    for (var t in transactions) {
      grouped.putIfAbsent(t.dateGroup, () => []).add(t);
    }

    return grouped.entries.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          ...entry.value.map((t) => _buildTransactionTile(t)).toList(),
        ],
      );
    }).toList();
  }

  Widget _buildTransactionTile(TransactionItem transaction) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(transaction.icon, color: Colors.blue),
        ),
        title: Text(transaction.title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(transaction.category, style: const TextStyle(color: Colors.grey)),
        trailing: Text(
          "${transaction.amount < 0 ? "" : "+"}\$${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: transaction.amount < 0 ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
