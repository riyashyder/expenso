import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/create_category_controller.dart';

class CreateCategoryView extends StatelessWidget {
  const CreateCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoryController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Category"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Name
            const TextField(
              decoration: InputDecoration(
                labelText: "Category Name",
                hintText: "e.g., Groceries",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            const TextField(
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "e.g., For all food and household shopping",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),

            const Text("Choose an Icon",
                style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 12),

            // Icon Grid
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: controller.icons.map((icon) {
                final isSelected = controller.selectedIconId == icon.id;

                return GestureDetector(
                  onTap: () => controller.selectIcon(icon.id),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Image.asset(
                      icon.imagePath,
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            // Create Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {

                },
                child: const Text(
                  "Create Category",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
