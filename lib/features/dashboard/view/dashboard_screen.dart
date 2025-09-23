import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controller/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DashboardController>(context);

    return PopScope(
      canPop: false, // ❌ Prevent default back navigation
      onPopInvokedWithResult: (didPop,result) {
        if (!didPop) {
          // ✅ Exit the app instead of popping
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   title: const Text("Dashboard",
        //       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        //   leading: IconButton(icon: const Icon(Icons.menu, color: Colors.black), onPressed: () {}),
        //   actions: [IconButton(icon: const Icon(Icons.notifications_none, color: Colors.black), onPressed: () {})],
        // ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Spending & Budget
            Row(
              children: [
                Expanded(child: _buildInfoCard("Total Spending", "\$${controller.totalSpending.toStringAsFixed(2)}")),
                const SizedBox(width: 12),
                Expanded(child: _buildInfoCard("Budget", "\$${controller.budget.toStringAsFixed(2)}")),
              ],
            ),
            const SizedBox(height: 16),
      
            // Budget progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Budget Progress"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(""),
                    Text("\$${controller.remainingBudget.toStringAsFixed(2)} remaining",
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: controller.budgetProgress,
                  backgroundColor: Colors.grey[200],
                  color: Colors.blue,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
            const SizedBox(height: 24),
      
            // Accounts
            const Text("Accounts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            for (var account in controller.accounts)
              ListTile(
                leading: const Icon(Icons.account_balance),
                title: Text(account.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(account.type, style: const TextStyle(color: Colors.grey)),
                trailing: Text("\$${account.balance.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            const SizedBox(height: 24),
      
            // Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Recent Transactions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("View All", style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 12),
            for (var txn in controller.transactions)
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.shopping_cart, color: Colors.black),
                ),
                title: Text(txn.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(txn.category, style: const TextStyle(color: Colors.grey)),
                trailing: Text(
                  "${txn.amount < 0 ? '-' : ''}\$${txn.amount.abs().toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: 0,
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: Colors.black,
        //   unselectedItemColor: Colors.grey,
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
        //     BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: "Transactions"),
        //     BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
        //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        //   ],
        // ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}
