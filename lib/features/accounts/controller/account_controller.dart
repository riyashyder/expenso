import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/account_model.dart';

class AccountController with ChangeNotifier {
  List<AccountModel> _accounts = [];

  List<AccountModel> get accounts => _accounts;

  Future<void> loadAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('accounts') ?? [];
    _accounts = data.map((e) => AccountModel.fromJson(json.decode(e))).toList();
    notifyListeners();
  }

  Future<void> addOrEditAccount(AccountModel account, [int? index]) async {
    if (index != null) {
      _accounts[index] = account;
    } else {
      _accounts.add(account);
    }
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> deleteAccount(int index) async {
    _accounts.removeAt(index);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _accounts.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('accounts', encoded);
  }
}
