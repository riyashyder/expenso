// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class HiBubble extends StatefulWidget {
//   const HiBubble({super.key});
//
//   @override
//   State<HiBubble> createState() => _HiBubbleState();
// }
//
// class _HiBubbleState extends State<HiBubble>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scale;
//   late Animation<Offset> _shake;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     // Sudden pop up (0 → 1), hold, sudden shrink (1 → 0)
//     _scale = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 10), // quick grow
//       TweenSequenceItem(tween: ConstantTween(1.0), weight: 250), // hold
//       TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20), // quick shrink
//     ]).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
//
//     // Cross-diagonal oscillation (↙ ↗ ↙ ↗)
//     _shake = TweenSequence<Offset>([
//       TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 10), // no shake during grow
//       TweenSequenceItem(
//         tween: TweenSequence([
//           TweenSequenceItem(tween: Tween(begin: Offset.zero, end: const Offset(-0.04, 0.04)), weight: 1),
//           TweenSequenceItem(tween: Tween(begin: const Offset(-0.04, 0.04), end: const Offset(0.04, -0.04)), weight: 1),
//           TweenSequenceItem(tween: Tween(begin: const Offset(0.04, -0.04), end: const Offset(-0.03, 0.03)), weight: 1),
//           TweenSequenceItem(tween: Tween(begin: const Offset(-0.03, 0.03), end: const Offset(0.03, -0.03)), weight: 1),
//           TweenSequenceItem(tween: Tween(begin: const Offset(0.03, -0.03), end: Offset.zero), weight: 1),
//         ]),
//         weight: 70, // shake during hold
//       ),
//       TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 20), // no shake during shrink
//     ]).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
//
//     _startLoop();
//   }
//
//   void _startLoop() async {
//     while (mounted) {
//       await _controller.forward();
//       await Future.delayed(const Duration(seconds: 1));
//       _controller.reset();
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: _shake,
//       child: ScaleTransition(
//         scale: _scale,
//         alignment: Alignment.bottomRight,
//         child: SvgPicture.asset(
//           'assets/images/message_icon.svg',
//           width: 35,
//           height: 35,
//         ),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HiBubble extends StatefulWidget {
  const HiBubble({super.key});

  @override
  State<HiBubble> createState() => _HiBubbleState();
}

class _HiBubbleState extends State<HiBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<Offset> _shake;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Sudden pop up -> Hold -> Sudden shrink
    _scale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 30),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 10),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Oscillating shake effect
    _shake = TweenSequence<Offset>([
      TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 30),
      TweenSequenceItem(
        tween: TweenSequence([
          TweenSequenceItem(tween: Tween(begin: Offset.zero, end: const Offset(0.08, 0)), weight: 1),
          TweenSequenceItem(tween: Tween(begin: const Offset(0.08, 0), end: const Offset(-0.08, 0)), weight: 1),
          TweenSequenceItem(tween: Tween(begin: const Offset(-0.08, 0), end: const Offset(0.05, 0)), weight: 1),
          TweenSequenceItem(tween: Tween(begin: const Offset(0.05, 0), end: const Offset(-0.05, 0)), weight: 1),
          TweenSequenceItem(tween: Tween(begin: const Offset(-0.05, 0), end: const Offset(0.03, 0)), weight: 1),
          TweenSequenceItem(tween: Tween(begin: const Offset(0.03, 0), end: const Offset(-0.03, 0)), weight: 1),
          TweenSequenceItem(tween: Tween(begin: const Offset(-0.03, 0), end: Offset.zero), weight: 1),
        ]),
        weight: 60,
      ),
      TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 10),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _startLoop();
  }

  // 🔁 Animation loop with 3-second delay after each cycle
  void _startLoop() async {
    while (mounted) {
      await _controller.forward();                        // Play animation
      await Future.delayed(const Duration(seconds: 3));   // ⏸️ Pause for 3 seconds
      _controller.reset();                                // Reset for next loop
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _shake,
      child: ScaleTransition(
        scale: _scale,
        alignment: Alignment.bottomRight,
        child: SvgPicture.asset(
          'assets/images/message_icon.svg',
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class HiBubble extends StatefulWidget {
//   const HiBubble({super.key});
//
//   @override
//   State<HiBubble> createState() => _HiBubbleState();
// }
//
// class _HiBubbleState extends State<HiBubble>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scale;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     _scale = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 40), // Pop up
//       TweenSequenceItem(tween: ConstantTween(1.0), weight: 20), // Hold
//       TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 40), // Shrink
//     ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     _startLoop();
//   }
//
//   void _startLoop() async {
//     while (mounted) {
//       await _controller.forward();
//       await Future.delayed(const Duration(seconds: 1)); // Delay before repeating
//       _controller.reset();
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: _scale,
//       alignment: Alignment.bottomRight, // aligns it to appear from bottom-left
//       child: SvgPicture.asset(
//         'assets/images/message_icon.svg',
//         width: 35,
//         height:35,
//       ),
//     );
//   }
// }
