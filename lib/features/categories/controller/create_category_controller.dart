import 'package:flutter/material.dart';

import '../model/create_category_model.dart';

class CategoryController with ChangeNotifier {
  int? selectedIconId;

  // Array of category icons
  final List<CategoryIcon> icons = [
    CategoryIcon(id: 1, imagePath: "assets/icons/food.png"),
    CategoryIcon(id: 2, imagePath: "assets/icons/transport.png"),
    CategoryIcon(id: 3, imagePath: "assets/icons/shopping.png"),
    CategoryIcon(id: 4, imagePath: "assets/icons/medicine.png"),
    CategoryIcon(id: 5, imagePath: "assets/icons/apple.png"),
    CategoryIcon(id: 6, imagePath: "assets/icons/bag.png"),
    CategoryIcon(id: 7, imagePath: "assets/icons/upload.png"),
  ];

  void selectIcon(int id) {
    selectedIconId = id;
    notifyListeners();
  }
}
