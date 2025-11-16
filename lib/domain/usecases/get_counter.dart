import 'package:basic_project/core/result.dart';
import 'package:basic_project/domain/entities/counter.dart';
import 'package:basic_project/domain/repositories/counter_repository.dart';

class UseCaseGetCounter {
  final CounterRepository repository;
  const UseCaseGetCounter(this.repository);

  Future<Result<Counter>> call() {
    return repository.get();
  }
}


