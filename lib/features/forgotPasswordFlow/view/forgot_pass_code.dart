import 'dart:convert';

import 'package:expense_tracker/shared/widgets/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/api_constants.dart';

import '../../../core/localization/app_localization_controller.dart';
import '../../../core/theme/styles/styles.dart';
import '../../../core/utils/helpers/apiCalls/makeHttpRequest.dart';
import '../../../shared/widgets/custom_widgets/app_elevated_button.dart';
import '../../../shared/widgets/custom_widgets/custom_snackbar.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../controller/forgot_pass_code_controller.dart';
import '../controller/otp_timer_controller.dart';
import 'package:http/http.dart' as http;

/// Function to get the ForgotPassCodeController instance
ForgotPassCodeController getForgotPassCodeController(BuildContext context, {bool listen = false}) {
  return Provider.of<ForgotPassCodeController>(context, listen: listen);
}

class ForgotPassCode extends StatefulWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final int otpValidityTime;
  const ForgotPassCode({super.key, required this.email, required this.firstName, required this.lastName, required this.password, required this.otpValidityTime});

  @override
  State<ForgotPassCode> createState() => _ForgotPassCodeState();
}

class _ForgotPassCodeState extends State<ForgotPassCode> {
  // static late OtpTimerController timerController;
  // late ForgotPassCodeController forgotPassCodeController;
  List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

   late TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    // forgotPassCodeController = ForgotPassCodeController(
    //   timerController: OtpTimerController(widget.otpValidityTime),
    // );

    controllers = List.generate(6, (_) => TextEditingController());


    // Explicitly start the timer with API-provided time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final timerController = Provider.of<OtpTimerController>(context, listen: false);
      timerController.restartTimer(widget.otpValidityTime);
    });

    print("widget.otpValidityTime");
    print(widget.otpValidityTime);

     otpController = TextEditingController();
    // timerController = OtpTimerController(widget.otpValidityTime);
  }                                       

  @override
  void dispose() {
    // forgotPassCodeController.dispose();
    // timerController.dispose();
      otpController.dispose();
    super.dispose();
  }



  Future<bool> sendSecurityCode(BuildContext context, String email, String purpose) async {
    if (email.isEmpty) return false;

    final controller = Provider.of<ForgotPassCodeController>(context, listen: false);
    final requestBody = {"email": email, "purpose": purpose};
    final url = Uri.parse("${ApiConstants.prodBaseUrl}/api/send-otp");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int otpValidityTime =
            int.tryParse(data['data']['otp_expiry_time'].toString()) ?? 5;
        otpValidityTime *= 60;

        // Store in controller
        controller.otpValidityTimeInSeconds = otpValidityTime;

        final message = data['message'] ?? "OTP sent successfully";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP")),
        );
        return false;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
      return false;
    }
  }


  void resendOtp() async {
    final controller = Provider.of<ForgotPassCodeController>(context, listen: false);
    controller.clearOtpFields();

    bool success = await sendSecurityCode(context, widget.email, "forgot_password");

    if (success) {
      final timerController = Provider.of<OtpTimerController>(context, listen: false);
      final otpValidityTimeInSeconds = controller.otpValidityTimeInSeconds ?? widget.otpValidityTime;
      timerController.restartTimer(otpValidityTimeInSeconds);

      // showSnackBar(context, "OTP sent successfully!");
    } else {
      showSnackBar(context, "Failed to resend OTP. Try again.");
    }
  }



  // void resendOtp() async {
  //   final controller = Provider.of<ForgotPassCodeController>(context, listen: false);//
  // // void resendOtp() async {
  //   // Clear OTP input fields//     final controller = Provider.of<ForgotPassCodeController>(context, listen: false);
  //   controller.clearOtpFields();//
  // //   // Clear OTP fields before resending OTP
  //   // Call the sendSecurityCode API//   // for (var controller in controllers) {
  //   bool success = await sendSecurityCode(context, widget.email, "forgot_password");//   // controllers = List.generate(6, (_) => TextEditingController());
  // //   // }
  //   if (success) {//
  //     // Retrieve the OtpTimerController//
  //     final timerController = Provider.of<OtpTimerController>(context, listen: false);//   ;
  // //   controller.clearOtpFields();
  //     // Reset timer with new OTP validity time//
  //     int otpValidityTimeInSeconds = controller.otpValidityTimeInSeconds ?? widget.otpValidityTime;//   // showDialog(
  //     timerController.restartTimer(otpValidityTimeInSeconds);//   //   context: context,
  // //   //   barrierDismissible: false,
  //     showSnackBar(context, "OTP sent successfully!");//   //   builder: (context) => const Center(
  //   } else {//   //     child: CircularProgressIndicator(color: AppThemeData.primaryBackground),
  //     showSnackBar(context, "Failed to resend OTP. Try again.");//   //   ),
  //   }//   // );
  // }

  //
  //   // Call API to resend OTP
  //   dynamic result = await MakeHttpRequest().makeHttpRequest(
  //     http.patch,
  //     '/forgot-password',
  //     {"email": widget.email},
  //     (message) {
  //       SnackBarUtil.showSnackBar(message);
  //     },
  //   );
  //
  //   // if (context.mounted) Navigator.pop(context); // Close loading dialog
  //
  //   if (result is Map && result['error'] == null) {
  //     var data = result['data'];
  //     if (data != null && data.containsKey('otp_expiry_time')) {
  //       int otpValidityTime = int.parse(data['otp_expiry_time']);
  //       otpValidityTime = otpValidityTime * 60;
  //       // int otpValidityTime = 1 * 60; // Convert minutes to seconds
  //       // final otp = result["data"]?["otp"];
  //       showSnackBar(context, "OTP sent successfully!");
  //       final timerController = Provider.of<OtpTimerController>(context, listen: false);
  //       timerController.restartTimer(otpValidityTime); // Restart timer with new value
  //     } else {
  //       SnackBarUtil.showSnackBar("Failed to get OTP validity time.");
  //     }
  //   } else {
  //     SnackBarUtil.showSnackBar("Failed to resend OTP. Try again.");
  //   }
  // }

  void showSnackBar(BuildContext context, String message) {
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizationController = getLocalizationController(context, listen: true);
    final controller = Provider.of<ForgotPassCodeController>(context, listen: true);
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Directionality(
      textDirection: AppLocalizationController.currentAppLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
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
                AnimatedPadding(
                  duration: const Duration(milliseconds: 300),
                  // padding: EdgeInsets.zero,
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: isKeyboardOpen
                        ? MediaQuery.of(context).size.height * 0.55
                        : MediaQuery.of(context).size.height * 0.80,
                    // height: MediaQuery.of(context).size.height * 0.70,
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
                            child: Text(localizationController.getTextValue("OTP_CONFIRM_LABEL"),
                                style: AppThemeData.headingStyle),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              localizationController.getTextValue("OTP_SUB_HEADER_LABEL"),
                              style: AppthemeData.subheadingStyle.copyWith(fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              widget.email,
                              style: AppthemeData.subheadingStyle.copyWith(
                                fontSize: 14,
                                color: AppthemeData.teritaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: KeyboardListener(
                                  focusNode: FocusNode(),
                                  onKeyEvent: (event) {
                                    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                                      if ( controller.otpControllers[index].text.isEmpty && index > 0) {
                                        // Move focus to the previous field on backspace if empty
                                        FocusScope.of(context).requestFocus(controller.otpFocusNodes[index - 1]);
                                      }
                                    }
                                  },
                                  child: Focus(
                                    onFocusChange: (hasFocus) {
                                      controller.updateUI();
                                    },
                                    child: TextField(
                                     controller: controller.otpControllers[index],
                                      focusNode: controller.otpFocusNodes[index],
                                      keyboardType: TextInputType.number,        
                                      textAlign: TextAlign.center,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      maxLength: 1,
                                      style: AppThemeData.headingStyle
                                          .copyWith(color: AppthemeData.teritaryColor, fontWeight: FontWeight.bold),
                                      // style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.otpFocusNodes[index].hasFocus
                                                ? AppthemeData.teritaryColor
                                                : Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppthemeData.teritaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 5) {
                                          // Move to the next field if user enters a digit
                                          FocusScope.of(context).requestFocus(controller.otpFocusNodes[index + 1]);
                                        } else if (value.isEmpty && index > 0) {
                                          // Move to the previous field if user clears a digit
                                          FocusScope.of(context).requestFocus(controller.otpFocusNodes[index - 1]);
                                        }
                                        controller.handleOtpInput(index, value, context);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.040),
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.012),
                            child: Consumer<OtpTimerController>(
                              builder: (context, timerController, child) {
                                return RichText(
                                  text: TextSpan(
                                    text: localizationController.getTextValue("OTP_WITHIN_LABEL"),
                                    style: const TextStyle(color: Colors.black, fontSize: 14),
                                    children: [
                                      TextSpan(
                                        text: timerController.timeRemaining, // Now correctly referenced
                                        style: const TextStyle(
                                            color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.012),
                            child: Text(
                              localizationController.getTextValue("DID_NT_RECEIVE_CODE"),
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          GestureDetector(
                            onTap: resendOtp,
                            child: Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.012),
                              child: Text(
                                localizationController.getTextValue("RESENT_OTP"),
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          Row(
                            children: [
                              Expanded(
                                child: AppElevatedButton(
                                  label: controller.isLoading
                                      ? localizationController.getTextValue("RESENT_VERIFYING")
                                      : localizationController.getTextValue("RESENT_VERIFY"),
                                  // label: "Verify",
                                  textStyle: AppthemeData.buttonStyle,
                                  // onPressed: controller.submitOtp,
                                  onPressed: controller.isOtpComplete && !controller.isLoading
                                      ? () async {
                                          FocusScope.of(context).unfocus();
                                          await controller.verifyOtp(context, widget.email, controller.otpControllers, widget);
                                        }
                                      : null,                        
                                ),
                              )
                            ],                                            
                          ),
                        ],
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
