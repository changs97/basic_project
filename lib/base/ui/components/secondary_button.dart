import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  const SecondaryButton({super.key, required this.label, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    final child = Text(label);
    return SizedBox(
      height: 44,
      child: icon == null
          ? OutlinedButton(onPressed: onPressed, child: child)
          : OutlinedButton.icon(onPressed: onPressed, icon: Icon(icon), label: child),
    );
  }
}


