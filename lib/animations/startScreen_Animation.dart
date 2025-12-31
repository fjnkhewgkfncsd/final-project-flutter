import 'package:flutter/material.dart';

class StartScreenAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onAnimationComplete;
  final Duration initialDelay;
  final Duration fadeOutDuration;

  const StartScreenAnimation({
    Key? key,
    required this.child,
    required this.onAnimationComplete,
    this.initialDelay = const Duration(seconds: 1),
    this.fadeOutDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  State<StartScreenAnimation> createState() => _StartScreenAnimationState();
}

class _StartScreenAnimationState extends State<StartScreenAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: widget.fadeOutDuration,
    );

    // Create fade out animation
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation sequence
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Wait for initial delay (1 second)
    await Future.delayed(widget.initialDelay);
    
    // Start fade out animation
    if (mounted) {
      await _controller.forward();
    }
    
    // Trigger callback to navigate after animation completes
    if (mounted) {
      widget.onAnimationComplete();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}