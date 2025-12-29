import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../../core/localization/app_localization_controller.dart';

import '../../../core/utils/helpers/apiCalls/makeHttpRequest.dart';
import '../../../shared/widgets/custom_widgets/custom_snackbar.dart';
import '../../../shared/widgets/custom_widgets/page_transition.dart';
import '../../login/controller/register_controller.dart';
import '../../login/view/login_raf_view.dart';
import '../../login/view/login_view.dart';
import '../controller/otp_timer_controller.dart';
import '../view/set_password_screen.dart';

class ForgotPassCodeController extends ChangeNotifier {
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes =
  List.generate(6, (_) => FocusNode());

  final OtpTimerController? timerController;

  bool isOtpComplete = false;
  bool isLoading = false;
  int? otpValidityTimeInSeconds;

  ForgotPassCodeController({this.timerController}) {
    for (var controller in otpControllers) {
      controller.addListener(checkOtpCompletion);
    }
  }

  void clearOtpFields() {
    for (var c in otpControllers) {
      c.clear();
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

  // Inside ForgotPassCodeController
  void showSnackBar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> verifyOtpRegister(
      BuildContext context,
      String email,
      List<TextEditingController> otpControllers,
      dynamic widget,
      ) async {
    String otp = otpControllers.map((e) => e.text).join();

    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizationController().getTextValue("OTP_FIELD_ERROR"),
          ),
        ),
      );
      return;
    }

    try {
      final response = await http.post(

        Uri.parse('${ApiConstants.prodBaseUrl}/api/verify-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "purpose": "FORGOT_PASSWORD",
          "otp": otp,
        }),
      );

      print("forgot password response");
      print(response.body);

      final result = jsonDecode(response.body);

      // ✅ SUCCESS
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          result['success'] == true) {

        if (context.mounted) {
          for (var controller in otpControllers) {
            controller.clear();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? "OTP verified successfully"),
              backgroundColor: Colors.black,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => SetPasswordScreen(email: email),
            ),
          );
        }
      }
      // ❌ ERROR FROM API (INVALID OTP, EXPIRED OTP, ETC)
      else {
        final errorMessage =
            result['error']?['message'] ?? "Failed to verify OTP";

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.black,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An error occurred: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Future<void> verifyOtpRegister(
  //     BuildContext context,
  //     String email,
  //     List<TextEditingController> otpControllers,
  //     dynamic widget,
  //     ) async {
  //   String otp = otpControllers.map((e) => e.text).join();
  //
  //   if (otp.length < 6) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(AppLocalizationController().getTextValue("OTP_FIELD_ERROR"))),
  //     );
  //     return;
  //   }
  //
  //   bool isLoading = true;
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://z0vx5pwf-5000.inc1.devtunnels.ms/api/verify-otp'),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "email": email,
  //         "purpose": "FORGOT_PASSWORD",
  //         "otp": otp,
  //       }),
  //     );
  //
  //     isLoading = false;
  //
  //     print("forgot password response");
  //     print(response.body);
  //
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   final result = jsonDecode(response.body);
  //     //
  //     //   if (true) {
  //     //     // Clear OTP fields
  //     //     for (var controller in otpControllers) {
  //     //       controller.clear();
  //     //     }
  //     //
  //     //     if (context.mounted) {
  //     //
  //     //       final message = result['message'] ?? "OTP verified successfully!";
  //     //       ScaffoldMessenger.of(context).showSnackBar(
  //     //         SnackBar(content: Text(message)),
  //     //       );
  //     //       // ScaffoldMessenger.of(context).showSnackBar(
  //     //       //   const SnackBar(content: Text("OTP verified successfully!")),
  //     //       // );
  //     //
  //     //       // Call register API
  //     //     }
  //     //   }
  //     // }
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final result = jsonDecode(response.body);
  //
  //       if (context.mounted) {
  //         // Clear OTP fields
  //         for (var controller in otpControllers) {
  //           controller.clear();
  //         }
  //
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text(result['message'] ?? "OTP verified successfully")),
  //         );
  //
  //         //  NAVIGATE TO SET PASSWORD SCREEN995121
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => SetPasswordScreen(
  //               email: email, //  PASS EMAIL HERE
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //
  //
  //     else {
  //       if (context.mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("Failed to verify OTP. Try again.")),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("An error occurred: $e")),
  //       );
  //     }
  //   }
  // }

  Future<void> verifyOtp(
      BuildContext context,
      String email,
      List<TextEditingController> otpControllers,
      dynamic widget,
      ) async {
    String otp = otpControllers.map((e) => e.text).join();

    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizationController().getTextValue("OTP_FIELD_ERROR"))),
      );
      return;
    }

    bool isLoading = true;

    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.prodBaseUrl}/api/verify-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "purpose": "REGISTER",
          "otp": otp,
        }),
      );

      isLoading = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);

        if (true) {
          // Clear OTP fields
          for (var controller in otpControllers) {
            controller.clear();
          }

          if (context.mounted) {

            final message = result['message'] ?? "OTP verified successfully!";
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text("OTP verified successfully!")),
            // );

            // Call register API
            final registerResponse = await http.post(
              Uri.parse('${ApiConstants.prodBaseUrl}/api/register'),
              headers: {"Content-Type": "application/json"},
              body: jsonEncode({
                "first_name": widget.firstName,
                "last_name": widget.lastName,
                "email": widget.email,
                "password": widget.password,
              }),
            );

            if (registerResponse.statusCode == 201 || registerResponse.statusCode == 200) {
              final message = result['message'] ?? "Register successfully!";
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(message)),
              );

              Navigator.of(context).pushReplacement(
                PageTransition.buildPageRoute(
                  const LoginPage(), // your target page
                  type: TransitionType.slide,
                ),
              );
            }
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result['error'].toString())),
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to verify OTP. Try again.")),
          );
        }
      }
    } catch (e) {
      isLoading = false;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
      }
    }
  }



//final
  // Future<void> verifyOtp(BuildContext context, String email, List<TextEditingController> otpControllers,dynamic widget) async {
  //   String otp = otpControllers.map((e) => e.text).join();
  //
  //   if (otp.length < 6) {
  //     showSnackBar(context,AppLocalizationController().getTextValue("OTP_FIELD_ERROR"));
  //     return;
  //   }
  //
  //   bool isLoading = true;
  //   // You can notifyListeners if this is inside a ChangeNotifier
  //   // notifyListeners();
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://z0vx5pwf-5000.inc1.devtunnels.ms/api/verify-otp'),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "email": email,
  //         "purpose": "REGISTER",
  //         "otp": otp,
  //       }),
  //     );
  //
  //     isLoading = false;
  //     // notifyListeners();
  //
  //     if (response.statusCode == 200) {
  //       final result = jsonDecode(response.body);
  //
  //       if (result['error'] == null) {
  //         // Clear OTP fields
  //         for (var controller in otpControllers) {
  //           controller.clear();
  //         }
  //
  //         if (context.mounted) {
  //
  //           final response = await http.post(
  //             Uri.parse('https://z0vx5pwf-5000.inc1.devtunnels.ms/api/register'),
  //             headers: {"Content-Type": "application/json"},
  //             body: jsonEncode({
  //               "first_name":widget.firstName,
  //               "last_name":widget.lastName,
  //               "email": widget.email,
  //               "password": widget.password,
  //             }),
  //           );
  //
  //           print("response body");
  //           print(response);
  //           if(response.statusCode==200){
  //             Navigator.of(context).pushReplacement(
  //               PageTransition.buildPageRoute(
  //                 const LoginPage(), // your target page
  //                 type: TransitionType.slide, // fade / scale / rotate
  //               ),
  //             );
  //           }
  //
  //         }
  //
  //       } else {
  //         print(result['error'].toString());
  //       }
  //     } else {
  //      print("Failed to verify OTP. Try again.");
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //     // notifyListeners();
  //     print("An error occurred: $e");
  //   }
  // }


  // Future<void> verifyOtp(BuildContext context, String email) async {
  //   String otp = otpControllers.map((e) => e.text).join();
  //
  //   if (otp.length < 6) {
  //     SnackBarUtil.showSnackBar(AppLocalizationController().getTextValue("OTP_FIELD_ERROR"));
  //     return;
  //   }
  //
  //   isLoading = true;
  //   notifyListeners();
  //
  //   dynamic result = await MakeHttpRequest().makeHttpRequest(
  //     http.post(url),
  //     'http://localhost:5000/api/verify-otp',
  //     {
  //       "email": email,
  //       "purpose": "REGISTER",
  //       "otp": otp,
  //     },
  //     (message) {
  //       SnackBarUtil.showSnackBar(message);
  //     },
  //   );
  //
  //   isLoading = false;
  //   notifyListeners();
  //   print(result);
  //
  //   // Check if OTP verification was successful
  //   if (result is Map && result['error'] == null) {
  //     for (var controller in otpControllers) {
  //       controller.clear();
  //     }
  //     if (context.mounted) {
  //       Navigator.pushReplacementNamed(context, '/reset-password');
  //     }
  //   }
  // }

  void updateUI() {
    notifyListeners(); // Refresh UI when focus changes
  }

  @override
  void dispose() {
    for (var controller in otpControllers) controller.dispose();
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    timerController?.dispose();
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
