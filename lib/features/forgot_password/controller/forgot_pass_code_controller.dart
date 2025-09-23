import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../../core/localization/app_localization_controller.dart';
// import '../../../core/utils/helpers/make_http_request.dart';
// import '../../../widgets/custom_widgets/customized_snackbar.dart';
import '../../../core/utils/helpers/apiCalls/makeHttpRequest.dart';
import '../../../shared/widgets/custom_widgets/custom_snackbar.dart';
import '../controller/otp_timer_controller.dart';

class ForgotPassCodeController extends ChangeNotifier {
  static List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());
  final OtpTimerController timerController;

  bool isOtpComplete = false;
  bool isLoading = false;

  ForgotPassCodeController({required this.timerController}) {
    for (var controller in otpControllers) {
      controller.addListener(checkOtpCompletion);
    }
  }

  void clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    isOtpComplete = false;
    notifyListeners(); // Update the UI
  }

  // ForgotPassCodeController({required this.timerController});

  void handleOtpInput(int index, String value, BuildContext context) {
    if (value.isNotEmpty) {
      // Move focus to next field if value is entered
      if (index < otpFocusNodes.length - 1) {
        FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
      }
    } else {
      // Handle backspace behavior
      if (otpControllers[index].text.isEmpty && index > 0) {
        FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
      }
    }
    checkOtpCompletion();
    notifyListeners();
    // updateUI();
  }

  void checkOtpCompletion() {
    bool allFilled = otpControllers.every((controller) => controller.text.length == 1);
    if (isOtpComplete != allFilled) {
      isOtpComplete = allFilled;
      notifyListeners(); // Notify UI only when there's a state change
    }
  }

  void submitOtp() {
    String otp = otpControllers.map((e) => e.text).join();
    print("OTP Submitted: $otp");
  }

  Future<void> verifyOtp(BuildContext context, String email) async {
    String otp = otpControllers.map((e) => e.text).join();

    if (otp.length < 6) {
      SnackBarUtil.showSnackBar(AppLocalizationController().getTextValue("OTP_FIELD_ERROR"));
      return;
    }

    isLoading = true;
    notifyListeners();

    dynamic result = await MakeHttpRequest().makeHttpRequest(
      http.patch,
      '/otp',
      {
        "email": email,
        "purpose": "password_reset",
        "otp": otp,
      },
      (message) {
        SnackBarUtil.showSnackBar(message);
      },
    );

    isLoading = false;
    notifyListeners();
    print(result);

    // Check if OTP verification was successful
    if (result is Map && result['error'] == null) {
      for (var controller in otpControllers) {
        controller.clear();
      }
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/reset-password');
      }
    }
  }

  void updateUI() {
    notifyListeners(); // Refresh UI when focus changes
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    // timerController.dispose(); // If it's a ChangeNotifier, dispose it too
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
//
// class ForgotPassCodeController extends ChangeNotifier {
//   final List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());
//   List<FocusNode> otpFocusNodes = List.generate(4, (index) => FocusNode());
//
//   void handleOtpInput(int index, String value, BuildContext context) {
//     if (value.isNotEmpty && index < otpControllers.length - 1) {
//       FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
//     } else if (value.isEmpty && index > 0) {
//       FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
//     }
//   }
//
//   void submitOtp() {
//     // Implement OTP submission logic
//     print("OTP Submitted: ${otpControllers.map((e) => e.text).join()}");
//   }
//
//   void updateUI() {
//     notifyListeners(); // Refresh UI when focus changes
//   }
//
//   @override
//   void dispose() {
//     for (var controller in otpControllers) {
//       controller.dispose();
//     }
//     for (var node in otpFocusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }
// }
