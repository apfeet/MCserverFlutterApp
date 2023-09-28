import 'package:flutter/material.dart';

class BottoneFloat extends StatelessWidget {
  final VoidCallback? onPressed;
  final String labelText;
  final IconData icon;
  final Color backgroundColor;

  BottoneFloat({
    required this.onPressed,
    required this.labelText,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      foregroundColor: backgroundColor,
      child: Icon(icon),
    );
  }
}
