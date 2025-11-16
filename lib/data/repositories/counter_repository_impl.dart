import 'package:basic_project/core/result.dart';
import 'package:basic_project/data/db/daos/counters_dao.dart';
import 'package:basic_project/domain/entities/counter.dart';
import 'package:basic_project/domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CountersDao countersDao;
  CounterRepositoryImpl(this.countersDao);

  @override
  Future<Result<Counter>> get() async {
    try {
      final value = await countersDao.getValue();
      return Success(Counter(value));
    } catch (e, s) {
      return Failure(e, s);
    }
  }

  @override
  Future<Result<Counter>> increment() async {
    try {
      final value = await countersDao.increment();
      return Success(Counter(value));
    } catch (e, s) {
      return Failure(e, s);
    }
  }

  @override
  Future<Result<void>> reset() async {
    try {
      await countersDao.reset();
      return const Success(null);
    } catch (e, s) {
      return Failure(e, s);
    }
  }
}


