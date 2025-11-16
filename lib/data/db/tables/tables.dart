import 'package:drift/drift.dart';

class Counters extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get value => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}


