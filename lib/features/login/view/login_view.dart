import 'package:expense_tracker/core/theme/styles/styles.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/custom_widgets/app_elevated_button.dart';
import '../../../shared/widgets/custom_widgets/page_transition.dart';
import '../../../shared/widgets/styles/styles.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = LoginController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
            
                // Logo + App Name
                Row(
                  children:  [
                    Icon(Icons.receipt_long, color: AppthemeData.primaryBackground, size: 28),
                    SizedBox(width: 8),
                    Text(
                      "Expense Tracker",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
            
                const SizedBox(height: 40),
            
                const Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please enter your details to sign in.",
                  style: TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 30),
            
                // Email Field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: "Email",
                    filled: true,
                    fillColor: const Color(0xFFF5F7FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Password Field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: "Password",
                    filled: true,
                    fillColor: const Color(0xFFF5F7FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: controller.forgotPassword,
                    child:  Text(
                      "Forgot Password?",
                      style: AppthemeData.forgotPassStyle.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppElevatedButton(
                          label: 'Login',
                          textStyle: AppthemeData.buttonStyle,
                          onPressed: (){
                            // controller.login(
                            //   emailController.text,
                            //   passwordController.text,
                            // );
                            Navigator.of(context).push(
                              PageTransition.buildPageRoute(
                                const LoginView(), // replace with your page
                                type: TransitionType.slide, // fade / scale / rotate
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Sign Up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: controller.signUp,
                      child:  Text(
                        "Sign Up",
                        style: AppthemeData.forgotPassStyle.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Or continue with"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

                // Biometrics Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: controller.useBiometrics,
                    icon: const Icon(Icons.fingerprint, size: 28, color: Colors.blue),
                    label:  Text(
                      "Use Biometrics",
                      style: AppthemeData.forgotPassStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
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
