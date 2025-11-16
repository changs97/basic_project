import 'dart:async';

import 'package:basic_project/base/navigation/app_routes.dart';
import 'package:basic_project/base/navigation/router.dart';
import 'package:basic_project/base/navigation/navigation_service.dart';
import 'package:basic_project/base/logger.dart';
import 'package:basic_project/core/result.dart';
import 'package:basic_project/domain/entities/counter.dart';
import 'package:basic_project/domain/repositories/counter_repository.dart';
import 'package:basic_project/data/db/models/todo_item.dart';
import 'package:basic_project/domain/repositories/todo_repository.dart';
import 'package:basic_project/presentation/home/home_providers.dart';
import 'package:basic_project/presentation/todo/todo_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home navigates to routes', (tester) async {
    // Silence logs for cleaner test output
    Logger.minLevel = LogLevel.none;

    // Fake repositories to avoid real DB/path_provider in widget test
    final fakeCounterRepo = _FakeCounterRepo();
    final fakeTodoRepo = _FakeTodoRepo();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          counterRepositoryProvider.overrideWithValue(fakeCounterRepo),
          todoRepositoryProvider.overrideWithValue(fakeTodoRepo),
        ],
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRoutes.home,
        ),
      ),
    );
    expect(find.text('홈'), findsOneWidget);

    // Go to Counter by tapping the card title
    await tester.tap(find.text('카운트 화면'));
    await tester.pumpAndSettle();
    expect(find.text('카운트 화면'), findsOneWidget);

    // Back to Home
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('홈'), findsOneWidget);

    // Go to TODO by tapping the card title
    await tester.tap(find.text('TODO'));
    await tester.pumpAndSettle();
    expect(find.text('TODO'), findsOneWidget);
  });
}

class _FakeCounterRepo implements CounterRepository {
  int _v = 0;
  @override
  Future<Result<Counter>> get() async => Success(Counter(_v));
  @override
  Future<Result<Counter>> increment() async {
    _v += 1;
    return Success(Counter(_v));
  }
  @override
  Future<Result<void>> reset() async {
    _v = 0;
    return const Success(null);
  }
}

class _FakeTodoRepo implements TodoRepository {
  final _items = <TodoItem>[];
  final _controller = StreamController<List<TodoItem>>.broadcast();
  int _id = 0;
  void _emit() => _controller.add(List.unmodifiable(_items));
  @override
  Future<int> add(String title) async {
    _items.insert(0, TodoItem(id: ++_id, title: title, done: false, createdAt: DateTime.now()));
    _emit();
    return _id;
  }
  @override
  Future<List<TodoItem>> getAll() async => List.unmodifiable(_items);
  @override
  Future<int> remove(int id) async {
    _items.removeWhere((e) => e.id == id);
    _emit();
    return 1;
  }
  @override
  Future<int> toggleDone(int id, bool done) async {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx != -1) {
      final it = _items[idx];
      _items[idx] = TodoItem(id: it.id, title: it.title, done: done, createdAt: it.createdAt);
      _emit();
    }
    return 1;
  }
  @override
  Future<int> updateTitle(int id, String title) async {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx != -1) {
      final it = _items[idx];
      _items[idx] = TodoItem(id: it.id, title: title, done: it.done, createdAt: it.createdAt);
      _emit();
    }
    return 1;
  }
  @override
  Stream<List<TodoItem>> watchAll() => _controller.stream;
}


