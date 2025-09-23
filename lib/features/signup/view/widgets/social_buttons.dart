import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _iconButton("assets/icons/icon_facebook_1.png"),
        _iconButton("assets/icons/icon_google_1.png"),
        _iconButton("assets/icons/icon_apple_1.png"),
      ],
    );
  }

  Widget _iconButton(String asset) {
    return Container(
      height: 60,
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(asset),
    );
  }
}
