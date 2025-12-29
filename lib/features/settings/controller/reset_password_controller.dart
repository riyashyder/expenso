import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/api_constants.dart';

class ResetSettingsPasswordController extends ChangeNotifier {
  bool isLoading = false;

  Future<Map<String, dynamic>> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");

      debugPrint(" Reset Password API Call");
      debugPrint("Token: $token");
      debugPrint("Old: $oldPassword");
      debugPrint("New: $newPassword");

      final response = await http.post(
        Uri.parse(
          "${ApiConstants.prodBaseUrl}/api/reset-password",
        ),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "old_password": oldPassword,
          "new_password": newPassword,
        }),
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Raw Response: ${response.body}");

      final data = jsonDecode(response.body);

      isLoading = false;
      notifyListeners();

      ///  SUCCESS
      if (response.statusCode == 200 && data["success"] == true) {
        return {
          "success": true,
          "message": data["message"] ?? "Password updated successfully",
        };
      }

      ///  ERROR HANDLING (YOUR CASE)
      if (data["error"] != null) {
        return {
          "success": false,
          "message": data["error"]["message"] ?? "Something went wrong",
        };
      }

      /// FALLBACK
      return {
        "success": false,
        "message": "Failed to reset password",
      };
    } catch (e) {
      isLoading = false;
      notifyListeners();

      debugPrint("❌ Exception: $e");

      return {
        "success": false,
        "message": "Unexpected error occurred",
      };
    }
  }

// Future<Map<String, dynamic>> resetPassword({
  //   required String oldPassword,
  //   required String newPassword,
  // }) async {
  //   isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString("access_token");
  //
  //     final response = await http.post(
  //       Uri.parse("https://z0vx5pwf-5000.inc1.devtunnels.ms/api/reset-password"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         if (token != null) "Authorization": "Bearer $token",
  //       },
  //       body: jsonEncode({
  //         "old_password": oldPassword,
  //         "new_password": newPassword,
  //       }),
  //     );
  //
  //     final data = jsonDecode(response.body);
  //     print("Reset password");
  //     print(data);
  //
  //     isLoading = false;
  //     notifyListeners();
  //
  //     if (response.statusCode == 200) {
  //       return {
  //         "success": true,
  //         "message": data["message"] ?? "Password updated successfully",
  //       };
  //     } else {
  //       return {
  //         "success": false,
  //         "message": data["message"] ?? "Failed to reset password",
  //       };
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     return {
  //       "success": false,
  //       "message": e.toString(),
  //     };
  //   }
  // }
}
