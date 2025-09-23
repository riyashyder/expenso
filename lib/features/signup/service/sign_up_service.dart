class SignUpService {
  Future<void> sendOtp(String email) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> verifyOtp(String email, String otp) async {
    // Simulate verification logic
    await Future.delayed(const Duration(seconds: 1));
    return otp == "123456"; // fake OTP match
  }
}
