import 'package:flutter/material.dart';

import '../model/category_model.dart';


class CategoryController extends ChangeNotifier {
  final List<CategoryModel> _categories = [
    CategoryModel(id: '1', name: 'Salary', icon: Icons.money, type: CategoryType.income),
    CategoryModel(id: '2', name: 'Rent', icon: Icons.house, type: CategoryType.income),
    CategoryModel(id: '3', name: 'Baby', icon: Icons.child_friendly, type: CategoryType.expense),
  ];

  List<CategoryModel> get incomeCategories =>
      _categories.where((c) => c.type == CategoryType.income).toList();

  List<CategoryModel> get expenseCategories =>
      _categories.where((c) => c.type == CategoryType.expense).toList();

  void addCategory(CategoryModel category) {
    _categories.add(category);
    notifyListeners();
  }

  void editCategory(String id, CategoryModel updatedCategory) {
    final index = _categories.indexWhere((c) => c.id == id);
    if (index != -1) {
      _categories[index] = updatedCategory;
      notifyListeners();
    }
  }

  void deleteCategory(String id) {
    _categories.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}
