import 'package:basic_project/core/result.dart';
import 'package:basic_project/base/logger.dart';
import 'package:basic_project/domain/entities/counter.dart';
import 'package:basic_project/domain/repositories/counter_repository.dart';
import 'package:basic_project/presentation/counter/counter_page.dart';
import 'package:basic_project/presentation/home/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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

void main() {
  testWidgets('CounterPage increments and resets', (tester) async {
    Logger.minLevel = LogLevel.none;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          counterRepositoryProvider.overrideWithValue(_FakeCounterRepo()),
        ],
        child: const MaterialApp(home: CounterPage()),
      ),
    );

    // 초기 로드 완료 대기
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('counter_value')), findsOneWidget);
    expect(find.text('Counter: 0'), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);
    expect(find.text('리셋'), findsOneWidget);

    // 증가 버튼 탭
    await tester.tap(find.text('증가'));
    await tester.pumpAndSettle();
    expect(find.text('Counter: 1'), findsOneWidget);

    // 리셋 버튼 탭
    await tester.tap(find.text('리셋'));
    await tester.pumpAndSettle();
    expect(find.text('Counter: 0'), findsOneWidget);
  });
}


