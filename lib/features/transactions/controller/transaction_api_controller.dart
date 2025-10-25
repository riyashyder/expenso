import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionApiController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Map<String, dynamic>> createTransaction({
    required String expenseDate,
    required String type,
    required String category,
    required double amount,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      if (token == null) throw Exception("Token not found");

      final url = Uri.parse('https://z0vx5pwf-5000.inc1.devtunnels.ms/api/expense');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "expenseDate": expenseDate,
          "type": type,
          "category": category,
          "amount": amount,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201 && data['success'] == true) {
        return {
          "success": true,
          "data": data['data'],
          "message": data['message']
        };
      } else {
        return {"success": false, "message": data['message'] ?? "Error"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ✅ NEW: Fetch all transactions
  Future<Map<String, dynamic>> fetchTransactions({
    required String from,
    required String to,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      if (token == null) throw Exception("Token not found");

      // Add from and to as query parameters
      final url = Uri.parse(
          'https://z0vx5pwf-5000.inc1.devtunnels.ms/api/expense?from=$from&to=$to');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("fetch transaction Api response");
      print(response.body);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        return {
          "success": true,
          "summary": data["data"]["summary"],
          "expenses": data["data"]["expenses"]
        };
      } else {
        return {"success": false, "message": data["message"] ?? "Fetch failed"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<Map<String, dynamic>> fetchTransactions() async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('access_token');
  //     if (token == null) throw Exception("Token not found");
  //
  //     final url = Uri.parse('https://z0vx5pwf-5000.inc1.devtunnels.ms/api/expense');
  //     final response = await http.get(url, headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     });
  //
  //     print("fetch transaction Api response");
  //     print(response.body);
  //     final data = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && data["success"] == true) {
  //       return {
  //         "success": true,
  //         "summary": data["data"]["summary"],
  //         "expenses": data["data"]["expenses"]
  //       };
  //     } else {
  //       return {"success": false, "message": data["message"] ?? "Fetch failed"};
  //     }
  //   } catch (e) {
  //     return {"success": false, "message": e.toString()};
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
