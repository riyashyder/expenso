import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/api_constants.dart';

class DashboardApiService {
  static final String baseUrl = "${ApiConstants.prodBaseUrl}/api/dashboard";

  Future<Map<String, String>> _headers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token") ?? "";
    return {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
  }

  Future<Map<String, dynamic>> getCards(String from, String to) async {
    final url = Uri.parse("$baseUrl/cards?from=$from&to=$to");

    final res = await http.get(url, headers: await _headers());
    return jsonDecode(res.body);
  }

    Future<List<dynamic>> getCategoryChart(String from, String to, String type) async {
      final url = Uri.parse("$baseUrl/category-chart?from=$from&to=$to&type=$type");

      print("get category chart");
      print(type);

      final res = await http.get(url, headers: await _headers());
      final data = jsonDecode(res.body);
      return data["data"];
    }

  Future<List<dynamic>> getMonthlyChart(int year) async {
    final url = Uri.parse("$baseUrl/monthly-chart?year=$year");

    final res = await http.get(url, headers: await _headers());
    final data = jsonDecode(res.body);
    return data["data"];
  }
}
