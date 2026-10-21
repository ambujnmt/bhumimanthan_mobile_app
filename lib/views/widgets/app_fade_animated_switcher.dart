import 'package:flutter/material.dart';

class AppFadeAnimatedSwitcher extends StatelessWidget {
  final Widget? child;
  final int? durationMs;
  const AppFadeAnimatedSwitcher({super.key, this.child, this.durationMs});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: durationMs ?? 400),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: child,
    );
  }
}
