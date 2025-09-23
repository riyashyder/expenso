import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/localization/app_localization_controller.dart';
import '../../../core/utils/validators/common_validators-ThetaZero-1.dart';
import '../../../core/utils/validators/common_validators.dart';

class LoginController with ChangeNotifier  {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isFormValid = false;
  bool isPasswordObscure = true;
  bool isLoading = false;

  String emailError = '';
  String passwordError = '';
  bool rememberMe = false;

  LoginController() {
    emailController.addListener(() {
      _validateEmailOnChange();
      validateForm(); // Check the entire form's validity on every change
    });
    passwordController.addListener(() {
      _validatePasswordOnChange();
      validateForm(); // Check the entire form's validity on every change
    });
    loadRememberedCredentials();
  }

  void togglePasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    notifyListeners();
  }


  void notify(){
    notifyListeners(); // Ensure UI updates
  }
  Future<void> loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAtStr = prefs.getString('credentialsSavedAt');

    if (savedAtStr != null) {
      final savedAt = DateTime.parse(savedAtStr);
      final now = DateTime.now();
      if (now.difference(savedAt).inDays >= 30) {
        await prefs.remove('email');
        await prefs.remove('password');
        await prefs.remove('rememberMe');
        await prefs.remove('credentialsSavedAt');

        emailController.clear();
        passwordController.clear();
        rememberMe = false;

        notifyListeners();
        return;
      }
    }

    final savedEmail = prefs.getString('email') ?? '';
    final savedPassword = prefs.getString('password') ?? '';
    // rememberMe = prefs.getBool('rememberMe') ?? false;

    if (prefs.getBool('rememberMe') ?? false) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
    } else {
      emailController.clear();
      passwordController.clear();
    }

    notifyListeners();
  }


  void validateForm() {
    bool emailIsValid = emailController.text.isNotEmpty &&
        emailController.text.contains('@') &&
        emailError == '';
    bool passwordIsValid = passwordController.text.isNotEmpty;

    isFormValid = emailIsValid && passwordIsValid;
    notifyListeners();
  }

  Future<void> saveCredentials(
      dynamic loginDetails, String password, bool rememberMe) async {
    // loginDetails IS ALREADY loginResponse['data']
    final token = loginDetails['authDetails']['accessToken'];
    final user = loginDetails['userDetails'];

    final shopId = user?['shop_id'] ?? '';
    final role = user?['role'] ?? '';
    final email = user?['email'] ?? '';
    final userId = user?['_id'] ?? '';


    if (token == null) {
      debugPrint(" AccessToken is null! Full loginDetails: $loginDetails");
      throw Exception("AccessToken is null");
    }

    final prefs = await SharedPreferences.getInstance();

    if (rememberMe) {
      await prefs.setBool('rememberMe', rememberMe);
      await prefs.setString('password', password);
      await prefs.setString(
          'credentialsSavedAt', DateTime.now().toIso8601String());
    }

    await prefs.setString('token', token);
    await prefs.setString('shop_id', shopId);
    await prefs.setString('role', role);
    await prefs.setString('email', email);
    await prefs.setString('_id', userId);
    await prefs.setString('userId', userId);

  }

  void _validateEmailOnChange() {
    validateEmail(emailController.text);
    // print("email triggers");
    validateForm();
  }

  void _validatePasswordOnChange() {
    validatePassword(passwordController.text);
    // print("password triggers");
    validateForm();
  }

  Future<void> checkTokenAndNavigate(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('shop_id');
    prefs.remove('role');

    // if (context.mounted) {
    //   Navigator.pushReplacementNamed(context, '/login');
    // }
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      emailError = '';
      notifyListeners();
      return false;
    }
    if (!Rvalidators().isValidEmail(email)) {
      emailError =
          AppLocalizationController().getTextValue("LOGIN_EMAIL_ERROR");
      notifyListeners();
      return false;
    }
    emailError = '';
    notifyListeners();
    return true;
  }

  bool validatePassword(String password) {
    if (emailController.text.isNotEmpty && password.isEmpty) {
      passwordError =
          AppLocalizationController().getTextValue("LOGIN_PASSWORD_ERROR");
      notifyListeners();
      return false;
    }
    passwordError = '';
    notifyListeners();
    return true;
  }

  Future<bool> login() async {
    final isEmailValid = validateEmail(emailController.text);
    final isPasswordValid = validatePassword(passwordController.text);

    if (isEmailValid && isPasswordValid) {
      // isLoading = true;
      notifyListeners(); // Notify UI of state change

      try {
        await Future.delayed(Duration(seconds: 1)); // Simulate API call

        // isLoading = false;
        notifyListeners(); // Reset loading state

        return true;
      } catch (e) {
        // isLoading = false;
        notifyListeners();
        return false;
      }
    }
    return false;
  }

  // Future<bool> login() async {
  //   final isEmailValid = validateEmail(emailController.text);
  //   final isPasswordValid = validatePassword(passwordController.text);
  //
  //   if (isEmailValid && isPasswordValid) {
  //     return true;
  //   }
  //   return false;
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clear() {
    emailController.clear();
    passwordController.clear();

    emailError = '';
    passwordError = '';
  }



  void forgotPassword() {
    print("Forgot password clicked");
  }

  void signUp() {
    print("Sign Up clicked");
  }

  void useBiometrics() {
    print("Biometrics clicked");
  }
}
