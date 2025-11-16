import 'package:basic_project/core/result.dart';
import 'package:basic_project/domain/repositories/counter_repository.dart';

class UseCaseResetCounter {
  final CounterRepository repository;
  const UseCaseResetCounter(this.repository);

  Future<Result<void>> call() {
    return repository.reset();
  }
}


