import 'dart:convert';

import 'package:expense_tracker/features/login/view/widget/custom_textfield.dart';
import 'package:expense_tracker/utils/devices/get_localization_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/utils/helpers/apiCalls/makeHttpRequest.dart';
import '../../../shared/widgets/custom_widgets/app_elevated_button.dart';
import '../../../shared/widgets/custom_widgets/page_transition.dart';
import '../../../shared/widgets/styles/styles.dart';

import '../../forgotPasswordFlow/view/forgot_pass_email.dart';
import '../../navigationScreens/controller/bottom_nav_provider.dart';
import '../../navigationScreens/view/bottom_navigation_bar.dart';
import '../../report/controller/report_controller.dart';
import '../../settings/controller/currency_provider.dart';
import '../controller/login_controller.dart';
import '../controller/register_controller.dart';

class LoginForm extends StatefulWidget {
  final String? id;
  final String? email;
  // final LoginController loginController;
  // final AppLocalizationController localizationController;

  const LoginForm({
    super.key,
    this.id,
    this.email,
    // required this.loginController,
    // required this.localizationController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = Provider.of<RegisterController>(
        context,
        listen: false,
      );
      controller.clearForm();
    });
  }
  Future<String?> setupFCM() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get token
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message: ${message.notification?.title}");
    });

    // When app is opened by tapping notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification opened: ${message.data}");
    });
    return token;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final loginController = Provider.of<LoginController>(context, listen: true);
    final localizationController = getLocalizationController(
      context,
      listen: true,
    );
    // final user = context.read<StartCreditController>().userModel;
    // final isEmailEditable = widget.email == null || widget.email!.isEmpty;
    //  print("email");
    //  print(widget.email);
    //  print("isEmailEditable");
    //  print(isEmailEditable);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        CustomTextField(
          labelText: localizationController.getTextValue("LOGIN_EMAIL"),
          controller: loginController.emailController,
          keyEmail: true,
          prefixIconAsset: 'assets/svg/svgcopy/icn_mail.svg',
          enable: !loginController.isLoading,
          allowSpaces: false,
          onChanged: (email) => loginController.validateEmail(email),
        ),
        if (loginController.emailError.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              loginController.emailError,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        const SizedBox(height: 20),
        Consumer<LoginController>(
          builder: (context, loginController, _) {
            return CustomTextField(
              labelText: localizationController.getTextValue("LOGIN_PASSWORD"),
              controller: loginController.passwordController,
              obscureText: loginController.isPasswordObscure,
              isPasswordField: true,
              enable: !loginController.isLoading,
              allowSpaces: false,
              prefixIconAsset: 'assets/icons/icn_password_lock.svg',
              onChanged: (password) =>
                  loginController.validatePassword(password),
              togglePasswordVisibility:
                  loginController.togglePasswordVisibility,
            );
          },
        ),
        if (loginController.passwordError.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              loginController.passwordError,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Row(
            //   children: [
            //     Checkbox(
            //       value: loginController.rememberMe,
            //       onChanged: (bool? newValue) {
            //         loginController.rememberMe = newValue ?? false;
            //       },
            //       activeColor: AppthemeData.circleColor,
            //       checkColor: Colors.white,
            //       side: const BorderSide(
            //         color: AppthemeData.primaryBackground,
            //         width: 2,
            //       ),
            //     ),
            //     Text(
            //       localizationController.getTextValue("LOGIN_REMEMBER"),
            //       style: AppthemeData.subheadingStyle,
            //     ),
            //   ],
            // ),
            Flexible(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ForgotPassEmail()),
                  );
                },
                child: Text(
                  localizationController.getTextValue("LOGIN_FORGOT_PASS"),
                  style: AppthemeData.subheadingStyle.copyWith(
                    color: AppthemeData.buttonColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: AppElevatedButton(
                label: loginController.isLoading
                    ? localizationController
                        .getTextValue("LOGIN_BUTTON_LOADING")
                    : localizationController.getTextValue("LOGIN_BUTTON"),
                textStyle: AppthemeData.buttonStyle,
                onPressed: (loginController.isFormValid &&
                        !loginController.isLoading)
                    ? () async {
                        FocusScope.of(context).unfocus();
                        loginController.isLoading = true;
                        loginController.notify();

                        try {
                          String? token = await setupFCM();
                          final response = await http.post(
                            Uri.parse(
                              '${ApiConstants.prodBaseUrl}/api/login',
                            ),
                            headers: {
                              "Content-Type": "application/json",
                            },
                            body: jsonEncode({
                              "email":
                                  loginController.emailController.text.trim(),
                              "password": loginController
                                  .passwordController.text
                                  .trim(),
                              "fcm_token":token
                            }),
                          );

                          debugPrint(
                              'LOGIN STATUS CODE: ${response.statusCode}');
                          debugPrint('LOGIN RESPONSE BODY: ${response.body}');

                          final result = jsonDecode(response.body);

                          if (response.statusCode == 200 &&
                              result['success'] == true) {
                            final accessToken =
                                result['data']['authDetails']['accessToken'];
                            final userDetails = result['data']['userDetails'];

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('access_token', accessToken);
                            await prefs.setString(
                                'user_email', userDetails['email']);
                            await prefs.setString(
                                'user_first_name', userDetails['first_name']);
                            await prefs.setString(
                                'user_last_name', userDetails['last_name']);
                            await prefs.setString(
                                'user_time_zone', userDetails['time_zone']);
                            await prefs.setString('user_language',
                                userDetails['preferred_language']);

                            final reportsController = Provider.of<ReportsController>(context, listen: false);
                            final currencyProvider = Provider.of<CurrencyProvider>(context, listen: false);
                            reportsController.reset();
                            currencyProvider.reset();

                            // Fetch fresh data
                            await reportsController.fetchDashboardData();
                            await currencyProvider.loadCurrency();

                            final bottomNavProvider = Provider.of<BottomNavProvider>(context, listen: false);
                            bottomNavProvider.setIndex(0); // Dashboard tab


                            if (context.mounted) {
                              Navigator.of(context).pushAndRemoveUntil(
                                PageTransition.buildPageRoute(
                                  NavigatioScreen(),
                                  type: TransitionType.slide,
                                ),(route)=>false
                              );
                            }
                          } else {
                            /// ✅ Extract API error message safely
                            String errorMessage = 'Login failed';

                            if (result['error'] != null &&
                                result['error']['message'] != null) {
                              errorMessage = result['error']['message'];
                            }

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMessage),
                                  backgroundColor: Colors.red.shade600,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(16),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        } catch (e, s) {
                          debugPrint('LOGIN ERROR: $e');
                          debugPrintStack(stackTrace: s);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    'Something went wrong. Please try again.'),
                                backgroundColor: Colors.red.shade600,
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(16),
                              ),
                            );
                          }
                        } finally {
                          loginController.isLoading = false;
                          loginController.notify();
                        }
                      }
                    : null,
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: AppElevatedButton(
        //         label: loginController.isLoading
        //             ? localizationController.getTextValue("LOGIN_BUTTON_LOADING")
        //             : localizationController.getTextValue("LOGIN_BUTTON"),
        //         textStyle: AppthemeData.buttonStyle,
        //         onPressed: (loginController.isFormValid && !loginController.isLoading)
        //             ? () async {
        //           FocusScope.of(context).unfocus();
        //           loginController.isLoading = true;
        //           loginController.notify(); // Refresh UI
        //
        //           try {
        //             // Call login API
        //             final response = await http.post(
        //               Uri.parse('https://z0vx5pwf-5000.inc1.devtunnels.ms/api/login'),
        //               headers: {"Content-Type": "application/json"},
        //               body: jsonEncode({
        //                 "email": loginController.emailController.text,
        //                 "password": loginController.passwordController.text,
        //               }),
        //             );
        //
        //             debugPrint('LOGIN STATUS CODE: ${response.statusCode}');
        //             debugPrint('LOGIN RESPONSE BODY: ${response.body}');
        //
        //             final result = jsonDecode(response.body);
        //
        //             debugPrint('LOGIN RESPONSE JSON: $result');
        //
        //             if (response.statusCode == 200 && result['success'] == true) {
        //               final accessToken = result['data']['authDetails']['accessToken'];
        //               final userDetails = result['data']['userDetails'];
        //
        //               // Save token and user details in SharedPreferences
        //               final prefs = await SharedPreferences.getInstance();
        //                 await prefs.setString('access_token', accessToken);
        //               await prefs.setString('user_email', userDetails['email']);
        //               await prefs.setString('user_first_name', userDetails['first_name']);
        //               await prefs.setString('user_last_name', userDetails['last_name']);
        //               await prefs.setString('user_time_zone', userDetails['time_zone']);
        //               await prefs.setString('user_language', userDetails['preferred_language']);
        //
        //               // Navigate to main screen
        //               if (context.mounted) {
        //                 Navigator.of(context).pushReplacement(
        //                   PageTransition.buildPageRoute(
        //                     NavigatioScreen(),
        //                     type: TransitionType.slide,
        //                   ),
        //                 );
        //               }
        //             } else {
        //               // Show error message
        //               if (context.mounted) {
        //                 ScaffoldMessenger.of(context).showSnackBar(
        //                   SnackBar(
        //                     content: Text(result['message'] ?? 'Login failed'),
        //                   ),
        //                 );
        //               }
        //             }
        //           } catch (e) {
        //             if (context.mounted) {
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                 SnackBar(content: Text('Error: $e')),
        //               );
        //             }
        //           } finally {
        //             loginController.isLoading = false;
        //             loginController.notify(); // Refresh UI
        //           }
        //         }
        //             : null,
        //       ),
        //     ),
        //   ],
        // )

        // Row(
        //   children: [
        //     Expanded(
        //       child: AppElevatedButton(
        //         label: loginController.isLoading
        //             ? localizationController.getTextValue(
        //           "LOGIN_BUTTON_LOADING",
        //         )
        //             : localizationController.getTextValue("LOGIN_BUTTON"),
        //         textStyle: AppthemeData.buttonStyle,
        //         onPressed: (){
        //           Navigator.of(context).push(
        //             PageTransition.buildPageRoute(
        //               NavigatioScreen(),// replace with your page
        //               // const LoginView(), // replace with your page
        //               type: TransitionType.slide, // fade / scale / rotate
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
