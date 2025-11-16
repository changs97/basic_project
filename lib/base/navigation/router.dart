import 'package:basic_project/base/navigation/app_routes.dart';
import 'package:basic_project/presentation/counter/counter_page.dart';
import 'package:basic_project/presentation/home/home_page.dart';
import 'package:basic_project/presentation/todo/todo_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage(), settings: settings);
      case AppRoutes.counter:
        return MaterialPageRoute(builder: (_) => const CounterPage(), settings: settings);
      case AppRoutes.todo:
        return MaterialPageRoute(builder: (_) => const TodoPage(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
          settings: settings,
        );
    }
  }
}


