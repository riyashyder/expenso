import 'dart:async';
import 'package:flutter/material.dart';

class OtpTimerController extends ChangeNotifier {
  int _remainingSeconds;
  Timer? _timer;

  OtpTimerController(this._remainingSeconds) {
    _startTimer();
  }

  String get timeRemaining {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void restartTimer(int seconds) {
    _remainingSeconds = seconds;
    _startTimer();
    notifyListeners();
  }

  bool get isExpired => _remainingSeconds <= 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
