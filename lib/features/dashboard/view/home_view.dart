import 'package:expense_tracker/features/categories/view/category_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/api_service.dart';
import '../../../shared/widgets/custom_widgets/bottom_nav_bar.dart';
import '../../../shared/widgets/custom_widgets/custom_drawer.dart';
import '../../accounts/controller/account_controller.dart';
import '../../accounts/view/account_form.dart';
// <-- You need to create this
import '../../accounts/view/account_page.dart';
import '../../budgets/view/budget_screen.dart';
import '../controller/transaction_controller.dart';
import '../model/transaction_model.dart';
import '../widgets/summary_header.dart';

class HomeView extends StatefulWidget {
  final TransactionController controller;

  const HomeView({super.key, required this.controller});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.loadTransactionsFromApi();
  }


  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller;

    /// Define pages for each tab index
    final List<Widget> pages = [
      _buildDashboard(ctrl),
      Center(child: Text("Analysis", style: TextStyle(color: Colors.white))),
      const BudgetScreen(),
      // Center(child: Text("Budgets", style: TextStyle(color: Colors.white))),
      const AccountsPage(), // <-- Replace with your real page
      const CategoriesView(),
      // Center(child: Text("Categories", style: TextStyle(color: Colors.white))),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          "Expenzo",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFFE9E362),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        backgroundColor: const Color(0xFFE9E362),
        elevation: 6,
        shape: const CircleBorder(),
        onPressed: () async {
          final newTransaction = await showDialog<TransactionModel>(
            context: context,
            builder: (BuildContext context) {
              String type = 'expense';
              String category = '';
              String amount = '';
              DateTime selectedDate = DateTime.now();

              return AlertDialog(
                backgroundColor: Colors.grey[900],
                title: const Text('Add Transaction', style: TextStyle(color: Colors.white)),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(labelText: 'Amount', labelStyle: TextStyle(color: Colors.white70)),
                        keyboardType: TextInputType.number,
                        onChanged: (val) => amount = val,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(labelText: 'Category', labelStyle: TextStyle(color: Colors.white70)),
                        onChanged: (val) => category = val,
                      ),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.black,
                        value: type,
                        onChanged: (val) => type = val!,
                        items: ['expense', 'income']
                            .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(t, style: const TextStyle(color: Colors.white)),
                        ))
                            .toList(),
                        decoration: const InputDecoration(labelText: 'Type', labelStyle: TextStyle(color: Colors.white70)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) selectedDate = picked;
                        },
                        child: const Text('Pick Date'),
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text('Add', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      final _nameController = TextEditingController();
                      final _amountController = TextEditingController();
                      final _categoryController = TextEditingController();
                      String _type = 'expense';
                      DateTime selectedDate = DateTime.now();

                      final newTransaction = await showDialog<TransactionModel>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey[900],
                            title: const Text('Add Transaction', style: TextStyle(color: Colors.white)),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.white70)),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextField(
                                    controller: _amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(labelText: 'Amount', labelStyle: TextStyle(color: Colors.white70)),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextField(
                                    controller: _categoryController,
                                    decoration: const InputDecoration(labelText: 'Category', labelStyle: TextStyle(color: Colors.white70)),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  DropdownButtonFormField<String>(
                                    dropdownColor: Colors.black,
                                    value: _type,
                                    onChanged: (val) => _type = val!,
                                    items: ['expense', 'income'].map((t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t, style: const TextStyle(color: Colors.white)),
                                    )).toList(),
                                    decoration: const InputDecoration(labelText: 'Type', labelStyle: TextStyle(color: Colors.white70)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (picked != null) selectedDate = picked;
                                    },
                                    child: const Text('Pick Date'),
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
                                onPressed: () => Navigator.pop(context),
                              ),
                              ElevatedButton(
                                child: const Text('Add'),
                                onPressed: () {
                                  final name = _nameController.text;
                                  final amount = double.tryParse(_amountController.text);
                                  final category = _categoryController.text;

                                  if (name.isNotEmpty && amount != null && category.isNotEmpty) {
                                    final newTx = TransactionModel(
                                      id: '',
                                      name: name,
                                      amount: amount,
                                      type: _type,
                                      category: category,
                                      date: selectedDate,
                                    );
                                    Navigator.pop(context, newTx);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please fill in all fields')),
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );

                      if (newTransaction != null) {
                        try {
                          await widget.controller.insertTransactionToApi(newTransaction);
                          setState(() {
                            widget.controller.addTransaction(newTransaction);
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to add transaction: $e')),
                          );
                        }
                      }
                    },



                  ),
                ],
              );
            },
          );

          if (newTransaction != null) {
            // 🔁 Call API to save
            await widget.controller.insertTransactionToApi(newTransaction);

            // ✅ Update UI
            setState(() {
              widget.controller.addTransaction(newTransaction);
            });
          }
        },

        child: const Icon(Icons.add, color: Colors.black, size: 30),
      )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTabSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }

  Widget _buildDashboard(TransactionController ctrl) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SummaryHeader(controller: ctrl),
        const SizedBox(height: 20),
        Expanded(
          child: ctrl.transactions.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
            itemCount: ctrl.transactions.length,
            itemBuilder: (context, index) {
              final t = ctrl.transactions[index];
              return ListTile(
                title: Text(t.category, style: TextStyle(color: Colors.white)),
                subtitle: Text('${t.type} - ₹${t.amount}', style: TextStyle(color: Colors.grey)),
                trailing: Text(
                  t.date.toLocal().toString().split(' ')[0],
                  style: TextStyle(color: Colors.white38),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white12,
            ),
            child: const Icon(Icons.receipt_long, color: Colors.white38, size: 60),
          ),
          const SizedBox(height: 20),
          const Text(
            'No record in this month.',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text: 'Tap ',
              style: TextStyle(color: Colors.white60),
              children: [
                TextSpan(
                  text: '+',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: ' to add new\nexpense or income.',
                  style: TextStyle(color: Colors.white60),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


/// Dashboard tab content
  // Widget _buildDashboard(TransactionController ctrl) {
  //   return Column(
  //     children: [
  //       const SizedBox(height: 10),
  //       SummaryHeader(controller: ctrl),
  //       const SizedBox(height: 40),
  //       Expanded(
  //         child: Center(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.all(24),
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   color: Colors.white12,
  //                 ),
  //                 child: const Icon(Icons.receipt_long, color: Colors.white38, size: 60),
  //               ),
  //               const SizedBox(height: 20),
  //               const Text(
  //                 'No record in this month.',
  //                 style: TextStyle(fontSize: 16, color: Colors.white70),
  //               ),
  //               const SizedBox(height: 8),
  //               RichText(
  //                 textAlign: TextAlign.center,
  //                 text: const TextSpan(
  //                   text: 'Tap ',
  //                   style: TextStyle(color: Colors.white60),
  //                   children: [
  //                     TextSpan(
  //                       text: '+',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.yellowAccent,
  //                         fontSize: 20,
  //                       ),
  //                     ),
  //                     TextSpan(
  //                       text: ' to add new\nexpense or income.',
  //                       style: TextStyle(color: Colors.white60),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
