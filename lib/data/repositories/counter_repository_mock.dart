import 'dart:async';

import 'package:basic_project/core/result.dart';
import 'package:basic_project/domain/entities/counter.dart';
import 'package:basic_project/domain/repositories/counter_repository.dart';

class CounterRepositoryMock implements CounterRepository {
  int _value = 42;

  Duration get _latency => const Duration(milliseconds: 200);

  @override
  Future<Result<Counter>> get() async {
    await Future<void>.delayed(_latency);
    return Success(Counter(_value));
  }

  @override
  Future<Result<Counter>> increment() async {
    await Future<void>.delayed(_latency);
    _value += 1;
    return Success(Counter(_value));
  }

  @override
  Future<Result<void>> reset() async {
    await Future<void>.delayed(_latency);
    _value = 0;
    return const Success(null);
  }
}


