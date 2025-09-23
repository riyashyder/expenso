import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/localization/app_localization_controller.dart';
import '../../../core/utils/helpers/apiCalls/makeHttpRequest.dart';
import '../../../core/utils/validators/common_validators-ThetaZero-1.dart';
import '../../../core/utils/validators/common_validators.dart';
import '../model/otp_model.dart';

class RegisterController with ChangeNotifier {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emiratesController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(
    6,
        (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  //phone feilds
  final List<TextEditingController> otpPhoneControllers = List.generate(
    6,
        (index) => TextEditingController(),
  );
  final List<FocusNode> focusPhoneNodes = List.generate(
    6,
        (index) => FocusNode(),
  );

  bool clickVisible = false;
  bool isOtpVerified = false;
  bool isFormValid = false;
  bool isPasswordObscure = true;
  bool _isLoading = false;
  late int otpValidityTimeInSeconds;

  bool get isLoading => _isLoading;
  bool isRegisterLoading = false;
  String fullNameError = "";
  String lastNameError = "";
  String emailError = '';
  String passwordError = '';
  bool allFieldsFilled = false;
  String? selectedIDType;
  String countryName = "Sri-Lanka";
  String countryCode = "+94";
  String countryIso = "LK";

  // Timer? _timer;
  // int _remainingTime = 600;
  // bool _isResendDisabled = true;

  // int get remainingTime => _remainingTime;
  // bool get isResendDisabled => _isResendDisabled;
  bool isSendCodeEnabled = false;
  bool verify = false;

  bool _isEmailOtpVerified = false;
  bool get isEmailOtpVerified => _isEmailOtpVerified;
  set isEmailOtpVerified(bool val) {
    _isEmailOtpVerified = val;
    notifyListeners();
  }
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // This triggers UI rebuild
  }
  bool _isMobileOtpVerified = false;
  bool get isMobileOtpVerified => _isMobileOtpVerified;
  set isMobileOtpVerified(bool val) {
    _isMobileOtpVerified = val;
    notifyListeners();
  }

  bool get areBothOtpsVerified => isEmailOtpVerified && isMobileOtpVerified;
  void resetVerificationState() {
    isEmailOtpVerified = false;
    isMobileOtpVerified = false;
  }
  Timer? _emailOtpTimer;
  int _emailRemainingTime = 60;
  bool _isEmailResendDisabled = true;

  int get emailRemainingTime => _emailRemainingTime;
  bool get isEmailResendDisabled => _isEmailResendDisabled;

  // MOBILE OTP
  Timer? _mobileOtpTimer;
  int _mobileRemainingTime = 60;
  bool _isMobileResendDisabled = true;

  int get mobileRemainingTime => _mobileRemainingTime;
  bool get isMobileResendDisabled => _isMobileResendDisabled;

  //  Optional formatted timers for UI
  String get emailTimeFormatted => formatTime(_emailRemainingTime);
  String get mobileTimeFormatted => formatTime(_mobileRemainingTime);

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  // Future<bool> registerUser(BuildContext context) async {
  //   isLoading = true;
  //   notifyListeners();
  //
  //   final url = Uri.parse("http://localhost:5000/api/register");
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "first_name": fullNameController.text.trim(),
  //         "last_name": lastNameController.text.trim(),
  //         "email": emailController.text.trim(),
  //         "password": passwordController.text.trim(),
  //       }),
  //     );
  //
  //     isLoading = false;
  //     notifyListeners();
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = jsonDecode(response.body);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("✅ Registered Successfully")),
  //       );
  //       return true;
  //     } else {
  //       final error = jsonDecode(response.body);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("❌ ${error['message'] ?? 'Registration failed'}")),
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("⚠️ Error: $e")),
  //     );
  //     return false;
  //   }
  // }

  //  Email Timer Function
  void startEmailTimer(int otpValidityTime) {
    _emailOtpTimer?.cancel();
    _emailRemainingTime = otpValidityTime;
    _isEmailResendDisabled = true;
    notifyListeners();

    _emailOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_emailRemainingTime > 0) {
        _emailRemainingTime--;
        notifyListeners();
      } else {
        timer.cancel();
        _isEmailResendDisabled = false;
        clearOtpFields(otpControllers);
        notifyListeners();
      }
    });
  }

  //  Mobile Timer Function
  void startMobileTimer(int otpValidityTime) {
    _mobileOtpTimer?.cancel();
    _mobileRemainingTime = otpValidityTime;
    _isMobileResendDisabled = true;
    notifyListeners();

    _mobileOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_mobileRemainingTime > 0) {
        _mobileRemainingTime--;
        notifyListeners();
      } else {
        timer.cancel();
        _isMobileResendDisabled = false;
        clearOtpFields(otpPhoneControllers);
        notifyListeners();
      }
    });
  }

  //  Updated sendSecurityCode to use startEmailTimer
  Future<bool> sendSecurityCode(
      BuildContext context,
      String email,
      String purpose,
      ) async {
    if (email.isEmpty) return false;

    final requestBody = {"email": email, "purpose": purpose};
    final url = Uri.parse("https://z0vx5pwf-5000.inc1.devtunnels.ms/api/send-otp");


    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      print("response sendSecurityCode");
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // ✅ Map<String, dynamic>
        int otpValidityTime =
            int.tryParse(data['data']['otp_expiry_time'].toString()) ?? 5;
        final message = data['message'] ?? "OTP sent successfully";

        otpValidityTime *= 60;
        otpValidityTimeInSeconds = otpValidityTime;

        startEmailTimer(otpValidityTime);

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

  // Future<bool> sendSecurityCode(
  //     BuildContext context,
  //     String email,
  //     String purpose,
  //     ) async {
  //   if (email.isEmpty) return false;
  //
  //   final requestBody = {"email": email, "purpose": purpose};
  //
  //   final url = Uri.parse("https://z0vx5pwf-5000.inc1.devtunnels.ms/api/send-otp");
  //
  //   try {
  //
  //     final response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(requestBody),
  //     );
  //
  //     print("response sendSecurityCode");
  //     print(response.body);
  //
  //     final data = jsonDecode(response.body);
  //
  //     // print("Response from sendSecurityCode: $response");
  //     if (response.statusCode == 200 || data["success"] == true) {
  //       // final data = jsonDecode(response.body); //  decode first
  //
  //       //  final otp = response?["data"]?["otp"];
  //       int otpValidityTime = int.tryParse(data.data['otp_expiry_time'].toString()) ?? 5;
  //       otpValidityTime *= 60;
  //       // print("OTP Validity Time: $otpValidityTime seconds");
  //
  //       otpValidityTimeInSeconds = otpValidityTime; // ✅ save it for later
  //
  //
  //       startEmailTimer(otpValidityTime);
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(response.body)),
  //       );
  //       // if (context.mounted) {
  //       //   showSnackBar(context, "Email OTP sent successfully!");
  //       // }
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (error) {
  //     return false;
  //   }
  // }

  //  Updated sendMobileCode to use startMobileTimer
  Future<bool> sendMobileCode(
      BuildContext context,
      String phone,
      String purpose,
      String countryCode,
      ) async {
    if (phone.isEmpty) return false;

    final requestBody = {
      "mobile": '+94$phone',
      "purpose": purpose,
      "country_code": countryCode,
    };

    try {
      final response = await httpRequest.makeHttpRequest(
        http.post,
        "/mobile-otp",
        requestBody,
            (String message) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        },
      );
      //  print("Response from sendMobileCode: $response");
      if (response?["code"] == 201 || response?["success"] == true) {
        // final otp = response?["data"]?["otp"];
        int otpValidityTime = int.tryParse(response['data']['otp_expiry_time'].toString()) ?? 1;
        otpValidityTime *= 60;
        startMobileTimer(otpValidityTime); //  UPDATED
        // if (context.mounted) {
        //   showSnackBar(context, "Mobile OTP sent successfully!");
        // }
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  String getOtp() {
    return otpControllers.map((controller) => controller.text).join();
  }

  // String get timeRemaining {
  //   final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
  //   final seconds = (_remainingTime % 60).toString().padLeft(2, '0');
  //   return "$minutes:$seconds";
  // }

  void updateVerifyFlag() {
    verify =
        otpControllers.every((c) => c.text.isNotEmpty) &&
            otpPhoneControllers.every((c) => c.text.isNotEmpty);
    notifyListeners();
  }

  String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final local = parts[0];
    final domain = parts[1];

    final maskedLocal =
    local.length > 4 ? '${local.substring(0, 4)}****' : '${local[0]}***';

    return '$maskedLocal@$domain';
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('shop_id');
    prefs.remove('role');
  }

  String getPhoneOtp() {
    return otpPhoneControllers.map((controller) => controller.text).join();
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      emailError = '';
      notifyListeners();
      return false;
    }
    if (!Rvalidators().isValidEmail(email)) {
      emailError = AppLocalizationController().getTextValue(
        "LOGIN_EMAIL_ERROR",
      );
      notifyListeners();
      return false;
    }
    emailError = '';
    notifyListeners();
    return true;
  }

  bool validatePassword(String password) {
    if (emailController.text.isNotEmpty && password.isEmpty) {
      passwordError = AppLocalizationController().getTextValue(
        "LOGIN_PASSWORD_ERROR",
      );
      notifyListeners();
      return false;
    }
    passwordError = '';
    notifyListeners();
    return true;
  }

  bool validatePhoneNumber(String number) {
    if (number.trim().isEmpty) {
      return false;
    }

    if (countryCode == "+94") {
      if (number.length != 9) {
        return false;
      }
    } else if (countryCode == "+91") {
      if (number.length != 10) {
        return false;
      }
    } else {
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    mobileController.dispose();
    countryController.dispose();
    emiratesController.dispose();

    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }

    for (final controller in otpPhoneControllers) {
      controller.dispose();
    }
    for (final node in focusPhoneNodes) {
      node.dispose();
    }
    _emailOtpTimer?.cancel(); // 🔧
    _mobileOtpTimer?.cancel(); // 🔧
    // _timer?.cancel(); // Dispose timer if active
    super.dispose();
  }

  final validators = Rvalidators();

  bool isPasswordValid = false;
  bool passwordsMatch = false;

  bool isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(
          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]+',
        ).hasMatch(password);
  }

  bool passowrdForm() {
    final newPass = passwordController.text;
    final confirmPass = confirmPasswordController.text;
    final currentPass = confirmPasswordController.text;

    isPasswordValid = isValidPassword(newPass);

    passwordsMatch = newPass == confirmPass;

    notifyListeners();
    return allFieldsFilled =
        currentPass.isNotEmpty && newPass.isNotEmpty && confirmPass.isNotEmpty;
  }

  void checkFormCompletion() {
    final fullNameFilled = fullNameController.text.trim().length >= 3;
    final lastNameFilled = lastNameController.text.trim().length >= 3;
    final mobileValid = validatePhoneNumber(mobileController.text);
    final emailValid = validateEmail(emailController.text.trim());
    final passwordValid = isValidPassword(passwordController.text.trim());
    final passwordsAreSame =
        passwordController.text.trim() == confirmPasswordController.text.trim();

    final idValue = emiratesController.text.trim();

    // NIC/Passport validation using regex
    final pattern = RegExp(r'^(\d{9}[vVxX]|\d{12})$');
    final emiratesOrPassport = pattern.hasMatch(idValue);

    isFormValid =
        fullNameFilled &&
            lastNameFilled &&
            emailValid &&
            passwordValid &&
            passwordsAreSame;

    notifyListeners();
  }

  final MakeHttpRequest httpRequest = MakeHttpRequest();

  void clearForm() {
    fullNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    mobileController.clear();
    countryController.clear();
    emiratesController.clear();

    fullNameError = "";
    lastNameError = "";
    emailError = '';
    passwordError = '';
    isFormValid = false;
    isPasswordObscure = true;
    selectedIDType = null;
    countryName = "United Arab Emirates";
    countryCode = "+971";
    countryIso = "AE";

    notifyListeners();
  }

//ClearOTP Feilds
  void clearOtpFields(List<TextEditingController> otpControllers) {
    for (var controller in otpControllers) {
      controller.clear();
    }
  }

  void clearAllOtpFields() {
    clearOtpFields(otpControllers);
    clearOtpFields(otpPhoneControllers);
  }

  void clearAll() {
    // Clear OTP fields
    clearOtpFields(otpControllers);
    clearOtpFields(otpPhoneControllers);

    // Reset verification flags
    isEmailOtpVerified = false;
    isMobileOtpVerified = false;


    // Reset flags
    clickVisible = false;
    verify = false;
    isSendCodeEnabled = false;

    fullNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    notifyListeners();
  }


//Register API Calling
  Future<bool> registerUser(BuildContext context) async {
    debugPrint(" API Called: registerUser");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedCode = prefs.getString('countryNumber');
    debugPrint(" Shared Pref Country Number: $savedCode");

    final fullName =
        '${fullNameController.text.trim()} ${lastNameController.text.trim()}';
    final email = emailController.text.trim();
    final mobile = mobileController.text.trim();
    final fullPhone = "$countryCode$mobile";
    final country = countryController.text.trim();
    final identity = emiratesController.text.trim();

    debugPrint(" Name: $fullName");
    debugPrint(" Email: $email");
    debugPrint(" Mobile: $fullPhone");
    debugPrint(" Country Code (ISO): $countryIso");
    debugPrint(" Country Name: $country");
    debugPrint(" ID Type: $selectedIDType");
    debugPrint(" ID Value: $identity");
    debugPrint(" Password : ${passwordController.text}");

    Map<String, String> requestBody = {
      "first_name": fullNameController.text.trim(),
      "last_name": lastNameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    debugPrint(" Request Body: $requestBody");

    isRegisterLoading = true;
    notifyListeners();
    final url = Uri.parse("https://z0vx5pwf-5000.inc1.devtunnels.ms/api/register");

    try {


      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      debugPrint(" API Response: $response");
      debugPrint("📥 API Response: ${response.body}");
      isLoading = false;
      notifyListeners();


      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Onboarding Success");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${response}")),
        );
        // clearForm();

        return true;
      } else {
        debugPrint(" Onboarding Failed with response: $response");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ ${response.body ?? 'Registration failed'}")),
        );
        return false;
      }
    } catch (error) {
      debugPrint(" Exception during onboarding: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ ${error ?? 'Registration failed'}")),
      );
      return false;
    } finally {
      isRegisterLoading = false;
      notifyListeners();
    }
  }




  void showSnackBar(BuildContext context, String message) {
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });
  }


//Verify Email OTP
  Future<bool> verifySecurityCode(
      BuildContext context,
      OTPModel otpModel,
      ) async {
    if (otpModel.otp.length != 6) {
      return false;
    }

    try {
      final response = await httpRequest.makeHttpRequest(
        http.patch,
        "/otp",
        otpModel.toJson(),
            (String message) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        },
      );

      if (response?["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  //Verify Mobile OTP
  Future<bool> verifyMobileCode(
      BuildContext context,
      OTPPhoneModel otpModel,
      ) async {
    if (otpModel.otp.length != 6) {
      return false;
    }

    try {
      final response = await httpRequest.makeHttpRequest(
        http.patch,
        "/mobile-otp",
        otpModel.toJson(),
            (String message) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        },
      );

      if (response?["success"] == true) {
        // print("succes");
        return true;
      } else {
        // print("Fail");
        return false;
      }
    } catch (error) {
      return false;
    }
  }

// //Start Timing
//   void startTimer(List<TextEditingController> otpControllers) {
//     _timer?.cancel();
//     _remainingTime = 600;
//     _isResendDisabled = true;
//     notifyListeners();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingTime > 0) {
//         _remainingTime--;
//         notifyListeners();
//       } else {
//         timer.cancel();
//         _isResendDisabled = false;
//         clearOtpFields(otpControllers);
//         notifyListeners();
//       }
//     });
//   }

  // void resetTimer() {
  //   _timer?.cancel();
  //   _remainingTime = 600;
  //   _isResendDisabled = true;
  //   notifyListeners();
  // }

  // Add these methods somewhere accessible, like above your build method or in a utils file
  bool isValidEmiratesID(String id) {
    final patternWithDashes = RegExp(r'^784-\d{4}-\d{7}-\d{1}$');
    final patternWithoutDashes = RegExp(r'^784\d{12}$');

    return patternWithDashes.hasMatch(id) || patternWithoutDashes.hasMatch(id);
  }

  bool isValidPassportNumber(String passportNumber) {
    final pattern = RegExp(r'^[A-Z]?\d{7,8}$');
    return pattern.hasMatch(passportNumber);
  }
}
