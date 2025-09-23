import 'package:flutter/material.dart';

class AppContext {
  AppContext._();

  static GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorkey.currentState!.context;
}