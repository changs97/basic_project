import 'package:basic_project/base/navigation/app_routes.dart';
import 'package:basic_project/base/navigation/navigation_service.dart';
import 'package:basic_project/base/navigation/router.dart';
import 'package:basic_project/base/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Project',
      theme: BaseTheme.light(),
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
