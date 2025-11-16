import 'package:basic_project/data/db/app_database.dart';
import 'package:basic_project/data/db/tables/tables.dart';
import 'package:drift/drift.dart';

part 'counters_dao.g.dart';

@DriftAccessor(tables: [Counters])
class CountersDao extends DatabaseAccessor<AppDatabase> with _$CountersDaoMixin {
  CountersDao(AppDatabase db) : super(db);

  Future<void> _ensureRow() async {
    await into(counters).insert(
      CountersCompanion.insert(
        id: const Value(1),
        value: const Value(0),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  Future<int> getValue() async {
    await _ensureRow();
    final row =
        await (select(counters)..where((t) => t.id.equals(1))).getSingle();
    return row.value;
  }

  Future<int> increment() async {
    await _ensureRow();
    return transaction(() async {
      final current = await getValue();
      await (update(counters)..where((t) => t.id.equals(1))).write(
        CountersCompanion(value: Value(current + 1)),
      );
      return current + 1;
    });
  }

  Future<void> reset() async {
    await _ensureRow();
    await (update(counters)..where((t) => t.id.equals(1))).write(
      const CountersCompanion(value: Value(0)),
    );
  }

  Stream<int> watchValue() async* {
    await _ensureRow();
    yield* (select(counters)..where((t) => t.id.equals(1)))
        .watchSingle()
        .map((row) => row.value);
  }
}

