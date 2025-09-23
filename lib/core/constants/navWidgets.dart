import 'package:flutter/material.dart';

import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/report/view/report_screen.dart';
import '../../features/settings/view/settings_screen.dart';
import '../../features/transactions/view/transaction_screen.dart';


class NavWidgets {
  static List<Widget> getNavWidgets(String userRole) {
    List<Widget> widgets = [
      DashboardScreen(),
      TransactionsScreen(),
      ReportsScreen(),
      SettingsScreen(),
      // const TransactionsWidget(),
      // const ChangeRequestWidget(),
      // const ProfileWidget(),
    ];
    if (userRole == 'shop_admin') {
      // widgets.insert(0, DashBoradWidget());
      // widgets.insert(
      //     1, const BillingCard()); // Insert Payments view for shop_admin
    }

    return widgets;
  }
}

// import 'package:flutter/material.dart';
//
// import '../../features/navigation_screens/view/nav_bar_bodies/change_req/change_request.dart';
// import '../../features/navigation_screens/view/nav_bar_bodies/dashboard/dashboard.dart';
// // import '../../features/navigation_screens/view/nav_bar_bodies/payments/payments.dart';
// import '../../features/navigation_screens/view/nav_bar_bodies/profile/profile.dart';
// import '../../features/navigation_screens/view/nav_bar_bodies/transactions/transactions.dart';
// import '../../features/payment/views/billing_and_payments.dart';
//
// class NavWidgets {
//   static const List<Widget> navwidgets = [
//     DashBoradWidget(),
//     BillingCard(),
//     // PaymentWidget(),
//     TransactionsWidget(),
//     ChangeRequestWidget(),
//     ProfileWidget()
//   ];
// }
