
import 'dart:async';
import 'package:flutter/material.dart';

class OtpTimerController extends ChangeNotifier {
  Timer? _timer;
  int _remainingSeconds;

  OtpTimerController(int otpValidityTime) : _remainingSeconds = otpValidityTime {
    startTimer();
  }

  int get remainingSeconds => _remainingSeconds;

  String get timeRemaining {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer before starting a new one
    print("Starting timer for $_remainingSeconds seconds");

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel(); // Cancel timer when countdown reaches 0
        notifyListeners(); // Notify UI to reflect 00:00
        print("Timer finished");
      }
    });
  }

  void restartTimer(int newTime) {
    if (newTime <= 0) return; // Prevent invalid timer values

    print("Restarting timer with new time: $newTime seconds");
    _timer?.cancel(); // Cancel existing timer
    _remainingSeconds = newTime;
    notifyListeners(); // Notify before starting to update UI immediately
    startTimer(); // Start new countdown
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}




//
// import 'dart:async';
// import 'package:flutter/material.dart';
//
// class OtpTimerController extends ChangeNotifier {
//   Timer? _timer;
//   int _remainingSeconds;
//
//   OtpTimerController(int otpValidityTime) : _remainingSeconds = otpValidityTime {
//     startTimer();
//   }
//
//   int get remainingSeconds => _remainingSeconds; // Public getter
//
//   String get timeRemaining {
//     final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
//     final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
//     return "$minutes:$seconds";
//   }
//
//   void startTimer() {
//     _timer?.cancel(); // Cancel any existing timer before starting a new one
//     print("Starting timer for $_remainingSeconds seconds");
//
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingSeconds > 0) {
//         _remainingSeconds--;
//         notifyListeners();
//       } else {
//         timer.cancel(); // Cancel timer when countdown reaches 0
//         notifyListeners(); // Notify UI to reflect 00:00
//         print("Timer finished");
//       }
//     });
//   }
//
//   void restartTimer(int newTime) {
//     if (newTime <= 0) return; // Prevent invalid timer values
//
//     print("Restarting timer with new time: $newTime seconds");
//     _timer?.cancel(); // Cancel existing timer
//     _remainingSeconds = newTime;
//     notifyListeners(); // Notify before starting to update UI immediately
//     startTimer(); // Start new countdown
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel(); // Ensure timer is properly disposed
//     super.dispose();
//   }
// }







// import 'dart:async';
// import 'package:flutter/material.dart';
//
// class OtpTimerController extends ChangeNotifier {
//   Timer? _timer;
//   int _remainingSeconds;
//
//   OtpTimerController(int otpValidityTime) : _remainingSeconds = otpValidityTime {
//     startTimer();
//   }
//
//   String get timeRemaining {
//     final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
//     final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
//     return "$minutes:$seconds";
//   }
//
//   void startTimer() {
//     _timer?.cancel(); // Ensure any existing timer is cancelled
//     print("Starting timer for $_remainingSeconds seconds");
//
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingSeconds > 0) {
//         _remainingSeconds--;
//         notifyListeners();
//       } else {
//         _timer?.cancel();
//         notifyListeners();
//         print("Timer finished");
//       }
//     });
//   }
//
//   void restartTimer(int newTime) {
//     print("Restarting timer with new time: $newTime seconds");
//     _timer?.cancel(); // Cancel the old timer
//     _remainingSeconds = newTime;
//     notifyListeners(); // Ensure UI listens to changes
//     startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }
