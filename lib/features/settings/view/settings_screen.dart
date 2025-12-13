
import 'package:expense_tracker/shared/widgets/custom_widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/devices/get_localization_provider.dart';
import '../../login/view/login_raf_view.dart';
import '../controller/settings_controller.dart';
import '../model/settings_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<SettingsController>().fetchUserProfile();
    });
  }


  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();
    final localizationController = getLocalizationController(context, listen: false);



    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // _buildSection(
          //   localizationController.getTextValue("PREFERENCES") ?? "Preferences",
          //   controller.getPreferences(context),
          //   controller,
          //   context,
          // ),
          _buildSection(
            localizationController.getTextValue("ACCOUNT") ?? "Account",
            controller.getAccount(context),
            controller,
            context,
          ),
          _buildSection(
            localizationController.getTextValue("PRIVACY") ?? "Privacy",
            controller.getPrivacy(context),
            controller,
            context,
          ),
        ],
      ),
    );

  }

  /// LOGOUT CONFIRMATION DIALOG
  Future<void> _handleLogout(BuildContext context) async {
    final localizationController = getLocalizationController(context, listen: false);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizationController.getTextValue("CONFIRM_LOGOUT")),
        content: Text(localizationController.getTextValue("LOGOUT_MESSAGE")),
        actions: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: AppElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  label: localizationController.getTextValue("BTN_CANCEL_SETTINGS"),
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // small padding
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: AppElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  label: localizationController.getTextValue("BTN_LOGOUT_SETTING"),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                ),
              ),

            ],
          ),

          // AppElevatedButton(
          //
          //   onPressed: () => Navigator.of(context).pop(false),
          //   label: localizationController.getTextValue("BTN_CANCEL_SETTINGS"),
          //   backgroundColor: Colors.black,
          // ),

          // AppElevatedButton(
          //   onPressed: () => Navigator.of(context).pop(true),
          //   label: localizationController.getTextValue("BTN_LOGOUT_SETTING"),
          // ),
        ],
      ),
    );

    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizationController.getTextValue("LOGOUT_SUCCESS")),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// SECTION UI
  Widget _buildSection(
      String title,
      List<SettingsItem> items,
      SettingsController controller,
      BuildContext context,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SECTION TITLE
          Padding(
            padding: const EdgeInsets.only(left: 6, bottom: 8),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
                letterSpacing: 0.6,
              ),
            ),
          ),

          /// CARD
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: items
                  .map((item) => _buildTile(item, controller, context))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }


  /// EACH SETTING OPTION TILE
  Widget _buildTile(
      SettingsItem item,
      SettingsController controller,
      BuildContext context,
      ) {
    final localizationController =
    getLocalizationController(context, listen: false);

    final isLogout =
        item.title == localizationController.getTextValue("PRE_LOGOUT");

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (isLogout) {
          _handleLogout(context);
        } else {
          item.onTap?.call();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            /// TITLE + SUBTITLE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isLogout ? Colors.red : Colors.black,
                    ),
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ]
                ],
              ),
            ),

            /// TRAILING
            if (item.isSwitch)
              Switch(
                value: controller.notificationsEnabled,
                onChanged: controller.toggleNotifications,
              )
            else if (item.trailing != null)
              Text(
                item.trailing!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              )
            else
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey.shade400,
                size: 26,
              ),
          ],
        ),
      ),
    );
  }

}


// import 'package:expense_tracker/shared/widgets/custom_widgets/app_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../utils/devices/get_localization_provider.dart';
// import '../../login/view/login_raf_view.dart';
// import '../controller/settings_controller.dart';
// import '../model/settings_item.dart';
//
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final controller = context.watch<SettingsController>();
//     final localizationController = getLocalizationController(
//       context,
//       listen: false,
//     );
//
//
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("Settings", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//       //   centerTitle: true,
//       //   elevation: 0,
//       //   backgroundColor: Colors.white,
//       //   leading: IconButton(
//       //     icon: const Icon(Icons.arrow_back, color: Colors.black),
//       //     onPressed: () => Navigator.pop(context),
//       //   ),
//       // ),
//       body: ListView(
//         children: [
//           _buildSection(
//             localizationController.getTextValue("PREFERENCES"),
//             controller.getPreferences(localizationController),
//             controller,
//             context,
//           ),
//
//           _buildSection(
//             localizationController.getTextValue("ACCOUNT"),
//             controller.getAccount(localizationController),
//             controller,
//             context,
//           ),
//
//           _buildSection(
//             localizationController.getTextValue("PRIVACY"),
//             controller.getPrivacy(localizationController),
//             controller,
//             context,
//           ),
//
//         ],
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   currentIndex: 4,
//       //   type: BottomNavigationBarType.fixed,
//       //   selectedItemColor: Colors.blue,
//       //   unselectedItemColor: Colors.grey,
//       //   items: const [
//       //     BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
//       //     BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Expense"),
//       //     BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
//       //     BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
//       //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//       //   ],
//       // ),
//     );
//   }
//
//   Future<void> _handleLogout(BuildContext context) async {
//     final localizationController = getLocalizationController(
//       context,
//       listen: false,
//     );
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title:  Text(localizationController.getTextValue(
//           "CONFIRM_LOGOUT",
//         )),
//         content:  Text(localizationController.getTextValue(
//           "LOGOUT_MESSAGE",
//         )),
//         actions: [
//           AppElevatedButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             label: localizationController.getTextValue(
//               "BTN_CANCEL_SETTINGS",
//             ),
//             backgroundColor: Colors.black,
//           ),
//           SizedBox(height: 10,),
//           AppElevatedButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             label: localizationController.getTextValue(
//               "BTN_LOGOUT_SETTING",
//             ),
//           ),
//         ],
//       ),
//     );
//
//     if (confirmed == true) {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.remove('access_token'); // clear token
//       await prefs.clear(); // optional: clears all stored data
//
//       if (context.mounted) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => const LoginPage()),
//         );
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//          SnackBar(
//           content: Text(localizationController.getTextValue(
//             "LOGOUT_SUCCESS",
//           )),
//           backgroundColor: Colors.black,
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
//
//   Widget _buildSection(String title, List<SettingsItem> items, SettingsController controller,BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//             child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           ),
//           Container(
//             color: Colors.white,
//             child: Column(
//               children: items.map((item) => _buildTile(item, controller,context)).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTile(SettingsItem item, SettingsController controller,BuildContext context) {
//     final localizationController = getLocalizationController(
//       context,
//       listen: false,
//     );
//     return Column(
//       children: [
//         ListTile(
//           title: Text(item.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
//           subtitle: item.subtitle != null ? Text(item.subtitle!, style: const TextStyle(color: Colors.grey)) : null,
//           trailing: item.isSwitch
//               ? Switch(
//             value: controller.notificationsEnabled,
//             onChanged: (val) => controller.toggleNotifications(val),
//           )
//               : item.trailing != null
//               ? Text(item.trailing!, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
//               : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
//           onTap: () {
//             if (item.title == localizationController.getTextValue(
//               "BTN_LOGOUT_SETTING",
//             )) {
//               _handleLogout(context); // ✅ call logout here
//             } else {
//               item.onTap?.call();
//             }
//           },
//         ),
//         const Divider(height: 1),
//       ],
//     );
//   }
// }
