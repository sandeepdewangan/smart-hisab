import 'package:flutter/material.dart';

class ActionBarIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  const ActionBarIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 35, color: Colors.white),
    );
  }
}
