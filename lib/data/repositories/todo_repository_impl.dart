import 'dart:async';

import 'package:basic_project/data/db/daos/todos_dao.dart';
import 'package:basic_project/data/db/models/todo_item.dart';
import 'package:basic_project/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodosDao dao;
  TodoRepositoryImpl(this.dao);

  @override
  Future<List<TodoItem>> getAll() => dao.getAll();

  @override
  Stream<List<TodoItem>> watchAll() => dao.watchAll();

  @override
  Future<int> add(String title) => dao.insertTodo(title);

  @override
  Future<int> updateTitle(int id, String title) => dao.updateTitle(id, title);

  @override
  Future<int> toggleDone(int id, bool done) => dao.toggleDone(id, done);

  @override
  Future<int> remove(int id) => dao.deleteById(id);
}


