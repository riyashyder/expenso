  import 'package:expense_tracker/shared/widgets/custom_widgets/custom_textfield.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';


  import '../../../core/utils/validators/common_validators-ThetaZero-1.dart';
import '../../../core/utils/validators/common_validators.dart';
  import '../../../shared/widgets/custom_widgets/app_elevated_button.dart';
  import '../../../shared/widgets/styles/styles.dart';
  import '../../../utils/devices/get_localization_provider.dart';
  import '../../forgotPasswordFlow/view/forgot_pass_code.dart';
  import '../../forgotPasswordFlow/controller/otp_timer_controller.dart';
import '../controller/login_controller.dart';
  import '../controller/register_controller.dart';

  class RegisterForm extends StatefulWidget {
    final String? number;
    final void Function()? onOtpSent;
    const RegisterForm({
      super.key,
      this.number,
      this.onOtpSent,
    });

    @override
    State<RegisterForm> createState() => _RegisterFormState();
  }

  class _RegisterFormState extends State<RegisterForm> {
    final formKey = GlobalKey<FormState>();
    final confirmPasswordKey = GlobalKey<FormFieldState>(); // ✅ add this

    @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final controller = Provider.of<LoginController>(context, listen: false);
        controller.clear();



        final registerController = Provider.of<RegisterController>(
          context,
          listen: false,
        );

        registerController.passwordController.addListener(() {
          confirmPasswordKey.currentState?.validate(); // ✅ re-run confirm validator
        });

        registerController.passwordController.addListener(() {
          if (formKey.currentState != null) {
            formKey.currentState!.validate();
          }
        });

        // When confirm password changes, revalidate password too (optional)
        registerController.confirmPasswordController.addListener(() {
          if (formKey.currentState != null) {
            formKey.currentState!.validate();
          }
        });
        registerController.clearAll();
        registerController.mobileController.text =
            (widget.number ?? '').replaceFirst('+94 ', '');
        // print("Mobile number set: ${registerController.mobileController.text}");
        registerController.countryController.text = "Sri Lanka";
        registerController.countryCode = "+94";
        registerController.countryIso = "LK";
      });
    }

    @override
    Widget build(BuildContext context) {
      final registerController = context.watch<RegisterController>();



      // final screenWidth = MediaQuery.of(context).size.width;
      final bottomInset = MediaQuery.of(context).viewInsets.bottom;
      final localizationController = getLocalizationController(
        context,
        listen: false,
      );
      final validators = Rvalidators();
      return Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: "First Name",
                      controller: registerController.fullNameController,
                      enabled: !registerController.isLoading,
                      svgname: 'assets/svg/svgcopy/name.svg',
                      allowOnlyAlphabets: true,
                      onchange: (value) =>
                          registerController.checkFormCompletion(),
                      validator: (value) {
                        final text = value?.trim() ?? "";
                        if (text.isEmpty) {
                          return "First name is required";
                        }
                        if (text.length < 3) {
                          return localizationController.getTextValue(
                            "MIN_3_CHAR",
                          );
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      label: localizationController.getTextValue("LAST_NAME"),
                      controller: registerController.lastNameController,
                      enabled: !registerController.isLoading,
                      svgname: 'assets/svg/svgcopy/name.svg',
                      allowOnlyAlphabets: true,
                      onchange: (email) =>
                          registerController.checkFormCompletion(),
                      validator: (value) {
                        final text = value?.trim() ?? "";
                        if (text.isEmpty) {
                          return localizationController.getTextValue(
                            "LAST_NAME_REQUIRED",
                          );
                        }
                        if (text.length < 3) {
                          return localizationController.getTextValue(
                            "MIN_3_CHAR",
                          );
                        }
                        return null;
                      },
                    ),
                    // CustomTextField(
                    //   label: localizationController.getTextValue("COUNTRY"),
                    //   controller: registerController.countryController,
                    //   svgname: 'assets/svg/country.svg',
                    //   isFileUpload: true,
                    //   onchange: (email) =>
                    //       registerController.checkFormCompletion(),
                    //   validator: (value) {
                    //     if (value.trim().isEmpty) {
                    //       return localizationController.getTextValue(
                    //         "SHOP_NAME_REQUIRED",
                    //       );
                    //     }
                    //     if (value.trim().length < 3) {
                    //       return localizationController.getTextValue(
                    //         "SHOP_NAME_MIN_LENGTH",
                    //       );
                    //     }
                    //     return null;
                    //   },
                    // ),
                    CustomTextField(
                      label: localizationController.getTextValue("LOGIN_EMAIL"),
                      controller: registerController.emailController,
                      svgname: 'assets/svg/svgcopy/icn_mail copy.svg',
                      enabled: !registerController.isLoading,
                      isEmail: true,
                      keyboardType: TextInputType.emailAddress,
                      onchange: (email) =>
                          registerController.checkFormCompletion(),
                      validator: (value) {
                        final email = value?.trim() ?? "";
                        if (email.isEmpty) {
                          return localizationController.getTextValue(
                            "EMAIL_REQUIRED",
                          );
                        } else if (!validators.isValidEmail(email)) {
                          return localizationController.getTextValue(
                            "INVALID_EMAIL",
                          );
                        }
                        return null;
                      },
                    ),
                    // Password field
                    CustomTextField(
                      label: localizationController.getTextValue("LOGIN_PASSWORD"),
                      controller: registerController.passwordController,
                      enabled: !registerController.isLoading,
                      hide: true,
                      showEyeIcon: true,
                      isEmail: false,
                      svgname: 'assets/svg/svgcopy/icn_password_lock copy.svg',
                      onchange: (_) {
                        registerController.checkFormCompletion();
                        formKey.currentState?.validate(); // ✅ triggers confirm field validation too
                      },
                      validator: (value) {
                        final password = value?.trim() ?? "";

                        if (password.isEmpty) {
                          return 'Password not to be empty';
                        }

                        final regex = RegExp(
                          r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
                        );

                        if (!regex.hasMatch(password)) {
                          return 'Password must be at least 8 characters,\ninclude 1 uppercase letter, 1 number & 1 special character.';
                        }

                        return null; // ✅ only password rules here
                      },
                    ),

// Confirm Password field
                    CustomTextField(
                      key: confirmPasswordKey,
                      label: localizationController.getTextValue("CONFIRM_PASSWORD_LABEL"),
                      controller: registerController.confirmPasswordController,
                      hide: true,
                      showEyeIcon: true,
                      isEmail: false,
                      enabled: !registerController.isLoading,
                      svgname: 'assets/svg/svgcopy/icn_password_lock copy.svg',
                      onchange: (_) {
                        registerController.checkFormCompletion();
                        formKey.currentState?.validate(); // ✅ triggers password validation too
                      },
                      validator: (value) {
                        final confirm = value?.trim() ?? "";
                        final original = registerController.passwordController.text.trim();

                        if (confirm.isEmpty) {
                          return localizationController.getTextValue("CONFIRM_PASSWORD");
                        }
                        if (confirm != original) {
                          return localizationController.getTextValue("PASSWORD_NOT_MATCH");
                        }

                        return null;
                      },
                    ),

                    // CustomTextField(
                    //   label: localizationController.getTextValue(
                    //     "LOGIN_PASSWORD",
                    //   ),
                    //   controller: registerController.passwordController,
                    //   enabled: !registerController.isLoading,
                    //   hide: true,
                    //   showEyeIcon: true,
                    //   isEmail: false,
                    //   svgname: 'assets/svg/icn_password_lock copy.svg',
                    //   onchange: (password) {
                    //     registerController.checkFormCompletion();
                    //     formKey.currentState?.validate(); // 🔑 revalidate confirm password
                    //   },
                    //   validator: (value) {
                    //     final password = value.trim();
                    //
                    //     if (password.isEmpty) {
                    //       return localizationController.getTextValue(
                    //         "PASSWORD_REQUIRED",
                    //       );
                    //     }
                    //
                    //     // Regex for the required pattern
                    //     final regex = RegExp(
                    //       r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
                    //     );
                    //
                    //     if (!regex.hasMatch(password)) {
                    //       return 'Password must be at least 8 characters,\ninclude 1 uppercase letter, 1 number & 1 special character.';
                    //     }
                    //
                    //     return null;
                    //   },
                    // ),
                    // CustomTextField(
                    //   label: localizationController.getTextValue(
                    //     "CONFIRM_PASSWORD_LABEL",
                    //   ),
                    //   controller: registerController.confirmPasswordController,
                    //   hide: true,
                    //   showEyeIcon: true,
                    //   isEmail: true,
                    //   enabled: !registerController.isLoading,
                    //   svgname: 'assets/svg/icn_password_lock copy.svg',
                    //   onchange: (_) => formKey.currentState?.validate(),
                    //   // onchange: (password) =>
                    //   //     registerController.checkFormCompletion(),
                    //   validator: (value) {
                    //     final confirm = value.trim();
                    //     final original =
                    //     registerController.passwordController.text.trim();
                    //
                    //     if (confirm.isEmpty) {
                    //       return localizationController.getTextValue(
                    //         "CONFIRM_PASSWORD",
                    //       );
                    //     }
                    //     if (confirm != original) {
                    //       return localizationController.getTextValue(
                    //         "PASSWORD_NOT_MATCH",
                    //       );
                    //     }
                    //
                    //     return null;
                    //   },
                    // ),
                    // CustomTextField(
                    //   label: "National ID",
                    //   controller: registerController.emiratesController,
                    //   keyboardType: TextInputType.text,
                    //   allowOnlyNumber: false,
                    //   enabled: !registerController.isLoading,
                    //   onchange: (val) => registerController.checkFormCompletion(),
                    //   validator: (value) {
                    //     final trimmedValue = value.trim();
                    //
                    //     if (trimmedValue.isEmpty) {
                    //       return "National ID is required";
                    //     }
                    //
                    //     // Passport/NIC validation
                    //     final pattern = RegExp(r'^(\d{9}[vVxX]|\d{12})$');
                    //     if (!pattern.hasMatch(trimmedValue)) {
                    //       return "Invalid National ID";
                    //     }
                    //
                    //     return null;
                    //   },
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: AppElevatedButton(
                            label: registerController.isLoading
                                ? localizationController.getTextValue(
                              "LOGIN_BUTTON_LOADING",
                            )
                                : localizationController.getTextValue(
                              "REGISTER",
                            ),
                            textStyle: AppthemeData.buttonStyle,
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) return; // ✅ validate form
                              registerController.isLoading = true;
                              final bool result = await registerController.sendSecurityCode(
                                context,
                                registerController.emailController.text.trim(),
                                "REGISTER",
                              );
                              registerController.isLoading = false;


                              // if (result) {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ChangeNotifierProvider<OtpTimerController>(
                              //         create: (_) => OtpTimerController(widget.otpValidityTime),
                              //         child: ForgotPassCode(
                              //           email: registerController.emailController.text,
                              //           password: registerController.passwordController.text,
                              //           firstName: registerController.fullNameController.text,
                              //           lastName: registerController.lastNameController.text,
                              //           otpValidityTime: registerController.otpValidityTimeInSeconds ?? 60,
                              //         ),
                              //       ),
                              //     ),
                              //   );
                              //
                              //   // Navigator.push(
                              //   //   context,
                              //   //   MaterialPageRoute(
                              //   //     builder: (context) => ForgotPassCode(
                              //   //       email: registerController.emailController.text,
                              //   //       password: registerController.passwordController.text,
                              //   //       firstName: registerController.fullNameController.text,
                              //   //       lastName: registerController.lastNameController.text,
                              //   //       otpValidityTime:
                              //   //       registerController.otpValidityTimeInSeconds ?? 60,
                              //   //     ),
                              //   //   ),
                              //   // );
                              // }

                              if (result) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangeNotifierProvider<OtpTimerController>(
                                      create: (_) => OtpTimerController(
                                        registerController.otpValidityTimeInSeconds ?? 180, // ✅ use controller value
                                      ),
                                      child: ForgotPassCode(
                                        email: registerController.emailController.text,
                                        password: registerController.passwordController.text,
                                        firstName: registerController.fullNameController.text,
                                        lastName: registerController.lastNameController.text,
                                        otpValidityTime: registerController.otpValidityTimeInSeconds ?? 180, // pass same
                                      ),
                                    ),
                                  ),
                                );

                              }

                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Failed to send OTP")),
                                );
                              }
                            },

                            // onPressed: registerController.isFormValid
                            //     ? () async {
                            //   registerController.isLoading = true;
                            //  // await registerController.registerUser(context);
                            //   // registerController.clearAll();
                            //   final bool result = await registerController.sendSecurityCode(
                            //      context,
                            //     registerController.emailController.text.trim(),
                            //     "REGISTER",
                            //   );
                            //
                            //   registerController.isLoading = false;
                            //
                            //   // print("register result");
                            //   // print(result);
                            //   if (result) {
                            //     // print("OTP sent successfully");
                            //     // registerController.clickVisible = true;
                            //      Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => ForgotPassCode(email: registerController.emailController.text,password:registerController.passwordController.text,firstName: registerController.fullNameController.text,lastName: registerController.lastNameController.text, otpValidityTime: registerController.otpValidityTimeInSeconds ?? 60,),
                            //         // builder: (context) => OTPForm(
                            //         //   email: (widget.number?.isNotEmpty ??
                            //         //       false)
                            //         //       ? registerController
                            //         //       .emailController.text
                            //         //       .trim()
                            //         //       : null,
                            //         //   registerController:
                            //         //   registerController,
                            //         //   localizationController:
                            //         //   localizationController,
                            //         // ),
                            //       ),
                            //     );
                            //   } else {
                            //     // print("Failed to send OTP");
                            //   }
                            // }
                            //     : null, // Reset loading state
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
