import 'package:flutter/material.dart';

class ScreenBase extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;

  const ScreenBase({super.key, required this.backgroundColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 100,
                maxWidth: 1080,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
