import 'package:expense_tracker/shared/widgets/custom_widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login/view/login_raf_view.dart';
import '../controller/settings_controller.dart';
import '../model/settings_item.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Settings", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
      body: ListView(
        children: [
          _buildSection("Preferences", controller.preferences, controller,context),
          _buildSection("Account", controller.account, controller,context),
          _buildSection("Privacy", controller.privacy, controller,context),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 4,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
      //     BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Expense"),
      //     BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
      //     BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      //   ],
      // ),
    );
  }


  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          AppElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            label: "Cancel",
            backgroundColor: Colors.black,
          ),
          SizedBox(height: 10,),
          AppElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            label: 'Logout',
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token'); // clear token
      await prefs.clear(); // optional: clears all stored data

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User logged out successfully"),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildSection(String title, List<SettingsItem> items, SettingsController controller,BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: items.map((item) => _buildTile(item, controller,context)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(SettingsItem item, SettingsController controller,BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(item.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          subtitle: item.subtitle != null ? Text(item.subtitle!, style: const TextStyle(color: Colors.grey)) : null,
          trailing: item.isSwitch
              ? Switch(
            value: controller.notificationsEnabled,
            onChanged: (val) => controller.toggleNotifications(val),
          )
              : item.trailing != null
              ? Text(item.trailing!, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
              : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () {
            if (item.title == "Logout") {
              _handleLogout(context); // ✅ call logout here
            } else {
              item.onTap?.call();
            }
          },
        ),
        const Divider(height: 1),
      ],
    );
  }
}
