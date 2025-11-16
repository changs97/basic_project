import 'package:basic_project/base/navigation/app_routes.dart';
import 'package:basic_project/base/navigation/navigation_service.dart';
import 'package:basic_project/base/ui/components/app_app_bar.dart';
import 'package:basic_project/base/ui/components/primary_button.dart';
import 'package:basic_project/base/ui/components/secondary_button.dart';
import 'package:basic_project/base/theme/spacing.dart';
import 'package:basic_project/base/logger.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    logI('Enter HomePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: '홈'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Insets.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MenuCard(
                icon: Icons.exposure_plus_1,
                title: '카운트 화면',
                subtitle: '간단한 카운터 데모',
                button: PrimaryButton(
                  label: '이동',
                  onPressed: () => context.pushNamedSafe(AppRoutes.counter),
                  icon: Icons.arrow_forward,
                ),
                onTap: () => context.pushNamedSafe(AppRoutes.counter),
              ),
              const SizedBox(height: Insets.lg),
              _MenuCard(
                icon: Icons.checklist,
                title: 'TODO',
                subtitle: '할 일 목록 관리',
                button: PrimaryButton(
                  label: '이동',
                  onPressed: () => context.pushNamedSafe(AppRoutes.todo),
                  icon: Icons.arrow_forward,
                ),
                onTap: () => context.pushNamedSafe(AppRoutes.todo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget button;
  final VoidCallback onTap;
  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.button,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Corners.lg),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Corners.lg),
          border: Border.all(color: scheme.outlineVariant),
          color: scheme.surface,
        ),
        padding: const EdgeInsets.all(Insets.lg),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: scheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(Insets.md),
              child: Icon(icon, color: scheme.primary),
            ),
            const SizedBox(width: Insets.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: scheme.onSurface.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Insets.lg),
            SizedBox(width: 100, child: button),
          ],
        ),
      ),
    );
  }
}


