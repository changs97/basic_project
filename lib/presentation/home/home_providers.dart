import 'package:basic_project/core/config.dart';
import 'package:basic_project/data/db/app_database.dart';
import 'package:basic_project/data/db/daos/counters_dao.dart';
import 'package:basic_project/data/repositories/counter_repository_impl.dart';
import 'package:basic_project/data/repositories/counter_repository_mock.dart';
import 'package:basic_project/domain/repositories/counter_repository.dart';
import 'package:basic_project/domain/usecases/get_counter.dart';
import 'package:basic_project/domain/usecases/increment_counter.dart';
import 'package:basic_project/domain/usecases/reset_counter.dart';
import 'package:basic_project/presentation/counter/counter_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Config
final appConfigProvider = configProvider;

// Drift
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() {
    db.close();
  });
  return db;
});

// Drift DAO (코드생성 기반)
final countersDaoProvider = Provider<CountersDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return CountersDao(db);
});

final counterRepositoryProvider = Provider<CounterRepository>((ref) {
  final cfg = ref.watch(appConfigProvider);
  if (cfg.isTestMode) {
    return CounterRepositoryMock();
  }
  final dao = ref.watch(countersDaoProvider);
  return CounterRepositoryImpl(dao);
});

final getCounterProvider = Provider<UseCaseGetCounter>((ref) {
  final repo = ref.watch(counterRepositoryProvider);
  return UseCaseGetCounter(repo);
});

final incrementCounterProvider = Provider<UseCaseIncrementCounter>((ref) {
  final repo = ref.watch(counterRepositoryProvider);
  return UseCaseIncrementCounter(repo);
});

final resetCounterProvider = Provider<UseCaseResetCounter>((ref) {
  final repo = ref.watch(counterRepositoryProvider);
  return UseCaseResetCounter(repo);
});

final counterViewModelProvider =
    StateNotifierProvider<CounterViewModel, CounterState>((ref) {
  final get = ref.watch(getCounterProvider);
  final inc = ref.watch(incrementCounterProvider);
  final reset = ref.watch(resetCounterProvider);
  final vm = CounterViewModel(getCounter: get, incrementCounter: inc, resetCounter: reset);
  // 초기 로드
  vm.load();
  return vm;
});


