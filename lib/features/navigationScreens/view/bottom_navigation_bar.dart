import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/image_strings.dart';
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
  String userRole = ''; // Store user role

  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   Provider.of<Alertcontroller>(context, listen: false).getNotificationCount();
    // });
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('role') ?? ''; // Default to empty
    });
  }

  @override
  Widget build(BuildContext context) {
    // final profilePictureController =
    //     Provider.of<ProfilePictureController>(context);
    // final selectedProfile = profilePictureController.profilePicture;

    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    final localizationController = getLocalizationController(context, listen: true);
    final scaffoldkey = GlobalKey<ScaffoldState>();

    // ignore: deprecated_member_use
    return Consumer<ConnectivityProvider>(
      builder: (context, value, child) {
        if (value.isConnected) {
          return PopScope(
            canPop: bottomNavProvider.canPOP(),
            onPopInvokedWithResult: (didPop, result) async => bottomNavProvider.goBack(),
            child: Directionality(
              textDirection:
              AppLocalizationController.currentAppLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: Scaffold(
                key: scaffoldkey,
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,

                // Appbar
                appBar: const PreferredSize(preferredSize: Size.fromHeight(100), child: MainAppBar()),

                body: NavWidgets.getNavWidgets(userRole)[bottomNavProvider.selectedIndex],

                // Bottom navigation bar
                bottomNavigationBar: BottomNavigationBar(
                    onTap: (value) {
                      if (value >= NavWidgets.getNavWidgets(userRole).length) return; // Prevent index out of bounds
                      bottomNavProvider.setIndex(value);
                    },
                    currentIndex: bottomNavProvider.selectedIndex,
                    iconSize: 20,
                    selectedFontSize: 10,
                    unselectedFontSize: 10,
                    selectedItemColor: AppthemeData.buttonColor,
                    unselectedItemColor: Colors.black,
                    items: [

                      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
                      BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: "Transactions"),
                      BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
                      BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
                      // // Dashboard Icon
                      //   BottomNavigationBarItem(
                      //     icon: SvgPicture.asset(ImageandLogos.dashboradoutline),
                      //     activeIcon: SvgPicture.asset(ImageandLogos.dashboradblue),
                      //     label: localizationController.getTextValue("BOTTOM_NAV_OPT_ONE"),
                      //   ),
                      // // Payments Icon
                      //   BottomNavigationBarItem(
                      //     icon: SvgPicture.asset(ImageandLogos.paymentsoutline),
                      //     activeIcon: SvgPicture.asset(ImageandLogos.paymentsblue),
                      //     label: localizationController.getTextValue("BOTTOM_NAV_OPT_TWO"),
                      //   ),
                      // // Transactions Icon
                      // BottomNavigationBarItem(
                      //   icon: SvgPicture.asset(ImageandLogos.transactionoutline),
                      //   activeIcon: SvgPicture.asset(ImageandLogos.transactionblue),
                      //   label: localizationController.getTextValue("BOTTOM_NAV_OPT_THREE"),
                      // ),
                      // // Change Request Icon
                      // BottomNavigationBarItem(
                      //   icon: SvgPicture.asset(ImageandLogos.changreqoutline),
                      //   activeIcon: SvgPicture.asset(ImageandLogos.changereqblue),
                      //   label: localizationController.getTextValue("BOTTOM_NAV_OPT_FOUR"),
                      // ),
                      // // Profile Icon
                      // BottomNavigationBarItem(
                      //   icon: SvgPicture.asset(
                      //     ImageandLogos.settingout,
                      //     width: 20,
                      //     height: 20,
                      //   ),
                      //   activeIcon: SvgPicture.asset(
                      //     ImageandLogos.settingb,
                      //     width: 20,
                      //     height: 20,
                      //   ),
                      //   label: localizationController.getTextValue("SETTINGS"),
                      // )
                    ]),
              ),
            ),
          );
        } else {
          return NoConnectivityScreen();
        }
      },
    );
  }
}
