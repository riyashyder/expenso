import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/category_controller.dart';
import '../model/category_model.dart';
import '../widgets/category_tile.dart';


class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoryController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF3E3C3C),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: const Color(0xFF4B4949),
            child: Column(
              children: const [
                Text('[ All Accounts ₹0.00 ]', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('EXPENSE SO FAR\n₹0.00', style: TextStyle(color: Colors.redAccent)),
                    Text('INCOME SO FAR\n₹0.00', style: TextStyle(color: Colors.greenAccent)),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Income categories', style: TextStyle(color: Colors.white)),
          ),
          ...controller.incomeCategories.map((cat) => CategoryTile(category: cat)),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Expense categories', style: TextStyle(color: Colors.white)),
          ),
          ...controller.expenseCategories.map((cat) => CategoryTile(category: cat)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(context),
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final controller = Provider.of<CategoryController>(context, listen: false);
    final nameController = TextEditingController();
    CategoryType selectedType = CategoryType.income;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF4B4949),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Add Category',
          style: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(color: Colors.white70),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellowAccent),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF3E3C3C),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Income', style: TextStyle(color: Colors.white70)),
                      leading: Radio<CategoryType>(
                        value: CategoryType.income,
                        groupValue: selectedType,
                        activeColor: Colors.yellowAccent,
                        onChanged: (CategoryType? value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Expense', style: TextStyle(color: Colors.white70)),
                      leading: Radio<CategoryType>(
                        value: CategoryType.expense,
                        groupValue: selectedType,
                        activeColor: Colors.yellowAccent,
                        onChanged: (CategoryType? value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellowAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isEmpty) return;
              controller.addCategory(CategoryModel(
                id: DateTime.now().toString(),
                name: name,
                icon: Icons.category,
                type: selectedType,
              ));
              Navigator.pop(context);
            },
            child: const Text('Add', style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }


}
