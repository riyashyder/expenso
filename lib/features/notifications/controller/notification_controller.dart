import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/api_constants.dart';
import '../model/notification_model.dart';

class NotificationService {
  static final String baseUrl =
      "${ApiConstants.prodBaseUrl}/api/notification";

  static Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  /// LIST
  static Future<List<AppNotification>> fetchNotifications() async {
    final response = await http.get(
      Uri.parse('$baseUrl/list'),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List list = body['data']['notificationList'];
      return list.map((e) => AppNotification.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load notifications");
    }
  }

  /// MARK AS READ
  static Future<void> markAsRead(List<String> ids) async {
    await http.patch(
      Uri.parse('$baseUrl/read'),
      headers: await _headers(),
      body: jsonEncode({'notification_id': ids}),
    );
  }

  /// DELETE
  static Future<void> deleteNotification(List<String> ids) async {
    await http.delete(
      Uri.parse('$baseUrl/delete'),
      headers: await _headers(),
      body: jsonEncode({'notification_id': ids}),
    );
  }

  /// COUNT
  static Future<int> getUnreadCount() async {
    final response = await http.get(
      Uri.parse('$baseUrl/count'),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['data']['count'];
    }
    return 0;
  }
}
