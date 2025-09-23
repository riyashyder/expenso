import 'package:flutter/cupertino.dart';

enum CategoryType { income, expense }

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final CategoryType type;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
  });
}
