import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/devices/get_localization_provider.dart';
import '../styles/styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? placeholder;
  final TextInputType? keyboardType;
  final bool? hide;
  final bool isMobileNumber;
  final Function(String)? onchange;
  final FormFieldValidator<String>? validator;
  final bool? forceLeftAlign;
  final double? width;
  final double? height;
  final int? minLines;
  final int? maxLines;
  final bool isFileUpload;
  final Function(File?)? onFileSelected;
  final bool showSuffixWithLabel;
  final String? suffixText;
  final bool isEditing;
  final bool enabled;
  final bool allowOnlyAlphabets;
  final bool allowOnlyNumber;
  final bool isEmail;
  final bool maxLength;
  final bool showEyeIcon;
  final String? svgname;
  final bool innerFeild;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.hide,
    this.isMobileNumber = true,
    this.onchange,
    this.validator,
    this.forceLeftAlign = false,
    this.placeholder,
    this.width,
    this.height,
    this.minLines,
    this.maxLines,
    this.isFileUpload = false,
    this.onFileSelected,
    this.showSuffixWithLabel = false,
    this.suffixText,
    this.isEditing = false,
    this.enabled = true,
    this.allowOnlyAlphabets = false,
    this.allowOnlyNumber = false,
    this.maxLength = false,
    this.showEyeIcon = false,
    this.svgname,
    this.isEmail = false,
    this.innerFeild = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;
  String? fileName;
  File? selectedFile;
  int maxSizeInBytes = 2 * 1024 * 1024;

  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.hide ?? false;
  }

  void validate(String value) {
    if (widget.validator != null) {
      setState(() {
        errorText = widget.validator!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationController = getLocalizationController(
      context,
      listen: false,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.width ?? double.infinity,
          height: widget.height,
          child: TextFormField(
            validator: widget.validator,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            inputFormatters: [
              if (widget.allowOnlyNumber)
                FilteringTextInputFormatter.digitsOnly,
              if (widget.allowOnlyAlphabets) NameInputFormatter(),
              if (widget.isEmail)
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            controller: widget.controller,
            obscureText: obscureText,
            maxLength: widget.maxLength ? 9 : null,
            minLines: widget.minLines ?? 1,
            // maxLines: widget.maxLines,
            readOnly: widget.isFileUpload,
            enabled: widget.enabled,
            decoration: InputDecoration(
              counterText: "",
              errorMaxLines: 2,

              prefixIcon:
              widget.svgname != null
                  ? Padding(
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(
                  widget.svgname!,
                  fit: BoxFit.contain,
                ),
              )
                  : null,
              prefix:
              !widget.isMobileNumber
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('+971', style: AppthemeData.greytextstyle),
                  const SizedBox(
                    height: 25,
                    child: VerticalDivider(thickness: 1),
                  ),
                  // SizedBox(width: 5),
                ],
              )
                  : null,
              suffix:
              widget.showSuffixWithLabel
                  ? Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 24,
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(width: 5),
                    Text(widget.suffixText ?? ""),
                  ],
                ),
              )
                  : null,
              labelText: widget.label,
              hintText:
              widget.placeholder ??
                  "${localizationController.getTextValue("ENTER")} ${widget.label}",
              floatingLabelStyle: AppthemeData.floatinglabel,
              labelStyle: AppthemeData.inputTextStyle.copyWith(
                color: AppthemeData.labelColor,
              ),
              border: OutlineInputBorder(
                borderRadius:
                widget.innerFeild
                    ? BorderRadius.circular(12.0)
                    : BorderRadius.circular(32.0),
                borderSide: const BorderSide(
                  color: AppthemeData.helpValue,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                widget.innerFeild
                    ? BorderRadius.circular(12.0)
                    : BorderRadius.circular(32.0),
                borderSide: BorderSide(
                  color: AppthemeData.borderColor,
                ), // Custom border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                widget.innerFeild
                    ? BorderRadius.circular(12.0)
                    : BorderRadius.circular(32.0),
                borderSide: const BorderSide(
                  color: AppthemeData.helpValue,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              errorText: errorText,
              errorStyle: TextStyle(
                color: const Color.fromARGB(255, 147, 49, 42),
                fontSize: 10,
              ),

              suffixIcon: widget.showEyeIcon
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // adjust padding as needed
                  child: SvgPicture.asset(
                    obscureText
                        ? 'assets/icons/hide_password.svg' // eye closed
                        : 'assets/icons/show_password.svg', // eye open
                    width: 20,
                    height: 20,
                  ),
                ),
              )
                  : null,

              // suffixIcon:
              // widget.showEyeIcon
              //     ? IconButton(
              //   icon: Icon(
              //     obscureText ? Icons.visibility_off : Icons.visibility,
              //     color: Colors.grey,
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       obscureText = !obscureText;
              //     });
              //   },
              // )
              //     : null,
            ),
            onChanged: (value) {
              debugPrint("TextField changed: $value");
              widget.onchange?.call(value);
              validate(value);
            },
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}

class NameInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'[a-zA-Z ]'); // Allow letters and space

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    // Filter out invalid characters (non-letters and non-space)
    final filtered =
    newText.characters.where((char) => _regExp.hasMatch(char)).join();

    // Prevent starting with space
    if (filtered.startsWith(' ')) {
      return oldValue;
    }

    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}

