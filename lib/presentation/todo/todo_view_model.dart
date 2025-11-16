import 'package:basic_project/data/db/models/todo_item.dart';
import 'package:basic_project/base/logger.dart';
import 'package:basic_project/domain/usecases/todo/add_todo.dart';
import 'package:basic_project/domain/usecases/todo/get_todos.dart';
import 'package:basic_project/domain/usecases/todo/remove_todo.dart';
import 'package:basic_project/domain/usecases/todo/toggle_todo_done.dart';
import 'package:basic_project/domain/usecases/todo/update_todo_title.dart';
import 'package:basic_project/domain/usecases/todo/watch_todos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoState {
  final List<TodoItem> items;
  final bool isLoading;
  final String? errorMessage;
  const TodoState({
    required this.items,
    this.isLoading = false,
    this.errorMessage,
  });
  TodoState copyWith({
    List<TodoItem>? items,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TodoState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class TodoViewModel extends StateNotifier<TodoState> {
  final UseCaseGetTodos getTodos;
  final UseCaseWatchTodos watchTodos;
  final UseCaseAddTodo addTodo;
  final UseCaseUpdateTodoTitle updateTodoTitle;
  final UseCaseToggleTodoDone toggleTodoDone;
  final UseCaseRemoveTodo removeTodo;

  TodoViewModel({
    required this.getTodos,
    required this.watchTodos,
    required this.addTodo,
    required this.updateTodoTitle,
    required this.toggleTodoDone,
    required this.removeTodo,
  }) : super(const TodoState(items: []));

  Future<void> load() async {
    logI('TodoViewModel.load()');
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await getTodos();
      logD('Todos loaded: ${items.length}');
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      logE('Todos load error', error: e);
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void watch() {
    watchTodos().listen((items) {
      logD('Todos changed: ${items.length}');
      state = state.copyWith(items: items);
    });
  }

  Future<void> add(String title) async {
    logI('TodoViewModel.add($title)');
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      await addTodo(title);
    } catch (e) {
      logE('Todo add error', error: e);
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> toggle(int id, bool done) async {
    logI('TodoViewModel.toggle(id=$id, done=$done)');
    try {
      await toggleTodoDone(id, done);
    } catch (e) {
      logE('Todo toggle error', error: e);
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> updateTitle(int id, String title) async {
    logI('TodoViewModel.updateTitle(id=$id, title=$title)');
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      await updateTodoTitle(id, title);
    } catch (e) {
      logE('Todo update error', error: e);
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> remove(int id) async {
    logI('TodoViewModel.remove(id=$id)');
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      await removeTodo(id);
    } catch (e) {
      logE('Todo remove error', error: e);
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}


