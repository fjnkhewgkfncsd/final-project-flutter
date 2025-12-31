import 'package:flutter/material.dart';

class SearchTransition {
  // Ultra smooth fade transition with custom curve
  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Cubic(0.25, 0.1, 0.25, 1.0), // Smoother curve
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400), // Slightly longer for smoothness
    );
  }
}