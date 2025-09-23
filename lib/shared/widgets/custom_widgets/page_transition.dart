import 'package:flutter/material.dart';

enum TransitionType { fade, slide, scale, rotate }

class PageTransition {
  static Route buildPageRoute(Widget page, {TransitionType type = TransitionType.fade}) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (type) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0), // slide from right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
              child: child,
            );
          case TransitionType.rotate:
            return RotationTransition(
              turns: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
              child: child,
            );
          default:
            return child;
        }
      },
    );
  }
}
