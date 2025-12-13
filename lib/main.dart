
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:expense_tracker/shared/connectivity_provider/connectivity_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/localization/app_localization_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
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
import 'features/forgotPasswordFlow/controller/reset_new_password_controller.dart';
import 'features/login/controller/login_controller.dart';
import 'features/login/controller/register_controller.dart';
import 'features/navigationScreens/controller/bottom_nav_provider.dart';
import 'features/navigationScreens/view/bottom_navigation_bar.dart';
import 'features/onboarding/view/welcome_view.dart';
import 'features/report/controller/report_controller.dart';
import 'features/settings/controller/currency_provider.dart';
import 'features/settings/controller/settings_controller.dart';
import 'features/transactions/controller/transaction_api_controller.dart';
import 'features/transactions/controller/transaction_controller.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  // runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final currencyProvider = CurrencyProvider();
  await currencyProvider.loadCurrency(); //  load saved value

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryController()),
        ChangeNotifierProvider(
            create: (_) => AccountController()..loadAccounts()),
        ChangeNotifierProvider(
          create: (_) => BudgetController(),
        ),
        ChangeNotifierProvider(create: (_) => currencyProvider),
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => TransactionsController()),
        ChangeNotifierProvider(create: (_) => TransactionApiController()),
        ChangeNotifierProvider(create: (_) => ReportsController()),
        ChangeNotifierProvider(create: (_) => ForgotPassEmailController()),
        ChangeNotifierProvider(create: (_) => AppLocalizationController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => RegisterController()),
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => SettingsController()),
        ChangeNotifierProvider(create: (_) => ResetPasswordController()),
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
        // ChangeNotifierProvider(create: (_) => CategoryController())

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
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      themeMode: themeController.isDarkTheme
          ? ThemeMode.dark
          : ThemeMode.light,
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
      // theme: ThemeData(
      //   textTheme: GoogleFonts.poppinsTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      // ),

    );
  }
}






// import 'package:expense_tracker/shared/connectivity_provider/connectivity_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'core/localization/app_localization_controller-ThetaZero-1.dart';
// import 'features/accounts/controller/account_controller.dart';
// import 'features/budgets/controller/budget_controller.dart';
// import 'features/categories/controller/category_controller.dart';
// import 'features/dashboard/controller/dashboard_controller.dart';
// import 'features/dashboard/controller/transaction_controller.dart';
// import 'features/dashboard/view/home_view.dart';
// import 'features/exportData/controller/export_controller.dart';
// import 'features/forgotPasswordFlow/controller/forgot_pass_code_controller.dart';
// import 'features/forgotPasswordFlow/controller/forgot_pass_email_controller.dart';
// import 'features/forgotPasswordFlow/controller/otp_timer_controller.dart';
// import 'features/login/controller/login_controller.dart';
// import 'features/login/controller/register_controller.dart';
// import 'features/navigationScreens/controller/bottom_nav_provider.dart';
// import 'features/report/controller/report_controller.dart';
// import 'features/settings/controller/settings_controller.dart';
// import 'features/transactions/controller/transaction_controller.dart';
//
// void main() {
//   // runApp(const MyApp());
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//             create: (_) => AccountController()..loadAccounts()),
//         ChangeNotifierProvider(
//           create: (_) => BudgetController(),
//         ),
//         ChangeNotifierProvider(
//           create: (_) => CategoryController(),
//           child: const MyApp(),
//         ),
//         ChangeNotifierProvider(create: (_) => TransactionsController()),
//         ChangeNotifierProvider(create: (_) => ReportsController()),
//         ChangeNotifierProvider(create: (_) => ForgotPassEmailController()),
//         ChangeNotifierProvider(create: (_) => AppLocalizationController()),
//         ChangeNotifierProvider(create: (context) => LoginController()),
//         ChangeNotifierProvider(create: (context) => RegisterController()),
//         ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
//         ChangeNotifierProvider(create: (context) => BottomNavProvider()),
//         ChangeNotifierProvider(create: (_) => DashboardController()),
//         ChangeNotifierProvider(create: (_) => SettingsController()),
//         ChangeNotifierProvider(create: (_) => ExportController()),
//         ChangeNotifierProvider(
//           create: (_) => OtpTimerController(60), // pass int here
//         ),
//         ChangeNotifierProxyProvider<OtpTimerController, ForgotPassCodeController>(
//           create: (context) => ForgotPassCodeController(
//             timerController: context.read<OtpTimerController>(),
//           ),
//           update: (context, otpTimer, prev) => ForgotPassCodeController(
//             timerController: otpTimer,
//           ),
//         ),
//
//       ],
//       child: const MyApp(),
//     ),
//
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final controller = TransactionController();
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: HomeView(controller: controller),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
