  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';

  import '../../../core/utils/helpers/snackbar_utils.dart';
import '../controller/create_category_controller.dart';

  class CreateCategoryView extends StatefulWidget {
    const CreateCategoryView({super.key});

    @override
    State<CreateCategoryView> createState() => _CreateCategoryViewState();
  }

  class _CreateCategoryViewState extends State<CreateCategoryView> {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    final ValueNotifier<String?> nameError = ValueNotifier(null);
    bool nameTouched = false; // tracks if user interacted with name field

    @override
    void initState() {
      super.initState();

      nameController.addListener(() {
        final text = nameController.text.trim();

        // Only validate after user has interacted
        if (nameTouched) {
          if (text.isEmpty) {
            nameError.value = "Category name cannot be empty";
          } else if (text.length < 3) {
            nameError.value = "Category name must be at least 3 letters";
          } else {
            nameError.value = null;
          }
        }

        // Force rebuild button state
        setState(() {});
      });
    }

    bool get isFormValid =>
        nameController.text.trim().length >= 3; // button enabled condition

    @override
    void dispose() {
      nameController.dispose();
      descController.dispose();
      nameError.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      final controller = Provider.of<CategoryController>(context);

      return Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          title: const Text("New Category"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field with validation
              ValueListenableBuilder<String?>(
                valueListenable: nameError,
                builder: (context, error, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (hasFocus) nameTouched = true;
                        },
                        child: _buildTextField(
                          controller: nameController,
                          label: "Category Name",
                          hint: "e.g., Groceries",
                          icon: Icons.title,
                        ),
                      ),
                      if (nameTouched && error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 12),
                          child: Text(
                            error,
                            style: const TextStyle(
                                color: Colors.redAccent, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // Description field
              _buildTextField(
                controller: descController,
                label: "Description",
                hint: "e.g., Food and household shopping",
                icon: Icons.description,
                maxLines: 2,
              ),
              const SizedBox(height: 28),
              const Text(
                "Category Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white, // ✅ change popup background color
                    value: controller.selectedType,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent),
                    hint: const Text("Select Category Type"),
                    items: controller.categoryTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectType(value);
                        setState(() {});
                      }
                    },
                  ),
                ),

              ),
              const SizedBox(height: 28),


              const Text(
                "Choose an Icon",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: controller.icons.map((icon) {
                  final isSelected = controller.selectedIconId == icon.id;
                  return GestureDetector(
                    onTap: () => controller.selectIcon(icon.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 8,
                            ),
                        ],
                      ),
                      child: Icon(
                        icon.icon,
                        size: 34,
                        color: isSelected ? Colors.blue : Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),

              // Create button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    backgroundColor:
                    isFormValid ? Colors.blueAccent : Colors.blueAccent.shade200,
                  ),
                  onPressed: isFormValid
                      ? () async {
                    final result = await controller.createCategory(
                      name: nameController.text.trim(),
                      description: descController.text.trim(),
                      type: controller.selectedType,
                    );
                    if (context.mounted) {
                      showTopSnackBar(
                        context,
                        result["message"],
                        success: result["success"],
                      );
                    }
                    if (result["success"]) Navigator.pop(context);
                  }
                      : null,
                  child: const Text(
                    "Create Category",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildTextField({
      required TextEditingController controller,
      required String label,
      required String hint,
      required IconData icon,
      int maxLines = 1,
    }) {
      return TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      );
    }
  }


  // class _CreateCategoryViewState extends State<CreateCategoryView> {
  //   final nameController = TextEditingController();
  //   final descController = TextEditingController();
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     final controller = Provider.of<CategoryController>(context);
  //
  //     return Scaffold(
  //       backgroundColor: const Color(0xFFF9FAFB),
  //       appBar: AppBar(
  //         title: const Text("New Category"),
  //         centerTitle: true,
  //         elevation: 0,
  //         backgroundColor: Colors.transparent,
  //         foregroundColor: Colors.black87,
  //       ),
  //       body: SingleChildScrollView(
  //         padding: const EdgeInsets.all(20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             // Name field
  //             _buildTextField(
  //               controller: nameController,
  //               label: "Category Name",
  //               hint: "e.g., Groceries",
  //               icon: Icons.title,
  //             ),
  //             const SizedBox(height: 20),
  //
  //             // Description field
  //             _buildTextField(
  //               controller: descController,
  //               label: "Description",
  //               hint: "e.g., Food and household shopping",
  //               icon: Icons.description,
  //               maxLines: 2,
  //             ),
  //             const SizedBox(height: 28),
  //
  //             const Text("Choose an Icon",
  //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //             const SizedBox(height: 16),
  //
  //             // Icon selection with animation
  //             Wrap(
  //               spacing: 20,
  //               runSpacing: 20,
  //               children: controller.icons.map((icon) {
  //                 final isSelected = controller.selectedIconId == icon.id;
  //                 return GestureDetector(
  //                   onTap: () => controller.selectIcon(icon.id),
  //                   child: AnimatedContainer(
  //                     duration: const Duration(milliseconds: 200),
  //                     curve: Curves.easeInOut,
  //                     padding: const EdgeInsets.all(16),
  //                     decoration: BoxDecoration(
  //                       color: isSelected ? Colors.blue.shade50 : Colors.white,
  //                       shape: BoxShape.circle,
  //                       border: Border.all(
  //                         color: isSelected ? Colors.blue : Colors.grey.shade300,
  //                         width: 2,
  //                       ),
  //                       boxShadow: [
  //                         if (isSelected)
  //                           BoxShadow(
  //                             color: Colors.blue.withOpacity(0.3),
  //                             blurRadius: 8,
  //                           ),
  //                       ],
  //                     ),
  //                     child: Icon(
  //                       icon.icon,
  //                       size: 34,
  //                       color: isSelected ? Colors.blue : Colors.black87,
  //                     ),
  //                   ),
  //                 );
  //               }).toList(),
  //             ),
  //             const SizedBox(height: 40),
  //
  //             // Create button
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   padding: const EdgeInsets.symmetric(vertical: 16),
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(14)),
  //                   backgroundColor: Colors.blueAccent,
  //                 ),
  //                 onPressed: () async {
  //                   final result = await controller.createCategory(
  //                     name: nameController.text.trim(),
  //                     description: descController.text.trim(),
  //                   );
  //                   if (context.mounted) {
  //                     showTopSnackBar(
  //                       context,
  //                       result["message"],
  //                       success: result["success"],
  //                     );
  //                   }
  //                   if (result["success"]) Navigator.pop(context);
  //                 },
  //                 child: const Text(
  //                   "Create Category",
  //                   style: TextStyle(
  //                       fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //
  //   Widget _buildTextField({
  //     required TextEditingController controller,
  //     required String label,
  //     required String hint,
  //     required IconData icon,
  //     int maxLines = 1,
  //   }) {
  //     return TextField(
  //       controller: controller,
  //       maxLines: maxLines,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(icon, color: Colors.blueAccent),
  //         labelText: label,
  //         hintText: hint,
  //         filled: true,
  //         fillColor: Colors.white,
  //         contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(14),
  //           borderSide: BorderSide.none,
  //         ),
  //       ),
  //     );
  //   }
  // }

  // class CreateCategoryView extends StatefulWidget {
  //   const CreateCategoryView({super.key});
  //
  //   @override
  //   State<CreateCategoryView> createState() => _CreateCategoryViewState();
  // }
  //
  // class _CreateCategoryViewState extends State<CreateCategoryView> {
  //   final nameController = TextEditingController();
  //   final descController = TextEditingController();
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     final controller = Provider.of<CategoryController>(context);
  //
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: const Text("Create Category"),
  //         centerTitle: true,
  //         elevation: 0,
  //         backgroundColor: Colors.white,
  //         foregroundColor: Colors.black,
  //       ),
  //       body: SingleChildScrollView(
  //         child: Padding(
  //           padding: const EdgeInsets.all(16),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // Category Name
  //               TextField(
  //                 controller: nameController,
  //                 onChanged: (_) => setState(() {}), // triggers rebuild
  //                 decoration: InputDecoration(
  //                   labelText: "Category Name",
  //                   hintText: "e.g., Groceries",
  //                   border: const OutlineInputBorder(),
  //                   focusedBorder: const OutlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.blue, width: 2),
  //                   ),
  //                   labelStyle: TextStyle(
  //                     color: nameController.text.isNotEmpty ? Colors.blue : Colors.grey,
  //                   ),
  //                 ),
  //               ),
  //
  //               const SizedBox(height: 16),
  //               // Description
  //               TextField(
  //                 controller: descController,
  //                 onChanged: (_) => setState(() {}),
  //                 decoration: InputDecoration(
  //                   labelText: "Description",
  //                   hintText: "e.g., For all food and household shopping",
  //                   border: const OutlineInputBorder(),
  //                   focusedBorder:  const OutlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.blue, width: 2), // Dark blue border
  //                   ),
  //                   labelStyle: TextStyle(
  //                     color: descController.text.isNotEmpty ? Colors.blue : Colors.grey,
  //                   ),
  //                 ),
  //                 maxLines: 2,
  //               ),
  //               const SizedBox(height: 24),
  //               const Text("Choose an Icon", style: TextStyle(fontWeight: FontWeight.bold)),
  //               const SizedBox(height: 12),
  //
  //               // Icon Grid
  //               Wrap(
  //                 spacing: 16,
  //                 runSpacing: 16,
  //                 children: controller.icons.map((icon) {
  //                   final isSelected = controller.selectedIconId == icon.id;
  //
  //                   return GestureDetector(
  //                     onTap: () {
  //                       Provider.of<CategoryController>(context, listen: false)
  //                           .selectIcon(icon.id);
  //                     },
  //                     child: Container(
  //                       padding: const EdgeInsets.all(12),
  //                       decoration: BoxDecoration(
  //                         shape: BoxShape.circle,
  //                         border: Border.all(
  //                           color: isSelected ? Colors.blue : Colors.transparent,
  //                           width: 2,
  //                         ),
  //                       ),
  //                       child: Icon(
  //                         icon.icon,
  //                         size: 40,
  //                         color: isSelected ? Colors.blue : Colors.black,
  //                       ),
  //
  //                     ),
  //                   );
  //                 }).toList(),
  //               ),
  //               // const Spacer(),
  //
  //               SizedBox(height: 50,),
  //               // Create Button
  //               SizedBox(
  //                 width: double.infinity,
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Colors.blue,
  //                     padding: const EdgeInsets.symmetric(vertical: 16),
  //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //                   ),
  //                   onPressed: () async {
  //                     final result = await controller.createCategory(
  //                       name: nameController.text.trim(),
  //                       description: descController.text.trim(),
  //                     );
  //
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(content: Text(result["message"])),
  //                     );
  //
  //                     if (result["success"]) Navigator.pop(context);
  //                   },
  //                   child: const Text(
  //                     "Create Category",
  //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }
