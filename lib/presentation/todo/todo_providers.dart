import 'package:basic_project/data/db/daos/todos_dao.dart';
import 'package:basic_project/data/repositories/todo_repository_impl.dart';
import 'package:basic_project/domain/repositories/todo_repository.dart';
import 'package:basic_project/domain/usecases/todo/add_todo.dart';
import 'package:basic_project/domain/usecases/todo/get_todos.dart';
import 'package:basic_project/domain/usecases/todo/remove_todo.dart';
import 'package:basic_project/domain/usecases/todo/toggle_todo_done.dart';
import 'package:basic_project/domain/usecases/todo/update_todo_title.dart';
import 'package:basic_project/domain/usecases/todo/watch_todos.dart';
import 'package:basic_project/presentation/home/home_providers.dart';
import 'package:basic_project/presentation/todo/todo_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todosDaoProvider = Provider<TodosDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TodosDao(db);
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final dao = ref.watch(todosDaoProvider);
  return TodoRepositoryImpl(dao);
});

final getTodosProvider = Provider<UseCaseGetTodos>((ref) {
  final repo = ref.watch(todoRepositoryProvider);
  return UseCaseGetTodos(repo);
});

final watchTodosProvider = Provider<UseCaseWatchTodos>((ref) {
  final repo = ref.watch(todoRepositoryProvider);
  return UseCaseWatchTodos(repo);
});

final addTodoProvider = Provider<UseCaseAddTodo>((ref) {
  final repo = ref.watch(todoRepositoryProvider);
  return UseCaseAddTodo(repo);
});

final updateTodoTitleProvider = Provider<UseCaseUpdateTodoTitle>((ref) {
  final repo = ref.watch(todoRepositoryProvider);
  return UseCaseUpdateTodoTitle(repo);
});

final toggleTodoDoneProvider = Provider<UseCaseToggleTodoDone>((ref) {
  final repo = ref.watch(todoRepositoryProvider);
  return UseCaseToggleTodoDone(repo);
});

final removeTodoProvider = Provider<UseCaseRemoveTodo>((ref) {
  final repo = ref.watch(todoRepositoryProvider);
  return UseCaseRemoveTodo(repo);
});

final todoViewModelProvider =
    StateNotifierProvider<TodoViewModel, TodoState>((ref) {
  final vm = TodoViewModel(
    getTodos: ref.watch(getTodosProvider),
    watchTodos: ref.watch(watchTodosProvider),
    addTodo: ref.watch(addTodoProvider),
    updateTodoTitle: ref.watch(updateTodoTitleProvider),
    toggleTodoDone: ref.watch(toggleTodoDoneProvider),
    removeTodo: ref.watch(removeTodoProvider),
  );
  vm.load();
  vm.watch();
  return vm;
});


