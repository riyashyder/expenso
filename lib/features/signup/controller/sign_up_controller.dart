import 'package:flutter/material.dart';
import '../model/user_model.dart';

class SignUpController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isEmailVerified = false;

  UserModel get user => UserModel(
    email: emailController.text,
    password: passwordController.text,
    confirmPassword: confirmPasswordController.text,
  );

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final userData = user;

      if (!isEmailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please verify your email first.")),
        );
        return;
      }

      // Call your signup API here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signing up ${userData.email}")),
      );
    }
  }

  Future<void> sendOtp(String email) async {
    // Simulate OTP send delay
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("OTP sent to $email");
  }

  Future<bool> verifyOtp(String enteredOtp) async {
    // Simulate OTP verification logic
    await Future.delayed(const Duration(seconds: 1));
    return enteredOtp == "123456"; // match with hardcoded OTP
  }
}
