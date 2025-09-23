import 'package:flutter/material.dart';

import '../model/settings_item.dart';

class SettingsController extends ChangeNotifier {
  bool notificationsEnabled = true;

  List<SettingsItem> get preferences => [
    SettingsItem(
      title: "Theme",
      subtitle: "Customize the app’s appearance",
      trailing: "System",
      onTap: () {},
    ),
    SettingsItem(
      title: "Currency",
      subtitle: "Set your preferred currency",
      trailing: "USD",
      onTap: () {},
    ),
    SettingsItem(
      title: "Language",
      subtitle: "Choose your preferred language",
      trailing: "English",
      onTap: () {},
    ),
  ];

  List<SettingsItem> get account => [
    SettingsItem(title: "Profile", onTap: () {}),
    SettingsItem(title: "Security", onTap: () {}),
    SettingsItem(
      title: "Notifications",
      isSwitch: true,
      switchValue: notificationsEnabled,
      onTap: () {},
    ),
    SettingsItem(
      title: "Logout",
      onTap: () {
        null;

      },
    ),
  ];

  List<SettingsItem> get privacy => [
    SettingsItem(title: "Terms of Service", onTap: () {}),
    SettingsItem(title: "Privacy Policy", onTap: () {}),
    SettingsItem(title: "Contact Us", onTap: () {}),
  ];

  void toggleNotifications(bool value) {
    notificationsEnabled = value;
    notifyListeners();
  }
}
