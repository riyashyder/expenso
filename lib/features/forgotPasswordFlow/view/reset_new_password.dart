import 'package:expense_tracker/shared/widgets/custom_widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/app_localization_controller.dart';
import '../../../core/theme/styles/styles.dart';
import '../../../shared/widgets/styles/styles.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../../login/view/widget/custom_textfield.dart';
import '../controller/reset_new_password_controller.dart';

class ResetNewPassword extends StatelessWidget {
  const ResetNewPassword({super.key});

  @override
  Widget build(BuildContext context) {

    final localizationController = getLocalizationController(context, listen: true);
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;



    return ChangeNotifierProvider(
     create: (_) => ResetPasswordController(),
       child: Consumer<ResetPasswordController>(
        builder:(context, resetController, child) {
          return Directionality(
            textDirection: AppLocalizationController.currentAppLanguage == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
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
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: SvgPicture.asset(
                                  'assets/icons/icn_goback.svg',
                                  width: MediaQuery.of(context).size.width * 0.042,
                                  height: MediaQuery.of(context).size.height * 0.042,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SvgPicture.asset(
                                'assets/images/raffle_logo.svg',
                                width: MediaQuery.of(context).size.width * 0.03,
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Spacer(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height:  isKeyboardOpen
                          ? MediaQuery.of(context).size.height * 0.90
                  : MediaQuery.of(context).size.height * 0.85,
                        // height: MediaQuery.of(context).size.height * 0.85,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(localizationController.getTextValue("RESET_PASSWORD_HEADER"), style: AppThemeData.headingStyle),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  localizationController.getTextValue("RESET_PASSWORD_SUB_HEADER"),
                                  style: AppthemeData.subheadingStyle.copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                              // Password Field
                              CustomTextField(
                                allowSpaces: false,
                                isPasswordField: true,
                                labelText: localizationController.getTextValue("PASSWORD_LABEL"),
                                controller: resetController.passwordController,
                                obscureText: resetController.isPasswordObscure,
                                prefixIconAsset: 'assets/icons/icn_password_lock.svg',
                                onChanged: resetController.validatePassword,
                                togglePasswordVisibility: resetController.togglePasswordVisibility,
                              ),
                              if (resetController.passwordError.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text(
                                    resetController.passwordError,
                                    style: const TextStyle(color: Colors.red, fontSize: 12),
                                  ),
                                ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                              // Confirm Password Field
                              CustomTextField(
                                allowSpaces: false,
                                isPasswordField: true,
                                labelText: localizationController.getTextValue("CONFIRM_PASSWORD_LABEL"),
                                controller: resetController.confirmPasswordController,
                                obscureText: resetController.isConfirmPasswordObscure,
                                prefixIconAsset: 'assets/icons/icn_password_lock.svg',
                                onChanged: resetController.validateConfirmPassword,
                                togglePasswordVisibility: resetController.toggleConfirmPasswordVisibility,
                              ),
                              if (resetController.confirmPasswordError.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text(
                                    resetController.confirmPasswordError,
                                    style: const TextStyle(color: Colors.red, fontSize: 12),
                                  ),
                                ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                              Row(
                                children: [
                                  Expanded(
                                    child: Consumer<ResetPasswordController>(
                                      builder: (context, resetController, child) {
                                        return AppElevatedButton(
                                          label: resetController.isLoading ? localizationController.getTextValue("CONFIRM_PASSWORD_SUBMITTING") : localizationController.getTextValue("CONFIRM_PASSWORD_SUBMIT"),
                                          textStyle: AppthemeData.buttonStyle,
                                          onPressed: resetController.isFormValid && !resetController.isLoading
                                              ? () => resetController.submitPasswordChange(context)
                                              : null,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: AppElevatedButton(
                              //         label: "Submit",
                              //         textStyle: AppThemeData.buttonStyle,
                              //         onPressed: resetController.isFormValid
                              //             ? () async {
                              //           final forgotPassEmailController =
                              //           Provider.of<ForgotPassEmailController>(context, listen: false);
                              //           // Make API call to update the password
                              //           dynamic result = await MakeHttpRequest().makeHttpRequest(
                              //             http.patch,
                              //             '${ApiConstants.userManagementBaseURL}/update-password',
                              //             {
                              //               "email": forgotPassEmailController.emailController.text.trim(),
                              //               "password": resetController.passwordController.text,
                              //               "is_forgot_password": true,
                              //               "is_set_password": false,
                              //             },
                              //                 (message) {
                              //               SnackBarUtil.showSnackBar(context, message);
                              //             },
                              //           );
                              //
                              //           print(result);
                              //
                              //           // Check if password update was successful
                              //           if (result is Map && result['error'] == null) {
                              //             // Navigate to ResetSuccessful screen if the API call is successful
                              //             if (context.mounted) {
                              //               Navigator.pushReplacement(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                   builder: (context) => const ResetSuccessful(),
                              //                 ),
                              //               );
                              //             }
                              //           }
                              //         }
                              //             : null,
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: AppElevatedButton(
                              //         label: "Submit",
                              //         textStyle: AppThemeData.buttonStyle,
                              //         // onPressed: controller.submitOtp,
                              //         onPressed: resetController.isFormValid
                              //             ? (){
                              //           Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) => const ResetSuccessful(),
                              //             ),
                              //           );
                              //         } : null,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
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
           ),
     );
  }
}
