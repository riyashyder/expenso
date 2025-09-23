import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ShootingStar extends StatefulWidget {
  const ShootingStar({super.key});

  @override
  State<ShootingStar> createState() => _ShootingStarState();
}

class _ShootingStarState extends State<ShootingStar>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<Offset> _position;
  late Animation<double> _fade;
  final Random _random = Random();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _startAnimationLoop();
  }

  void _startAnimationLoop() async {
    while (mounted) {
      await Future.delayed(Duration(seconds: _random.nextInt(4) + 2));

      if (!mounted) return;

      setState(() => _isVisible = true);

      // Dispose old controller if exists
      _controller?.dispose();

      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 9), // 👈 Slow animation
      );

      final dxStart = 1.0;
      final dyStart = -0.8;
      final dxEnd = -0.2;
      final dyEnd = 0.2;
      // final dxEnd = -0.2;
      // final dyEnd = 1.2;

      _position = Tween<Offset>(
        begin: Offset(dxStart, dyStart),
        end: Offset(dxEnd, dyEnd),
      ).animate(CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ));

      _fade = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ));

      _controller!.forward();

      await Future.delayed(_controller!.duration!);

      if (!mounted) return;
      _controller!.dispose();
      _controller = null;
      setState(() => _isVisible = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible || _controller == null) return const SizedBox();

    return SlideTransition(
      position: _position,
      child: FadeTransition(
        opacity: _fade,
        child: Image.asset(
          'assets/images/shooting_star.png',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
