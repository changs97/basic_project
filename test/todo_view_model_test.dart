import 'dart:async';
import 'package:basic_project/data/db/models/todo_item.dart';
import 'package:basic_project/domain/repositories/todo_repository.dart';
import 'package:basic_project/domain/usecases/todo/add_todo.dart';
import 'package:basic_project/domain/usecases/todo/get_todos.dart';
import 'package:basic_project/domain/usecases/todo/remove_todo.dart';
import 'package:basic_project/domain/usecases/todo/toggle_todo_done.dart';
import 'package:basic_project/domain/usecases/todo/update_todo_title.dart';
import 'package:basic_project/domain/usecases/todo/watch_todos.dart';
import 'package:basic_project/presentation/todo/todo_view_model.dart';
import 'package:basic_project/base/logger.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeTodoRepo implements TodoRepository {
  final List<TodoItem> _items = [];
  final _controller = StreamController<List<TodoItem>>.broadcast();
  int _id = 0;

  void _emit() => _controller.add(List.unmodifiable(_items));

  @override
  Future<int> add(String title) async {
    _items.insert(0, TodoItem(id: ++_id, title: title, done: false, createdAt: DateTime.now()));
    _emit();
    return _id;
  }

  @override
  Future<List<TodoItem>> getAll() async => List.unmodifiable(_items);

  @override
  Future<int> remove(int id) async {
    _items.removeWhere((e) => e.id == id);
    _emit();
    return 1;
  }

  @override
  Future<int> toggleDone(int id, bool done) async {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx != -1) {
      final it = _items[idx];
      _items[idx] = TodoItem(id: it.id, title: it.title, done: done, createdAt: it.createdAt);
      _emit();
    }
    return 1;
  }

  @override
  Future<int> updateTitle(int id, String title) async {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx != -1) {
      final it = _items[idx];
      _items[idx] = TodoItem(id: it.id, title: title, done: it.done, createdAt: it.createdAt);
      _emit();
    }
    return 1;
  }

  @override
  Stream<List<TodoItem>> watchAll() => _controller.stream;
}

void main() {
  setUpAll(() {
    Logger.minLevel = LogLevel.none;
  });
  test('TodoViewModel add/update/remove', () async {
    final repo = _FakeTodoRepo();
    final vm = TodoViewModel(
      getTodos: UseCaseGetTodos(repo),
      watchTodos: UseCaseWatchTodos(repo),
      addTodo: UseCaseAddTodo(repo),
      updateTodoTitle: UseCaseUpdateTodoTitle(repo),
      toggleTodoDone: UseCaseToggleTodoDone(repo),
      removeTodo: UseCaseRemoveTodo(repo),
    );
    await vm.load();
    expect(vm.state.items.length, 0);
    vm.watch();

    await vm.add('A');
    expect(vm.state.items.length, 1);
    final id = vm.state.items.first.id;

    await vm.updateTitle(id, 'B');
    expect(vm.state.items.first.title, 'B');

    await vm.toggle(id, true);
    expect(vm.state.items.first.done, true);

    await vm.remove(id);
    expect(vm.state.items.length, 0);
  });
}


