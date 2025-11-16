import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  const PrimaryButton({super.key, required this.label, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    final child = Text(label);
    return SizedBox(
      height: 48,
      child: icon == null
          ? ElevatedButton(onPressed: onPressed, child: child)
          : ElevatedButton.icon(onPressed: onPressed, icon: Icon(icon), label: child),
    );
  }
}


