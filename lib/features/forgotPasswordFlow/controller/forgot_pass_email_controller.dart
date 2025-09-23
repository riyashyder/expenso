import 'package:flutter/material.dart';

import '../../../core/localization/app_localization_controller.dart';

class ForgotPassEmailController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = false;
  String emailError = '';
  bool _isLoading = false; // Added loading state

  bool get isLoading => _isLoading; // Getter for isLoading

  void validateEmail(String email) {
    // Improved email validation allowing anything after the last dot
    bool isValidEmail(String email) {
      return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
    }

    if (email.isEmpty) {
      emailError = AppLocalizationController().getTextValue("FORGOT_PASSWORD_ERROR");
      isEmailValid = false;
    } else if (!isValidEmail(email)) {
      emailError = AppLocalizationController().getTextValue("FORGOT_PASSWORD_ERROR");
      isEmailValid = false;
    } else {
      emailError = '';
      isEmailValid = true;
    }

    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
