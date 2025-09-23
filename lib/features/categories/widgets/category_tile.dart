import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/category_controller.dart';
import '../model/category_model.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;

  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.white10, child: Icon(category.icon, color: Colors.white)),
      title: Text(category.name, style: const TextStyle(color: Colors.white)),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, color: Colors.white),
        onSelected: (value) {
          if (value == 'Edit') {
            _editCategory(context);
          } else {
            Provider.of<CategoryController>(context, listen: false).deleteCategory(category.id);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'Edit', child: Text('Edit')),
          const PopupMenuItem(value: 'Delete', child: Text('Delete')),
        ],
      ),
    );
  }

  void _editCategory(BuildContext context) {
    final controller = Provider.of<CategoryController>(context, listen: false);
    final nameController = TextEditingController(text: category.name);
    CategoryType type = category.type;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            DropdownButton<CategoryType>(
              value: type,
              onChanged: (val) {
                type = val!;
              },
              items: CategoryType.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.editCategory(
                category.id,
                CategoryModel(
                  id: category.id,
                  name: nameController.text,
                  icon: category.icon,
                  type: type,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
