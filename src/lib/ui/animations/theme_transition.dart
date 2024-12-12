import 'package:flutter/material.dart';

class ThemeTransition extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;

  const ThemeTransition({
    Key? key,
    required this.child,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: child,
      ),
    );
  }
}
