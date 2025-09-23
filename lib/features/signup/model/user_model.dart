class UserModel {
  String email;
  String password;
  String confirmPassword;
  String otp;

  UserModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.otp = '',
  });
}
