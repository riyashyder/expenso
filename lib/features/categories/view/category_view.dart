import 'dart:ui';

import 'package:expense_tracker/shared/widgets/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/helpers/snackbar_utils.dart';
import '../controller/create_category_controller.dart';
import 'create_category_view.dart';


class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  late CategoryController controller;

  @override
  void initState() {
    super.initState();
    controller = CategoryController();
    controller.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<CategoryController>(
        builder: (context, ctrl, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            // appBar: AppBar(title: const Text("Categories")),
            body: ctrl.categories.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                 padding: const EdgeInsets.all(16),
                 itemCount: ctrl.categories.length,
              itemBuilder: (context, index) {
                final category = ctrl.categories[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.lightBlueAccent.withOpacity(0.1),
                              Colors.lightBlueAccent.withOpacity(0.1),
                              Colors.white.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 1.5,
                          ),
                        ),
                        child: ListTile(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          leading: CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.blue.withOpacity(0.2),
                            child: Icon(
                              controller.getIconById(category.icon),
                              color: Colors.blueAccent,
                              size: 28,
                            ),
                          ),
                          title: Text(
                            category.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            category.description ?? "",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          trailing: Wrap(
                            spacing: 6,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () =>
                                    _showEditDialog(context, category),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (_) => Dialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                      backgroundColor: Colors.transparent,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.lightBlueAccent.withOpacity(0.35),
                                                  Colors.white.withOpacity(0.25),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: BorderRadius.circular(24),
                                              border: Border.all(
                                                color: Colors.white.withOpacity(0.4),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.warning_amber_rounded,
                                                  color: Colors.redAccent,
                                                  size: 48,
                                                ),
                                                const SizedBox(height: 16),
                                                const Text(
                                                  "Delete Category?",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 12),
                                                const Text(
                                                  "This action cannot be undone.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                const SizedBox(height: 24),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor: Colors.grey.shade700,
                                                      ),
                                                      onPressed: () => Navigator.pop(context, false),
                                                      child: const Text("Cancel"),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.redAccent,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 12),
                                                      ),
                                                      onPressed: () => Navigator.pop(context, true),
                                                      child: const Text("Delete",
                                                          style: TextStyle(color: Colors.white)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );

                                  if (confirmed ?? false) {
                                    await ctrl.deleteCategory(category.id);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            // body: ctrl.categories.isEmpty
            //     ? const Center(child: CircularProgressIndicator())
            //     : ListView.builder(
            //   padding: const EdgeInsets.all(16),
            //   itemCount: ctrl.categories.length,
            //   itemBuilder: (context, index) {
            //     final category = ctrl.categories[index];
            //     return Card(
            //       margin: const EdgeInsets.only(bottom: 16),
            //       shape:
            //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            //       elevation: 4,
            //       child: ListTile(
            //         leading: CircleAvatar(
            //           backgroundColor: Colors.blue.shade50,
            //           child: Icon(controller.getIconById(category.icon),
            //               color: Colors.blueAccent),
            //         ),
            //         title: Text(category.name,
            //             style: const TextStyle(fontWeight: FontWeight.bold)),
            //         subtitle: Text(category.description ?? "",
            //             style: TextStyle(color: Colors.grey.shade600)),
            //         trailing: Wrap(
            //           spacing: 4,
            //           children: [
            //             IconButton(
            //               icon: const Icon(Icons.edit, color: Colors.blue),
            //               onPressed: () => _showEditDialog(context, category),
            //             ),
            //             IconButton(
            //               icon: const Icon(Icons.delete, color: Colors.red),
            //               onPressed: () async {
            //                 final confirmed = await showDialog<bool>(
            //                   context: context,
            //                   builder: (_) => AlertDialog(
            //                     title: const Text("Delete Category"),
            //                     content: const Text("Are you sure?"),
            //                     actions: [
            //                       TextButton(
            //                           onPressed: () =>
            //                               Navigator.pop(context, false),
            //                           child: const Text("Cancel")),
            //                       ElevatedButton(
            //                         style: ElevatedButton.styleFrom(
            //                             backgroundColor: Colors.red),
            //                         onPressed: () =>
            //                             Navigator.pop(context, true),
            //                         child: const Text("Delete"),
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //                 if (confirmed ?? false) {
            //                   await ctrl.deleteCategory(category.id);
            //                 }
            //               },
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: AppthemeData.buttonColor,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: controller,
                      child: const CreateCategoryView(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text("New"),
            ),

            // body: ctrl.categories.isEmpty
            //     ? const Center(child: CircularProgressIndicator())
            //     : ListView.builder(
            //   itemCount: ctrl.categories.length,
            //   itemBuilder: (context, index) {
            //     final category = ctrl.categories[index];
            //     return ListTile(
            //       leading: Icon(controller.getIconById(category.icon)),
            //       title: Text(category.name),
            //       subtitle: Text(category.description ?? ""),
            //       trailing: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           IconButton(
            //             icon: const Icon(Icons.edit, color: Colors.blue),
            //             onPressed: () {
            //               _showEditDialog(context, category);
            //             },
            //           ),
            //           IconButton(
            //             icon: const Icon(Icons.delete, color: Colors.red),
            //             onPressed: () async {
            //               final confirmed = await showDialog<bool>(
            //                 context: context,
            //                 builder: (_) => AlertDialog(
            //                   title: const Text("Delete Category"),
            //                   content: const Text("Are you sure?"),
            //                   actions: [
            //                     TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
            //                     TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
            //                   ],
            //                 ),
            //               );
            //               if (confirmed ?? false) {
            //                 await ctrl.deleteCategory(category.id);
            //               }
            //             },
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => ChangeNotifierProvider(
            //           create: (_) => controller,
            //           child: const CreateCategoryView(),
            //         ),
            //       ),
            //     );
            //   },
            //   backgroundColor: Colors.yellow,
            //   child: const Icon(Icons.add, color: Colors.black),
            // ),
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, CategoryModel category) {
    final nameController = TextEditingController(text: category.name);
    final descController = TextEditingController(text: category.description);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlueAccent.withOpacity(0.35),
                    Colors.white.withOpacity(0.25),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Edit Category",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name field
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.title, color: Colors.blueAccent),
                      hintText: "Enter category name",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description field
                  TextField(
                    controller: descController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.description, color: Colors.blueAccent),
                      hintText: "Enter description",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        onPressed: () async {
                          final result = await controller.updateCategory(
                            categoryId: category.id,
                            name: nameController.text,
                            description: descController.text,
                          );
                          if (context.mounted) {
                            showTopSnackBar(context, result["message"], success: result["success"]);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Save", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
