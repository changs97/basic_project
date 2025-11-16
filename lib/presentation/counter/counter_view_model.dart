import 'package:basic_project/core/result.dart';
import 'package:basic_project/domain/entities/counter.dart';
import 'package:basic_project/domain/usecases/get_counter.dart';
import 'package:basic_project/domain/usecases/increment_counter.dart';
import 'package:basic_project/domain/usecases/reset_counter.dart';
import 'package:basic_project/base/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterState {
  final Counter counter;
  final bool isLoading;
  final String? errorMessage;

  const CounterState({
    required this.counter,
    this.isLoading = false,
    this.errorMessage,
  });

  CounterState copyWith({
    Counter? counter,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class CounterViewModel extends StateNotifier<CounterState> {
  final UseCaseGetCounter getCounter;
  final UseCaseIncrementCounter incrementCounter;
  final UseCaseResetCounter resetCounter;

  CounterViewModel({
    required this.getCounter,
    required this.incrementCounter,
    required this.resetCounter,
  }) : super(const CounterState(counter: Counter(0)));

  Future<void> load() async {
    logI('CounterViewModel.load()');
    state = state.copyWith(isLoading: true, errorMessage: null);
    final res = await getCounter();
    switch (res) {
      case Success(value: final counter):
        logD('Counter loaded: ${counter.value}');
        state = state.copyWith(counter: counter, isLoading: false);
      case Failure(error: final error):
        logE('Counter load error', error: error);
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
    }
  }

  Future<void> increment() async {
    logI('CounterViewModel.increment()');
    final res = await incrementCounter();
    switch (res) {
      case Success(value: final counter):
        logD('Counter incremented: ${counter.value}');
        state = state.copyWith(counter: counter);
      case Failure(error: final error):
        logE('Counter increment error', error: error);
        state = state.copyWith(errorMessage: error.toString());
    }
  }

  Future<void> reset() async {
    logI('CounterViewModel.reset()');
    final res = await resetCounter();
    switch (res) {
      case Success():
        logD('Counter reset success');
        await load();
      case Failure(error: final error):
        logE('Counter reset error', error: error);
        state = state.copyWith(errorMessage: error.toString());
    }
  }
}


