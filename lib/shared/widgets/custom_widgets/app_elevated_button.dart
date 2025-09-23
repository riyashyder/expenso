import 'package:flutter/material.dart';

import '../styles/styles.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final IconData? icon;
  final BorderSide? side;

  const AppElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
    this.icon,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: side ?? BorderSide.none,
        backgroundColor: backgroundColor ?? AppthemeData.otherColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(30),
        ),
        padding:
            padding ??
            EdgeInsets.symmetric(
              horizontal: screenWidth * 0.25,
              // horizontal: screenWidth * 0.30,
              vertical: height ?? 18.0,
            ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
          ],
          Text(label, style: textStyle ?? AppthemeData.buttonStyle),
        ],
      ),
    );
  }
}
