import 'dart:async';

import 'package:basic_project/data/db/models/todo_item.dart';

abstract class TodoRepository {
  Future<List<TodoItem>> getAll();
  Stream<List<TodoItem>> watchAll();
  Future<int> add(String title);
  Future<int> updateTitle(int id, String title);
  Future<int> toggleDone(int id, bool done);
  Future<int> remove(int id);
}


