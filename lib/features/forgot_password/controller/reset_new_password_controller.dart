import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/localization/app_localization_controller.dart';
// import '../../../core/utils/helpers/make_http_request.dart';
// import '../../../widgets/custom_widgets/customized_snackbar.dart';
import '../../../core/utils/helpers/apiCalls/makeHttpRequest.dart';
import '../../../shared/widgets/custom_widgets/custom_snackbar.dart';
import '../view/reset_successful.dart';
import 'forgot_pass_email_controller.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController with ChangeNotifier {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  bool isLoading = false; // Prevent multiple clicks

  String passwordError = '';
  String confirmPasswordError = '';
  bool isFormValid = false;

  ResetPasswordController() {
    passwordController.addListener(() {
      validatePassword(passwordController.text);
      validateForm();
    });
    confirmPasswordController.addListener(() {
      validateConfirmPassword(confirmPasswordController.text);
      validateForm();
    });
  }

  void togglePasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    notifyListeners();
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      passwordError = AppLocalizationController().getTextValue("PASSWORD_ERROR");
      notifyListeners();
      return false;
    }
    if (password.length < 8) {
      passwordError = AppLocalizationController().getTextValue("PASSWORD_VALIDATION");
      notifyListeners();
      return false;
    }
    passwordError = '';
    notifyListeners();
    return true;
  }

  bool validateConfirmPassword(String confirmPassword) {
    if (confirmPassword.isEmpty) {
      confirmPasswordError = AppLocalizationController().getTextValue("CONFIRM_PASSWORD_ERROR");
      notifyListeners();
      return false;
    }
    if (confirmPassword != passwordController.text) {
      confirmPasswordError = AppLocalizationController().getTextValue("PASSWORD_NOT_MATCH");
      notifyListeners();
      return false;
    }
    confirmPasswordError = '';
    notifyListeners();
    return true;
  }

  void validateForm() {
    isFormValid = validatePassword(passwordController.text) && validateConfirmPassword(confirmPasswordController.text);
    notifyListeners();
  }

  Future<void> submitPasswordChange(BuildContext context) async {
    if (!isFormValid || isLoading) return; // Prevent multiple clicks

    isLoading = true;
    notifyListeners();

    final forgotPassEmailController = Provider.of<ForgotPassEmailController>(context, listen: false);

    dynamic result = await MakeHttpRequest().makeHttpRequest(
      http.patch,
      '/update-password',
      {
        "email": forgotPassEmailController.emailController.text.trim(),
        "password": passwordController.text,
        "is_forgot_password": true,
        "is_set_password": false,
      },
      (message) {
        SnackBarUtil.showSnackBar(message);
      },
    );

    if (result is Map && result['error'] == null) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ResetSuccessful()),
        );
      }
      forgotPassEmailController.emailController.clear();
    }

    passwordController.clear();
    confirmPasswordController.clear();
    passwordError = '';
    confirmPasswordError = '';

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
