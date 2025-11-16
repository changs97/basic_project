import 'package:basic_project/core/result.dart';
import 'package:basic_project/domain/entities/counter.dart';

abstract class CounterRepository {
  Future<Result<Counter>> get();
  Future<Result<Counter>> increment();
  Future<Result<void>> reset();
}


