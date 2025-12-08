import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_profile.dart';
import '../model/settings_item.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../view/profile_screen.dart';

class SettingsController extends ChangeNotifier {
  bool notificationsEnabled = true;

  UserProfile? userProfile;
  bool isLoadingProfile = false;

  Future<bool> updateUserProfile(Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) {
      throw Exception("No auth token found");
    }

    final url = Uri.parse("https://z0vx5pwf-5000.inc1.devtunnels.ms/api/user");

    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );
    print("Update User Profile");
    print(body);

    print("PATCH STATUS → ${response.statusCode}");
    print("PATCH BODY → ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// Fetch User Profile from API
  Future<void> fetchUserProfile() async {
    try {
      isLoadingProfile = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");

      if (token == null) {
        print("⚠️ No token found in SharedPreferences");
        return;
      }

      final url = Uri.parse("https://z0vx5pwf-5000.inc1.devtunnels.ms/api/user");
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("profile response: ${response.body}");
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        userProfile = UserProfile.fromJson(jsonBody);
      }
    } catch (e) {
      debugPrint("Profile fetch error: $e");
    }

    isLoadingProfile = false;
    notifyListeners();
  }

  /// ---------------- PREFERENCES ----------------
  List<SettingsItem> getPreferences(BuildContext context) {
    final loc = getLocalizationController(context, listen: false);

    return [
      SettingsItem(
        title: loc.getTextValue("PRE_THEME"),
        subtitle: loc.getTextValue("PRE_THEME_SUBTITLE"),
        trailing: loc.getTextValue("PRE_THEME_TRAILING"),
        onTap: () {},
      ),
      SettingsItem(
        title: loc.getTextValue("PRE_CURRENCY"),
        subtitle: loc.getTextValue("PRE_CURRENCY_SUBTITLE"),
        trailing: userProfile?.currencyCode ?? "—",
        onTap: () {},
      ),
      SettingsItem(
        title: loc.getTextValue("PRE_LANGUAGE"),
        subtitle: loc.getTextValue("PRE_LANGUAGE_SUBTITLE"),
        trailing: userProfile?.preferredLanguage.toUpperCase() ?? "—",
        onTap: () {},
      ),
    ];
  }

  /// ---------------- ACCOUNT ----------------
  List<SettingsItem> getAccount(BuildContext context) {
    final loc = getLocalizationController(context, listen: false);

    return [
      SettingsItem(
        title: loc.getTextValue("PRE_PROFILE"),
        subtitle: userProfile != null
            ? "${userProfile!.firstName} ${userProfile!.lastName}"
            : null,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProfileScreen(user: userProfile),
            ),
          );
        },
      ),

      SettingsItem(title: loc.getTextValue("PRE_SECURITY"), onTap: () {}),
      SettingsItem(
        title: loc.getTextValue("PRE_NOTIFICATIONS"),
        isSwitch: true,
        switchValue: notificationsEnabled,
        onTap: () {},
      ),
      SettingsItem(
        title: loc.getTextValue("PRE_LOGOUT"),
        onTap: () {},
      ),
    ];
  }

  /// ---------------- PRIVACY ----------------
  List<SettingsItem> getPrivacy(BuildContext context) {
    final loc = getLocalizationController(context, listen: false);

    return [
      SettingsItem(title: loc.getTextValue("PRE_TERMS_OF_SERVICE"), onTap: () {}),
      SettingsItem(title: loc.getTextValue("PRE_PRIVACY_POLICY"), onTap: () {}),
      SettingsItem(title: loc.getTextValue("PRE_CONTACT_US"), onTap: () {}),
    ];
  }

  void toggleNotifications(bool value) {
    notificationsEnabled = value;
    notifyListeners();
  }
}


class CurrencyModel {
  final String code;
  final String name;
  final String symbol;

  CurrencyModel({required this.code, required this.name, required this.symbol});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      code: json["code"],
      name: json["name"],
      symbol: json["symbol"],
    );
  }
}

Future<List<CurrencyModel>> fetchCurrencies() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("access_token");

  final response = await http.get(
    Uri.parse("https://z0vx5pwf-5000.inc1.devtunnels.ms/api/currency"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );
  print("fetch currencies");
  print(response.statusCode);
  print(token);

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    List list = body["data"]["list"];
    return list.map((e) => CurrencyModel.fromJson(e)).toList();
  }

  throw Exception("Failed to load currencies");
}


// class SettingsController extends ChangeNotifier {
//   bool notificationsEnabled = true;
//
//   List<SettingsItem> get preferences => [
//     SettingsItem(
//       title: "Theme",
//       subtitle: "Customize the app’s appearance",
//       trailing: "System",
//       onTap: () {},
//     ),
//     SettingsItem(
//       title: "Currency",
//       subtitle: "Set your preferred currency",
//       trailing: "USD",
//       onTap: () {},
//     ),
//     SettingsItem(
//       title: "Language",
//       subtitle: "Choose your preferred language",
//       trailing: "English",
//       onTap: () {},
//     ),
//   ];
//
//   List<SettingsItem> get account => [
//     SettingsItem(title: "Profile", onTap: () {}),
//     SettingsItem(title: "Security", onTap: () {}),
//     SettingsItem(
//       title: "Notifications",
//       isSwitch: true,
//       switchValue: notificationsEnabled,
//       onTap: () {},
//     ),
//     SettingsItem(
//       title: "Logout",
//       onTap: () {
//         null;
//
//       },
//     ),
//   ];
//
//   List<SettingsItem> get privacy => [
//     SettingsItem(title: "Terms of Service", onTap: () {}),
//     SettingsItem(title: "Privacy Policy", onTap: () {}),
//     SettingsItem(title: "Contact Us", onTap: () {}),
//   ];
//
//   void toggleNotifications(bool value) {
//     notificationsEnabled = value;
//     notifyListeners();
//   }
// }
