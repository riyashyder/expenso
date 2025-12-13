import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../controller/reset_password_controller.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();

    _oldPasswordController.addListener(_checkFormValidity);
    _newPasswordController.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    final isValid =
        _oldPasswordController.text.trim().isNotEmpty &&
            _newPasswordController.text.trim().isNotEmpty;

    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  // void _checkFormValidity() {
  //   final isValid =
  //       _oldPasswordController.text.trim().isNotEmpty &&
  //           _newPasswordController.text.trim().isNotEmpty &&
  //           _newPasswordController.text.trim().length >= 6;
  //
  //   if (isValid != _isFormValid) {
  //     setState(() {
  //       _isFormValid = isValid;
  //     });
  //   }
  // }


  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final controller = context.read<ResetSettingsPasswordController>();

    if (controller.isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final result = await controller.resetPassword(
      oldPassword: _oldPasswordController.text.trim(),
      newPassword: _newPasswordController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result["message"]),
        backgroundColor: result["success"] ? Colors.black : Colors.black,
      ),
    );

    if (result["success"]) {
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ResetSettingsPasswordController>();
    final localizationController =
    getLocalizationController(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          localizationController.getTextValue("RESET_PASSWORD"),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// CARD (same as SettingsScreen)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    _buildInput(
                      controller: _oldPasswordController,
                      label: localizationController
                          .getTextValue("RESET_OLD_PASSWORD"),
                      obscure: _obscureOld,
                      icon: Icons.lock_outline,
                      onToggle: () =>
                          setState(() => _obscureOld = !_obscureOld),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return localizationController
                              .getTextValue("ERR_ENTER_OLD_PASSWORD");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildInput(
                      controller: _newPasswordController,
                      label: localizationController
                          .getTextValue("RESET_NEW_PASSWORD"),
                      obscure: _obscureNew,
                      icon: Icons.lock,
                      onToggle: () =>
                          setState(() => _obscureNew = !_obscureNew),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return localizationController
                              .getTextValue("ERR_ENTER_NEW_PASSWORD");
                        }
                        if (v.length < 6) {
                          return localizationController
                              .getTextValue("ERR_PASSWORD_LENGTH");
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 28),

                    /// BUTTON (matches app style)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: (!_isFormValid || controller.isLoading)
                            ? null
                            : _submit,
                        // onPressed: controller.isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          _isFormValid ? const Color(0xFF2563EB) : Colors.grey.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),

                        child: controller.isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          localizationController
                              .getTextValue("UPDATE_PASSWORD"),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// @override
  // Widget build(BuildContext context) {
  //   final controller = context.watch<ResetSettingsPasswordController>();
  //   final localizationController = getLocalizationController(
  //     context,
  //     listen: false,
  //   );
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       title:  Text(localizationController.getTextValue("RESET_PASSWORD"),),
  //       centerTitle: true,
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           children: [
  //             TextFormField(
  //               controller: _oldPasswordController,
  //               obscureText: _obscureOld,
  //               decoration: InputDecoration(
  //                 labelText:  localizationController.getTextValue("RESET_OLD_PASSWORD"),
  //                 prefixIcon: const Icon(Icons.lock_outline),
  //                 suffixIcon: IconButton(
  //                   icon: Icon(
  //                     _obscureOld ? Icons.visibility_off : Icons.visibility,
  //                   ),
  //                   onPressed: () {
  //                     setState(() => _obscureOld = !_obscureOld);
  //                   },
  //                 ),
  //                 border: const OutlineInputBorder(),
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return localizationController.getTextValue("ERR_ENTER_OLD_PASSWORD");;
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 16),
  //
  //             TextFormField(
  //               controller: _newPasswordController,
  //               obscureText: _obscureNew,
  //               decoration: InputDecoration(
  //                 labelText: localizationController.getTextValue("RESET_NEW_PASSWORD"),
  //                 prefixIcon: const Icon(Icons.lock),
  //                 suffixIcon: IconButton(
  //                   icon: Icon(
  //                     _obscureNew ? Icons.visibility_off : Icons.visibility,
  //                   ),
  //                   onPressed: () {
  //                     setState(() => _obscureNew = !_obscureNew);
  //                   },
  //                 ),
  //                 border: const OutlineInputBorder(),
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return localizationController.getTextValue("ERR_ENTER_NEW_PASSWORD");
  //                 }
  //                 if (value.length < 6) {
  //                   return localizationController.getTextValue("ERR_PASSWORD_LENGTH");
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 30),
  //
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 onPressed: controller.isLoading ? null : _submit,
  //                 style: ElevatedButton.styleFrom(
  //                   padding: const EdgeInsets.symmetric(vertical: 14),
  //                 ),
  //                 child: controller.isLoading
  //                     ? const SizedBox(
  //                   height: 22,
  //                   width: 22,
  //                   child: CircularProgressIndicator(
  //                     strokeWidth: 2,
  //                     color: Colors.white,
  //                   ),
  //                 )
  //                     :  Text(
  //                   localizationController.getTextValue("UPDATE_PASSWORD"),
  //                   style: TextStyle(
  //                       fontSize: 16, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

Widget _buildInput({
  required TextEditingController controller,
  required String label,
  required bool obscure,
  required IconData icon,
  required VoidCallback onToggle,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey.shade700),
      prefixIcon: Icon(icon, color: Colors.blue.shade700),
      suffixIcon: IconButton(
        icon: Icon(
          obscure ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: onToggle,
      ),
      filled: true,
      fillColor: const Color(0xFFF6F7FB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
