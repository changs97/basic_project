import 'package:basic_project/core/result.dart';
import 'package:basic_project/domain/entities/counter.dart';
import 'package:basic_project/domain/repositories/counter_repository.dart';

class UseCaseIncrementCounter {
  final CounterRepository repository;
  const UseCaseIncrementCounter(this.repository);

  Future<Result<Counter>> call() {
    return repository.increment();
  }
}


