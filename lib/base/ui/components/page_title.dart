import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;
  final String? subtitle;
  const PageTitle({super.key, required this.text, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: theme.headlineMedium),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle!, style: theme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
        ],
      ],
    );
  }
}


