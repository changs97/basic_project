import 'package:basic_project/core/result.dart';
import 'package:basic_project/base/logger.dart';
import 'package:basic_project/domain/entities/counter.dart';
import 'package:basic_project/domain/repositories/counter_repository.dart';
import 'package:basic_project/domain/usecases/get_counter.dart';
import 'package:basic_project/domain/usecases/increment_counter.dart';
import 'package:basic_project/domain/usecases/reset_counter.dart';
import 'package:basic_project/presentation/counter/counter_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeCounterRepo implements CounterRepository {
  int _value = 0;
  @override
  Future<Result<Counter>> get() async => Success(Counter(_value));
  @override
  Future<Result<Counter>> increment() async {
    _value += 1;
    return Success(Counter(_value));
  }
  @override
  Future<Result<void>> reset() async {
    _value = 0;
    return const Success(null);
  }
}

class _FailCounterRepo implements CounterRepository {
  @override
  Future<Result<Counter>> get() async => Failure(Exception('fail'));
  @override
  Future<Result<Counter>> increment() async => Failure(Exception('fail'));
  @override
  Future<Result<void>> reset() async => Failure(Exception('fail'));
}

void main() {
  setUpAll(() {
    // Silence logs in tests
    Logger.minLevel = LogLevel.none;
  });
  test('Counter ViewModel load/increment/reset', () async {
    final repo = _FakeCounterRepo();
    final vm = CounterViewModel(
      getCounter: UseCaseGetCounter(repo),
      incrementCounter: UseCaseIncrementCounter(repo),
      resetCounter: UseCaseResetCounter(repo),
    );

    final loadFuture = vm.load();
    expect(vm.state.isLoading, true);
    await loadFuture;
    expect(vm.state.counter.value, 0);
    await vm.increment();
    expect(vm.state.counter.value, 1);
    await vm.reset();
    expect(vm.state.counter.value, 0);
  });

  test('Counter ViewModel load failure sets error', () async {
    final failingRepo = _FailCounterRepo();
    final vm = CounterViewModel(
      getCounter: UseCaseGetCounter(failingRepo),
      incrementCounter: UseCaseIncrementCounter(failingRepo),
      resetCounter: UseCaseResetCounter(failingRepo),
    );
    await vm.load();
    expect(vm.state.isLoading, false);
    expect(vm.state.errorMessage, isNotNull);
  });
}


