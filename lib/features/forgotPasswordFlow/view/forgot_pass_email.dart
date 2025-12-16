import 'dart:convert';

import 'package:expense_tracker/features/forgotPasswordFlow/controller/forgot_pass_code_controller.dart';
import 'package:expense_tracker/features/forgotPasswordFlow/view/forgot_password_code_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/api_constants.dart';

import '../../../core/localization/app_localization_controller.dart';

import '../../../core/theme/styles/styles.dart';
import '../../../core/utils/helpers/apiCalls/makeHttpRequest.dart';
import '../../../shared/widgets/custom_widgets/app_elevated_button.dart';
import '../../../shared/widgets/custom_widgets/custom_snackbar.dart';

import '../../../shared/widgets/styles/styles.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../../login/view/widget/custom_textfield.dart';
import '../controller/forgot_pass_email_controller.dart';
import 'package:http/http.dart' as http;

import '../controller/otp_time_controller_register.dart';
import 'forgot_pass_code.dart';

class ForgotPassEmail extends StatelessWidget {
  const ForgotPassEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPassController = Provider.of<ForgotPassEmailController>(context, listen: true);
    final localizationController = getLocalizationController(context, listen: true);
    // final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Directionality(
      textDirection: AppLocalizationController.currentAppLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            forgotPassController.emailController.clear();
            forgotPassController.emailError = '';
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/img_login_background.svg',
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      Row(
                        children:  [
                          Icon(Icons.receipt_long, color: AppThemeData.whiteColor,size: 28),
                          SizedBox(width: 8),
                          Text(
                            localizationController.getTextValue("EXPENSO_APP_HEADER"),
                            style: TextStyle(
                              fontSize: 20,
                              color: AppThemeData.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () => Navigator.pop(context),
                      //       child: SvgPicture.asset(
                      //         'assets/icons/icn_goback.svg',
                      //         width: MediaQuery.of(context).size.width * 0.042,
                      //         height: MediaQuery.of(context).size.height * 0.042,
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     SvgPicture.asset(
                      //       'assets/images/raffle_logo.svg',
                      //       width: MediaQuery.of(context).size.width * 0.03,
                      //       height: MediaQuery.of(context).size.height * 0.03,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                  Expanded(
                    child: AnimatedPadding(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    localizationController.getTextValue("FORGOT_PASS"),
                                    style: AppthemeData.headingStyle,
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    localizationController.getTextValue("FORGOT_PASS_SUB_HEADER"),
                                    style: AppthemeData.subheadingStyle.copyWith(fontSize: 13),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                                CustomTextField(
                                  allowSpaces: false,
                                  labelText: localizationController.getTextValue("FORGOT_PASSWORD_LABEL"),
                                  controller: forgotPassController.emailController,
                                  prefixIconAsset: 'assets/icons/icn_mail.svg',
                                  keyEmail: true,
                                  onChanged: (email) {
                                    forgotPassController.validateEmail(email);
                                  },
                                ),
                                if (forgotPassController.emailError.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 5),
                                    child: Text(
                                      forgotPassController.emailError,
                                      style: const TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                                // Continue Button
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppElevatedButton(
                                        label: forgotPassController.isLoading
                                            ? localizationController.getTextValue("LOADING_LABEL")
                                            : localizationController.getTextValue("CONTINUE_LABEL"),
                                        // label: "Continue",
                                        textStyle: AppthemeData.buttonStyle,

                                        onPressed: forgotPassController.isEmailValid &&
                                            !forgotPassController.isLoading
                                            ? () async {
                                          FocusScope.of(context).unfocus();
                                          forgotPassController.setLoading(true);

                                          try {
                                            final response = await http.post(
                                              Uri.parse("https://z0vx5pwf-5000.inc1.devtunnels.ms/api/send-otp"),
                                              headers: {
                                                "Content-Type": "application/json",
                                              },
                                              body: jsonEncode({
                                                "email":
                                                forgotPassController.emailController.text.trim(),
                                                "purpose": "FORGOT_PASSWORD",
                                              }),
                                            );

                                            debugPrint("STATUS CODE => ${response.statusCode}");
                                            debugPrint("BODY => ${response.body}");

                                            final data = jsonDecode(response.body);

                                            if (response.statusCode == 200 && data["success"] == true) {
                                              int otpValidityTime =
                                                  data["data"]["otp_expiry_time"] * 60; // convert to seconds

                                              if (!context.mounted) return;

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => MultiProvider(
                                                    providers: [
                                                      ChangeNotifierProvider(
                                                        create: (_) => OtpTimerController(otpValidityTime),
                                                      ),
                                                      ChangeNotifierProvider(
                                                        create: (_) => ForgotPassCodeController(),
                                                      ),
                                                    ],
                                                    child: ForgotPassCodeRegister(
                                                      email: forgotPassController.emailController.text.trim(),
                                                      firstName: "",
                                                      lastName: "",
                                                      password: "",
                                                      otpValidityTime: otpValidityTime,
                                                    ),
                                                  ),
                                                ),
                                              );

                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (_) => ForgotPassCodeRegister(
                                              //       email: forgotPassController.emailController.text.trim(),
                                              //       firstName: "",     // pass if you have
                                              //       lastName: "",      // pass if you have
                                              //       password: "",      // pass if you have
                                              //       otpValidityTime: otpValidityTime,
                                              //     ),
                                              //   ),
                                              // );
                                            }
                                            else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    data["message"] ?? "Failed to send OTP",
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            debugPrint("SEND OTP ERROR => $e");
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("Something went wrong"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }

                                          forgotPassController.setLoading(false);
                                        }
                                            : null,

                                        // onPressed: forgotPassController.isEmailValid && !forgotPassController.isLoading
                                        //     ? () async {
                                        //         FocusScope.of(context).unfocus();
                                        //
                                        //         forgotPassController.setLoading(true); // Start loading
                                        //
                                        //         // API Request
                                        //         dynamic result = await MakeHttpRequest().makeHttpRequest(
                                        //           http.patch,
                                        //           '/forgot-password',
                                        //           {"email": forgotPassController.emailController.text.trim()},
                                        //           (message) {
                                        //             SnackBarUtil.showSnackBar(message);
                                        //           },
                                        //         );
                                        //
                                        //         print(result);
                                        //
                                        //         // Check if result is a valid response and contains the necessary data
                                        //         if (result is Map && result['error'] == null) {
                                        //           var data = result['data'];
                                        //
                                        //           if (data != null &&
                                        //               data.containsKey('otp_expiry_time')) {
                                        //             int otpValidityTime =
                                        //                 int.parse(data['otp_expiry_time']);
                                        //             otpValidityTime = otpValidityTime * 60;
                                        //             // final otp = result["data"]?["otp"];
                                        //             showSnackBar(
                                        //               context,
                                        //               "OTP sent successfully!",
                                        //             );
                                        //             if (context.mounted) {
                                        //               // await Navigator.push(
                                        //               //   context,
                                        //               //   MaterialPageRoute(
                                        //               //     builder: (context) => ForgotPassCode(
                                        //               //       email: forgotPassController.emailController.text.trim(),
                                        //               //       otpValidityTime: otpValidityTime, // Pass valid OTP time
                                        //               //     ),
                                        //               //   ),
                                        //               // );
                                        //
                                        //               print("otpValidityTime email");
                                        //               print(otpValidityTime);
                                        //             }
                                        //           } else {
                                        //             // Handle missing key case
                                        //             if (context.mounted) {
                                        //               SnackBarUtil.showSnackBar(
                                        //                   localizationController.getTextValue("MISSING_OTP_TIME"));
                                        //             }
                                        //           }
                                        //         }
                                        //         forgotPassController.setLoading(false);
                                        //       }
                                        //     : null,
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
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  Future.delayed(Duration.zero, () {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  });
}
