import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/styles/styles.dart';
import '../../controller/sign_up_controller.dart';

class OtpDialog extends StatefulWidget {
  final SignUpController controller;
  final VoidCallback onVerified;

  const OtpDialog({super.key, required this.controller, required this.onVerified});

  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  bool isVerifying = false;


  void checkOtp() async {
    String otp = otpControllers.map((c) => c.text).join();
    if (otp.length == 6 && !isVerifying) {
      setState(() => isVerifying = true);
      bool valid = await widget.controller.verifyOtp(otp);
      if (valid) {
        if (mounted) {
          Navigator.pop(context); // Close OTP dialog first
        }

        await showLottieSuccess(); // Show verification success popup

        if (mounted) {
          widget.controller.isEmailVerified = true;
          widget.onVerified();
        }
      } else {
        if (mounted) {
          setState(() => isVerifying = false);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
        }
      }
    }
  }


  // void checkOtp() async {
  //   String otp = otpControllers.map((c) => c.text).join();
  //   if (otp.length == 6 && !isVerifying) {
  //     setState(() => isVerifying = true);
  //     bool valid = await widget.controller.verifyOtp(otp);
  //     if (valid) {
  //       Navigator.pop(context);
  //
  //       if(mounted) {
  //         setState(() {
  //           widget.controller.isEmailVerified = true;
  //         });
  //       }
  //       await showLottieSuccess();
  //
  //       widget.onVerified();
  //
  //     } else {
  //       setState(() => isVerifying = false);
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
  //     }
  //     if(mounted) {
  //       Navigator.pop(context);
  //     }
  //   }
  // }



  Future<void> showLottieSuccess() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        // Trigger auto-close using a microtask
        Future.delayed(const Duration(seconds: 3), () {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
        });

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Lottie.asset(
                    'assets/lottie/verified_animation.json',
                    repeat: false,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verification Successful!!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  // Future<void> showLottieSuccess() async {
  //   // Use a separate context so that we can pop this specific dialog reliably
  //   BuildContext? dialogContext;
  //
  //   await showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext ctx) {
  //       dialogContext = ctx; // assign local context
  //       return Dialog(
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //         backgroundColor: Colors.white,
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               SizedBox(
  //                 height: 120,
  //                 width: 120,
  //                 child: Lottie.asset(
  //                   'assets/lottie/verified_animation.json',
  //                   repeat: false,
  //                 ),
  //               ),
  //               const SizedBox(height: 20),
  //               const Text(
  //                 'Verification Successful!!',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16,
  //                   color: Colors.black,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //
  //   await Future.delayed(const Duration(seconds: 3));
  //
  //   // Safely pop only if dialog is still mounted
  //   if (dialogContext != null && Navigator.of(dialogContext!).canPop()) {
  //     Navigator.of(dialogContext!).pop();
  //   }
  // }


  @override
  void dispose() {
    for (final node in focusNodes) {
      node.dispose();
    }
    for (final controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Please enter the OTP sent to",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                Text(
                  widget.controller.emailController.text,
                  style: TextStyle(
                    color: AppThemeData.darkPurple,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    final keyboardFocusNode = FocusNode();
                    return SizedBox(
                      width: 45,
                      height: 50,
                      child: KeyboardListener(
                        focusNode: keyboardFocusNode,
                        onKeyEvent: (event) {
                          if (event is KeyDownEvent &&
                              event.logicalKey == LogicalKeyboardKey.backspace &&
                              otpControllers[index].text.isEmpty &&
                              index > 0) {
                            FocusScope.of(context)
                                .requestFocus(focusNodes[index - 1]);
                          }
                        },
                        child: TextField(
                          controller: otpControllers[index],
                          focusNode: focusNodes[index],
                          autofocus: index == 0,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppThemeData.darkPurple),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < 5) {
                                FocusScope.of(context)
                                    .requestFocus(focusNodes[index + 1]);
                              } else {
                                focusNodes[index].unfocus();
                              }
                            }
                            checkOtp();
                          },
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(keyboardFocusNode);
                          },
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => widget.controller
                        .sendOtp(widget.controller.emailController.text),
                    child: const Text("Resend code",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

