import 'dart:convert';
import 'package:expense_tracker/features/login/view/login_raf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../../core/localization/app_localization_controller.dart';
import '../../../core/theme/styles/styles.dart';
import '../../../shared/widgets/custom_widgets/app_elevated_button.dart';
import '../../../shared/widgets/styles/styles.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../../login/view/widget/custom_textfield.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email;

  const SetPasswordScreen({super.key, required this.email});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? passwordError;
  String? confirmPasswordError;
  late final localizationController = getLocalizationController(context, listen: false);


  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void validatePassword(String value) {
    final localizationController = getLocalizationController(context, listen: true);
    setState(() {
      if (value.isEmpty) {
        passwordError =  localizationController.getTextValue("PASSWORD_REQUIRED_ERROR");
      } else if (value.length < 6) {
        passwordError = localizationController.getTextValue("PASSWORD_MIN_LENGTH_ERROR");
      } else {
        passwordError = null;
      }

      // Re-check confirm password while typing
      if (_confirmPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text != value) {
        confirmPasswordError = localizationController.getTextValue("PASSWORD_MISMATCH_ERROR");
      } else {
        confirmPasswordError = null;
      }
    });
  }

  void validateConfirmPassword(String value) {
    setState(() {
      if (value.isEmpty) {
        confirmPasswordError = localizationController.getTextValue("CONFIRM_PASSWORD_REQUIRED_ERROR");
      } else if (value != _passwordController.text) {
        confirmPasswordError = localizationController.getTextValue("PASSWORD_MISMATCH_ERROR");
      } else {
        confirmPasswordError = null;
      }
    });
  }


  Future<void> submitNewPassword() async {
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(localizationController.getTextValue("ALL_FIELDS_REQUIRED_SNACKBAR"))),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(localizationController.getTextValue("PASSWORDS_DO_NOT_MATCH_SNACKBAR"))),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("https://z0vx5pwf-5000.inc1.devtunnels.ms/api/forgot-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": widget.email,
          "password": _passwordController.text.trim(),
        }),
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(localizationController.getTextValue("PASSWORD_UPDATED_SUCCESS"))),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(localizationController.getTextValue("PASSWORD_UPDATE_FAILED"))),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationController = getLocalizationController(context, listen: true);
    return Directionality(
      textDirection:
      AppLocalizationController.currentAppLanguage == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            ///  Background
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/img_login_background.svg',
                fit: BoxFit.cover,
              ),
            ),

            /// 🔝 App Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    children:  [
                      Icon(Icons.receipt_long,
                          color: Colors.white, size: 28),
                      SizedBox(width: 8),
                      Text(
                        localizationController.getTextValue("EXPENSO_TITLE"),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// 🧾 Bottom Container
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                Expanded(
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),

                              /// 🔐 Title
                              Padding(
                                padding:
                                 EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  localizationController.getTextValue("SET_NEW_PASSWORD_TITLE"),
                                  style: AppthemeData.headingStyle,
                                ),
                              ),

                              const SizedBox(height: 8),

                              /// 📄 Subtitle
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  localizationController.getTextValue("SET_NEW_PASSWORD_SUBTITLE"),
                                  style: AppthemeData.subheadingStyle
                                      .copyWith(fontSize: 13),
                                ),
                              ),

                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),

                              /// 📧 Email (Read-only)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      localizationController.getTextValue("EMAIL_LABEL"),
                                      style: AppthemeData.subheadingStyle.copyWith(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 56,
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/icn_mail.svg',
                                          width: 20,
                                          height: 20,
                                          colorFilter: ColorFilter.mode(
                                            Colors.grey.shade600,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            widget.email,
                                            style: AppthemeData.inputTextStyle.copyWith(
                                              color: Colors.grey.shade800,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),


                              const SizedBox(height: 20),

                              /// New Password
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      localizationController.getTextValue("NEW_PASSWORD_LABEL"),
                                      style: AppthemeData.subheadingStyle.copyWith(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: passwordError != null
                                            ? Colors.red
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _passwordController,
                                      onChanged: validatePassword,
                                      obscureText: obscurePassword,
                                      style: AppthemeData.inputTextStyle,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:  localizationController.getTextValue("NEW_PASSWORD_HINT"),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(14),
                                          child: Icon(
                                            Icons.lock_outline,
                                            size: 22,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() => obscurePassword = !obscurePassword);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (passwordError != null) ...[
                                    const SizedBox(height: 6),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        passwordError!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],


                                ],
                              ),



                              const SizedBox(height: 20),

                              ///  Confirm Password
                              /// 🔒 Confirm Password
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      localizationController.getTextValue("CONFIRM_PASSWORD_LABEL"),
                                      style: AppthemeData.subheadingStyle.copyWith(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: confirmPasswordError != null
                                            ? Colors.red
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _confirmPasswordController,
                                      onChanged: validateConfirmPassword, // 👈 LIVE VALIDATION
                                      obscureText: obscureConfirmPassword,
                                      style: AppthemeData.inputTextStyle,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:localizationController.getTextValue("CONFIRM_PASSWORD_HINT"),
                                        contentPadding:
                                        const EdgeInsets.symmetric(vertical: 18),
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(14),
                                          child: Icon(
                                            Icons.lock_outline,
                                            size: 22,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            obscureConfirmPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              obscureConfirmPassword =
                                              !obscureConfirmPassword;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// ❌ Error Message
                                  if (confirmPasswordError != null) ...[
                                    const SizedBox(height: 6),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        confirmPasswordError!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),




                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),

                              /// ✅ Submit Button
                              Row(
                                children: [
                                  Expanded(
                                    child: AppElevatedButton(
                                      label: isLoading
                                          ? localizationController.getTextValue("PLEASE_WAIT_LABEL")
                                          : localizationController.getTextValue("DONE_BUTTON_LABEL"),
                                      textStyle:
                                      AppthemeData.buttonStyle,
                                      onPressed: isLoading ||
                                          passwordError != null ||
                                          confirmPasswordError != null
                                          ? null
                                          : submitNewPassword,

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } 
}
