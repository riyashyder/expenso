import 'package:flutter/material.dart';

import '../../connectivity_provider/connectivity_provider.dart';

class RsnackBarUtil {
  // Static method to show SnackBar
  static final currentContext = RappContext.context;
  static void showSnackBar(
      String message,
      ) {
    ScaffoldMessenger.of(currentContext).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(message),
        duration:
        const Duration(seconds: 3), // You can change the duration as needed
      ),
    );
  }
}
class SnackBarUtil {
  // Static method to show SnackBar
  static final currentContext = RappContext.context;
  static void showSnackBar(
      String message,
      ) {
    ScaffoldMessenger.of(currentContext).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(message),
        duration:
        const Duration(seconds: 3), // You can change the duration as needed
      ),
    );
  }
}


