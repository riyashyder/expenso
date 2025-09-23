import 'package:flutter/material.dart';

class BottomNavProvider with ChangeNotifier {
  int _selectedIndex = 0;
  final List<int> _history = []; // Stack to track navigation history

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    if (_selectedIndex != index) {
      _history.add(_selectedIndex); // Store previous index
      // developer.log('the _history in set index ${_history.toString()}');
    }
    _selectedIndex = index;
    notifyListeners();
  }

  bool canPOP() {
    return _history.isEmpty;
  }

  bool goBack() {
    // developer.log('the _history in goback ${_history.toString()}');
    if (_selectedIndex != 0) {
      _selectedIndex = 0;
      notifyListeners();
      return false; // Prevent app exit
    }
    return true; // Allow app exit if history is empty
  }

  void reset() {
    _history.clear();
    _selectedIndex = 0;
  }
}
