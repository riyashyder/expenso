
import 'dart:convert';
import 'package:expense_tracker/core/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/create_category_model.dart';

class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? icon;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      icon: json["icon"],
    );
  }
}

class CategoryController with ChangeNotifier {
  // -------------------- STATE --------------------
  bool isLoading = false;

  int? selectedIconId;
  String? selectedType;

  List<CategoryModel> categories = [];

  // final String baseUrl =
  //     "https://z0vx5pwf-5000.inc1.devtunnels.ms/api/category";

  // -------------------- ICONS --------------------
  final List<CategoryIcon> icons = [
    CategoryIcon(id: 1, icon: Icons.directions_bus),
    CategoryIcon(id: 2, icon: Icons.movie),
    CategoryIcon(id: 3, icon: Icons.shopping_cart),
    CategoryIcon(id: 4, icon: Icons.receipt_long),
    CategoryIcon(id: 5, icon: Icons.brush),
    CategoryIcon(id: 6, icon: Icons.child_friendly),
  ];

  List<String> categoryTypes = ["Expense", "Income"];

  // -------------------- HELPERS --------------------
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void selectType(String type) {
    selectedType = type;
    notifyListeners();
  }

  void selectIcon(int id) {
    selectedIconId = id;
    notifyListeners();
  }

  IconData getIconById(String? iconId) {
    if (iconId == null) return Icons.category;

    final id = int.tryParse(iconId);
    if (id == null) return Icons.category;

    final matched = icons.firstWhere(
          (e) => e.id == id,
      orElse: () => CategoryIcon(id: 0, icon: Icons.category),
    );
    return matched.icon;
  }

  // -------------------- FETCH --------------------
  Future<void> getCategories() async {
    _setLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");
      if (token == null) {
        categories = [];
        return;
      }

      final response = await http.get(
        Uri.parse('${ApiConstants.prodBaseUrl}/api/category'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        categories = data.map((e) => CategoryModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
      categories = [];
    } finally {
      _setLoading(false);
    }
  }

  // -------------------- CREATE --------------------
  Future<Map<String, dynamic>> createCategory({
    required String name,
    String? description,
    String? type,
  }) async {
    _setLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");
      if (token == null) {
        return {"success": false, "message": "Authorization token not found"};
      }

      final response = await http.post(
        Uri.parse('${ApiConstants.prodBaseUrl}/api/category'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "type": (type ?? "expense").toLowerCase(),
          "description": description ?? "",
          "icon": selectedIconId,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        await getCategories();
        return {
          "success": true,
          "message": responseData["message"] ?? "Category created"
        };
      }

      return {
        "success": false,
        "message": responseData["message"] ?? "Failed to create category"
      };
    } catch (e) {
      return {"success": false, "message": e.toString()};
    } finally {
      _setLoading(false);
    }
  }

  // -------------------- UPDATE --------------------
  Future<Map<String, dynamic>> updateCategory({
    required String categoryId,
    String? name,
    String? description,
    int? icon,
  }) async {
    _setLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");
      if (token == null) {
        return {"success": false, "message": "Authorization token not found"};
      }

      final response = await http.patch(
        Uri.parse('${ApiConstants.prodBaseUrl}/api/category'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "category_id": categoryId,
          if (name != null) "name": name,
          if (description != null) "description": description,
          if (icon != null) "icon": icon,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await getCategories();
        return {
          "success": true,
          "message": responseData["message"] ?? "Category updated"
        };
      }

      return {
        "success": false,
        "message": responseData["message"] ?? "Failed to update"
      };
    } catch (e) {
      return {"success": false, "message": e.toString()};
    } finally {
      _setLoading(false);
    }
  }

  // -------------------- DELETE --------------------
  Future<Map<String, dynamic>> deleteCategory(String categoryId) async {
    _setLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");
      if (token == null) {
        return {"success": false, "message": "Authorization token not found"};
      }

      final response = await http.delete(
        Uri.parse("${'${ApiConstants.prodBaseUrl}/api/category'}/$categoryId"),
        headers: {"Authorization": "Bearer $token"},
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        categories.removeWhere((c) => c.id == categoryId);
        notifyListeners();
        return {
          "success": true,
          "message": responseData["message"] ?? "Category deleted"
        };
      }

      return {
        "success": false,
        "message": responseData["message"] ?? "Failed to delete"
      };
    } catch (e) {
      return {"success": false, "message": e.toString()};
    } finally {
      _setLoading(false);
    }
  }
}


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../model/create_category_model.dart';
//
// class CategoryModel {
//   final String id;
//   final String name;
//   final String? description;
//   final String? icon;
//
//   CategoryModel({required this.id, required this.name, this.description, this.icon});
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(
//       id: json["_id"],
//       name: json["name"],
//       description: json["description"],
//       icon: json["icon"],
//     );
//   }
// }
//
// class CategoryController with ChangeNotifier {
//   int? selectedIconId;
//   List<CategoryModel> categories = [];
//
//   final String baseUrl = "https://z0vx5pwf-5000.inc1.devtunnels.ms/api/category";
//
//   final List<CategoryIcon> icons = [
//     CategoryIcon(id: 1, icon: Icons.directions_bus),
//     CategoryIcon(id: 2, icon: Icons.movie),
//     CategoryIcon(id: 3, icon: Icons.shopping_cart),
//     CategoryIcon(id: 4, icon: Icons.receipt_long),
//     CategoryIcon(id: 5, icon: Icons.brush),
//     CategoryIcon(id: 6, icon: Icons.child_friendly),
//   ];
//
//   List<String> categoryTypes = ["Expense", "Income"];
//   String? selectedType;
//
//   void selectType(String type) {
//     selectedType = type;
//     notifyListeners();
//   }
//
//   void selectIcon(int id) {
//     selectedIconId = id;
//     notifyListeners();
//   }
//
//   IconData getIconById(String? iconId) {
//     if (iconId == null) return Icons.category; // default icon
//     final id = int.tryParse(iconId);
//     if (id == null) return Icons.category;
//     final matched = icons.firstWhere((element) => element.id == id, orElse: () => CategoryIcon(id: 0, icon: Icons.category));
//     return matched.icon;
//   }
//
//
//   // Fetch categories from API
//   Future<void> getCategories() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString("access_token");
//       if (token == null) return;
//
//       final response = await http.get(
//         Uri.parse(baseUrl),
//         headers: {"Authorization": "Bearer $token"},
//       );
//
//       print("get categories response");
//       print(response.body);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)["data"] as List;
//         categories = data.map((e) => CategoryModel.fromJson(e)).toList();
//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint("Error fetching categories: $e");
//     }
//   }
//
//   // Update category
//   Future<Map<String, dynamic>> updateCategory({
//     required String categoryId,
//     String? name,
//     String? description,
//     int? icon,
//   }) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString("access_token");
//       if (token == null) return {"success": false, "message": "Authorization token not found"};
//
//       final response = await http.patch(
//         Uri.parse(baseUrl),
//         headers: {
//           "Authorization": "Bearer $token",
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({
//           "category_id": categoryId,
//           if (name != null) "name": name,
//           if (description != null) "description": description,
//           if (icon != null) "icon": icon,
//         }),
//       );
//       final responseData = jsonDecode(response.body);
//
//
//       if (response.statusCode == 200) {
//         await getCategories();
//         return {"success": true, "message": responseData["message"] ?? "Category updated"};
//
//       }
//       return {"success": false, "message": responseData["message"] ?? "Failed to update"};
//     } catch (e) {
//       debugPrint("Error updating category: $e");
//       return {"success": false, "message": e.toString()};
//     }
//   }
//
//   // Delete category
//   Future<Map<String, dynamic>> deleteCategory(String categoryId) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString("access_token");
//       if (token == null) return {"success": false, "message": "Authorization token not found"};
//
//       final response = await http.delete(
//         Uri.parse("$baseUrl/$categoryId"),
//         headers: {"Authorization": "Bearer $token"},
//       );
//
//       final responseData = jsonDecode(response.body);
//
//       if (response.statusCode == 200) {
//         categories.removeWhere((c) => c.id == categoryId);
//         notifyListeners();
//         return {"success": true, "message": responseData["message"] ?? "Category deleted"};
//
//       }
//       return {"success": false, "message": responseData["message"] ?? "Failed to delete"};
//
//     } catch (e) {
//       return {"success": false, "message": e.toString()};
//     }
//   }
//
//   /// Create Category API Call
//   Future<Map<String, dynamic>> createCategory({
//     required String name,
//     String? description,
//     String? type,
//   }) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString("access_token");
//       if (token == null) return {"success": false, "message": "Authorization token not found"};
//
//       final response = await http.post(
//         Uri.parse(baseUrl),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode({
//           "name": name,
//           "type": (type ?? "expense").toLowerCase(),
//           "description": description ?? "",
//           "icon": selectedIconId,
//         }),
//       );
//       print("create category");
//       print(response.body);
//
//       final responseData = jsonDecode(response.body);
//       print("create response data");
//       print(responseData);
//
//       if (response.statusCode == 201) {
//         await getCategories(); // refresh list
//         return {"success": true, "message": responseData["message"] ?? "Category created"};
//       }
//       return {"success": false, "message": responseData["message"] ?? "Failed to create category"};
//     } catch (e) {
//       return {"success": false, "message": e.toString()};
//     }
//   }
// }
//


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../model/create_category_model.dart';
//
// class CategoryController with ChangeNotifier {
//   int? selectedIconId;
//
//   // API Base URL
//   final String baseUrl = "https://z0vx5pwf-5000.inc1.devtunnels.ms/api/category";
//
//   // Array of category icons
//   final List<CategoryIcon> icons = [
//     CategoryIcon(id: 1, icon: Icons.directions_bus),
//     CategoryIcon(id: 2, icon: Icons.movie),
//     CategoryIcon(id: 3, icon: Icons.shopping_cart),
//     CategoryIcon(id: 4, icon: Icons.receipt_long),
//     CategoryIcon(id: 5, icon: Icons.brush),
//     CategoryIcon(id: 6, icon: Icons.child_friendly),
//   ];
//
//   // final List<CategoryIcon> icons = [
//   //   CategoryIcon(id: 1, imagePath: "assets/icons/bus_icon.jpg"),
//   //   CategoryIcon(id: 2, imagePath: "assets/icons/entertainment_icon.jpg"),
//   //   CategoryIcon(id: 3, imagePath: "assets/icons/shopping_icon.jpg"),
//   //   CategoryIcon(id: 4, imagePath: "assets/icons/bills_icon.jpg"),
//   //   CategoryIcon(id: 5, imagePath: "assets/icons/beauty_icon.jpg"),
//   //   CategoryIcon(id: 6, imagePath: "assets/icons/baby_icon.jpg"),
//   // ];
//
//   void selectIcon(int id) {
//     selectedIconId = id;
//     notifyListeners();
//   }
//
//   /// Create Category API Call
//   Future<Map<String, dynamic>> createCategory({
//     required String name,
//     String? description,
//   }) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString("access_token"); // token saved earlier after login
//
//       if (token == null) {
//         return {"success": false, "message": "Authorization token not found"};
//       }
//
//       final response = await http.post(
//         Uri.parse(baseUrl),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode({
//           "name": name,
//           "description": description ?? "",
//           "icon": selectedIconId, // nullable, backend handles optional
//         }),
//       );
//
//       final responseData = jsonDecode(response.body);
//
//       if (response.statusCode == 201) {
//         return {
//           "success": true,
//           "message": responseData["message"] ?? "Category created",
//           "data": responseData["data"],
//         };
//       } else {
//         return {
//           "success": false,
//           "message": responseData["message"] ?? "Failed to create category",
//         };
//       }
//     } catch (e) {
//       return {"success": false, "message": e.toString()};
//     }
//   }
// }
//
//



// import 'package:flutter/material.dart';
  //
  // import '../model/create_category_model.dart';
  //
  // class CategoryController with ChangeNotifier {
  //   int? selectedIconId;
  //
  //   // Array of category icons
  //   final List<CategoryIcon> icons = [
  //     CategoryIcon(id: 1, imagePath: "assets/icons/bus_icon.jpg"),
  //     CategoryIcon(id: 2, imagePath: "assets/icons/entertainment_icon.jpg"),
  //     CategoryIcon(id: 3, imagePath: "assets/icons/shopping_icon.jpg"),
  //     CategoryIcon(id: 4, imagePath: "assets/icons/bills_icon.jpg"),
  //     CategoryIcon(id: 5, imagePath: "assets/icons/beauty_icon.jpg"),
  //     CategoryIcon(id: 6, imagePath: "assets/icons/baby_icon.jpg"),
  //     // CategoryIcon(id: 7, imagePath: "assets/icons/upload.png"),
  //   ];
  //
  //   void selectIcon(int id) {
  //     selectedIconId = id;
  //     notifyListeners();
  //   }
  // }
