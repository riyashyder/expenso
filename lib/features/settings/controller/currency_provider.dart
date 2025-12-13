import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyProvider extends ChangeNotifier {
  String _currencyCode = 'USD';
  String _currencySymbol = '\$';

  String get code => _currencyCode;
  String get symbol => _currencySymbol;

  /// Load saved currency on app start
  Future<void> loadCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    _currencyCode = prefs.getString('currency_code') ?? 'USD';
    _currencySymbol = prefs.getString('currency_symbol') ?? '\$';
    notifyListeners();
  }

  /// Update currency from API / Profile screen
  Future<void> setCurrency({
    required String code,
    required String symbol,
  }) async {
    _currencyCode = code;
    _currencySymbol = symbol;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency_code', code);
    await prefs.setString('currency_symbol', symbol);

    notifyListeners();
  }
}
