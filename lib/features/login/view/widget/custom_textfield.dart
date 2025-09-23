import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/widgets/styles/styles.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? prefixIconAsset;
  final bool obscureText;
  final bool isPasswordField;
  final Color borderColor;
  final TextStyle? labelStyle;
  final Function(String)? onChanged;
  final VoidCallback? togglePasswordVisibility; // Changed to VoidCallback
  final bool allowSpaces;
  final bool isMobile;
  final bool enable;
  final bool keyEmail;
  

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.prefixIconAsset,
    this.obscureText = false,
    this.isPasswordField = false, // Default to false
    // this.borderColor = AppthemeData.borderColor,
    this.borderColor = AppthemeData.borderColor,
    this.labelStyle,
    this.onChanged,
    this.togglePasswordVisibility, // Add the toggle function
    this.allowSpaces = true,
    this.isMobile = false,
    this.enable=true,
    this.keyEmail = false
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double leftMargin = screenWidth * 0.07; 
    double rightMargin = screenWidth * 0.03; 

    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppthemeData.buttonColor,
        onChanged: onChanged,
        enabled:enable,
        keyboardType: keyEmail ? TextInputType.emailAddress : TextInputType.text,
        inputFormatters:
            allowSpaces
                ? null
                : [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppthemeData.labelColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Container(
            margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
            child:
                !isMobile
                    ? SvgPicture.asset(
                      prefixIconAsset!,
                      fit: BoxFit.contain, 
                    )
                    : IntrinsicWidth(
                      child: Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              prefixIconAsset!,
                              fit: BoxFit.contain, // Ensures proper scaling
                            ),
                          SizedBox(width: 4,),
                            Text('+971', style: AppthemeData.greytextstyle),
                            SizedBox(width: 4,),
                            const SizedBox(
                              height: 25,
                              child: VerticalDivider(thickness: 1),
                            ),
                          ],
                        ),
                      ),
                    ),
          ),
          suffixIcon:
              isPasswordField
                  ? GestureDetector(
                    onTap: togglePasswordVisibility,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        obscureText
                            ? 'assets/svg/hide_password.svg' // Eye closed SVG
                            : 'assets/svg/show_password.svg', // Eye open SVG
                      ),
                    ),
                    // child: Icon(
                    //   obscureText ? Icons.visibility_off : Icons.visibility,
                    //   color: AppthemeData.labelColor,
                    // ),
                  )
                  : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(color: borderColor), // Custom border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(
              color: borderColor,
              width: 1.0,
            ), // Custom border when focused
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ), // Adjust vertical padding for content
        ),
      ),
    );
  }
}
