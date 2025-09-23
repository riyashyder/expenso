class OTPModel {
  final String email;
  final String otp;
  final String purpose;

  OTPModel({required this.email, required this.otp,required this.purpose,});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "purpose": purpose,
      "otp": otp,
    };
  }
}

class OTPPhoneModel {
  final String mobile;
  final String otp;
  final String purpose;
  final String? countryCode;

  OTPPhoneModel({required this.mobile, required this.otp,required this.purpose,this.countryCode});

  Map<String, dynamic> toJson() {
    return {
      "mobile": mobile,
      "purpose": purpose,
      "otp": otp,
      "country_code":countryCode
    };
  }
}
