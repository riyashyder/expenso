import 'package:expense_tracker/routes/app_routes.dart';
import 'package:expense_tracker/shared/connectivity_provider/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/localization/app_localization_controller.dart';
import 'features/accounts/controller/account_controller.dart';
import 'features/budgets/controller/budget_controller.dart';
import 'features/categories/controller/category_controller.dart';
import 'features/dashboard/controller/dashboard_controller.dart';
import 'features/dashboard/controller/transaction_controller.dart';
import 'features/dashboard/view/home_view.dart';
import 'features/exportData/controller/export_controller.dart';
import 'features/forgotPasswordFlow/controller/forgot_pass_code_controller.dart';
import 'features/forgotPasswordFlow/controller/forgot_pass_email_controller.dart';
import 'features/forgotPasswordFlow/controller/otp_timer_controller.dart';
import 'features/login/controller/login_controller.dart';
import 'features/login/controller/register_controller.dart';
import 'features/navigationScreens/controller/bottom_nav_provider.dart';
import 'features/navigationScreens/view/bottom_navigation_bar.dart';
import 'features/onboarding/view/welcome_view.dart';
import 'features/report/controller/report_controller.dart';
import 'features/settings/controller/settings_controller.dart';
import 'features/transactions/controller/transaction_controller.dart';

void main() {
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AccountController()..loadAccounts()),
        ChangeNotifierProvider(
          create: (_) => BudgetController(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryController(),
          child: const MyApp(),
        ),
        ChangeNotifierProvider(create: (_) => TransactionsController()),
        ChangeNotifierProvider(create: (_) => ReportsController()),
        ChangeNotifierProvider(create: (_) => ForgotPassEmailController()),
        ChangeNotifierProvider(create: (_) => AppLocalizationController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => RegisterController()),
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => SettingsController()),
        ChangeNotifierProvider(create: (_) => ExportController()),
        ChangeNotifierProvider(
          create: (_) => OtpTimerController(60), // pass int here
        ),
        ChangeNotifierProxyProvider<OtpTimerController, ForgotPassCodeController>(
          create: (context) => ForgotPassCodeController(
            timerController: context.read<OtpTimerController>(),
          ),
          update: (context, otpTimer, prev) => ForgotPassCodeController(
            timerController: otpTimer,
          ),
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: AppRoutes.splash,
      routes: {
        // AppRoutes.dashboard: (context) => const DashboardScreen(),
        AppRoutes.splash: (context)=> WelcomeView(),


          // '/': (context) =>  BillingCard(),
          // '/': (context) =>  AdjustmentTableScroll(),
          // '/': (context) =>  AdjustmentHistory(),
          // '/': (context) => const SplashScreen(),
          // '/login': (context) => const LoginPage(),
          '/dashboard': (context) => const NavigatioScreen(),
          // '/billingPayments': (context) => const BillingCard(),
          // '/reset-password': (context) => const ResetNewPassword(),


      },
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

    );
  }
}
