import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/main_appbar.dart';
import '../../../core/constants/navWidgets.dart';
import '../../../core/localization/app_localization_controller.dart';
import '../../../core/theme/styles/styles.dart';
import '../../../shared/connectivity_provider/connectivity_provider.dart';
import '../../../shared/connectivity_provider/no_connectivity_screen.dart';
import '../../../shared/widgets/styles/styles.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../controller/bottom_nav_provider.dart';

class NavigatioScreen extends StatefulWidget {
  const NavigatioScreen({super.key});

  @override
  State<NavigatioScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigatioScreen> {
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => userRole = prefs.getString('role') ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    final localizationController =
    getLocalizationController(context, listen: true);

    return Consumer<ConnectivityProvider>(
      builder: (context, value, child) {
        if (!value.isConnected) return NoConnectivityScreen();

        return PopScope(
          canPop: bottomNavProvider.canPOP(),
          onPopInvokedWithResult: (didPop, result) async =>
              bottomNavProvider.goBack(),
          child: Directionality(
            textDirection:
            AppLocalizationController.currentAppLanguage == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(100),
                  child: MainAppBar()),

              body: NavWidgets.getNavWidgets(userRole)[bottomNavProvider.selectedIndex],

              // -------------------------
              //  FLOATING BUBBLE NAV BAR
              // -------------------------
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      // Strong bottom lift shadow
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 30,
                        spreadRadius: 2,
                        offset: Offset(0, 10),
                      ),

                      // Softer surrounding glow
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navItem(
                        icon: Icons.dashboard,
                        label: localizationController.getTextValue("DASHBOARD_NAV_LABEL"),
                        index: 0,
                        isActive: bottomNavProvider.selectedIndex == 0,
                        onTap: () => bottomNavProvider.setIndex(0),
                      ),
                      _navItem(
                        icon: Icons.swap_horiz,
                        label: localizationController.getTextValue("TRANSACTIONS_NAV_LABEL"),
                        index: 1,
                        isActive: bottomNavProvider.selectedIndex == 1,
                        onTap: () => bottomNavProvider.setIndex(1),
                      ),
                      _navItem(
                        icon: Icons.monetization_on_sharp,
                        label:  localizationController.getTextValue("CATEGORY_NAV_LABEL"),
                        index: 2,
                        isActive: bottomNavProvider.selectedIndex == 2,
                        onTap: () => bottomNavProvider.setIndex(2),
                      ),
                      _navItem(
                        icon: Icons.settings,
                        label: localizationController.getTextValue("SETTINGS_NAV_LABEL"),
                        index: 3,
                        isActive: bottomNavProvider.selectedIndex == 3,
                        onTap: () => bottomNavProvider.setIndex(3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ------------------------------------------------------
//  BUBBLE FLOATING NAV ITEM (animated pill like your demo)
// ------------------------------------------------------
Widget _navItem({
  required IconData icon,
  required String label,
  required int index,
  required bool isActive,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.symmetric(horizontal: isActive ? 18 : 0, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppthemeData.buttonColor : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: isActive ? 28 : 24,
            color: isActive ? Colors.white : Colors.black54,
          ),
          if (isActive) ...[
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          ]
        ],
      ),
    ),
  );
}
