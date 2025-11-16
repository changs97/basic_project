import 'package:basic_project/data/db/app_database.dart';
import 'package:basic_project/data/db/models/todo_item.dart';
import 'package:basic_project/data/db/tables/tables.dart';
import 'package:drift/drift.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  TodosDao(AppDatabase db) : super(db);

  Future<List<TodoItem>> getAll() async {
    final rows = await (select(todos)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
    return rows
        .map((r) => TodoItem(id: r.id, title: r.title, done: r.done, createdAt: r.createdAt))
        .toList();
  }

  Stream<List<TodoItem>> watchAll() {
    return (select(todos)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch().map((rows) =>
        rows.map((r) => TodoItem(id: r.id, title: r.title, done: r.done, createdAt: r.createdAt)).toList());
  }

  Future<int> insertTodo(String title) {
    return into(todos).insert(TodosCompanion.insert(title: title));
  }

  Future<int> toggleDone(int id, bool done) {
    return (update(todos)..where((t) => t.id.equals(id))).write(TodosCompanion(done: Value(done)));
  }

  Future<int> updateTitle(int id, String title) {
    return (update(todos)..where((t) => t.id.equals(id))).write(TodosCompanion(title: Value(title)));
  }

  Future<int> deleteById(int id) {
    return (delete(todos)..where((t) => t.id.equals(id))).go();
  }
}

