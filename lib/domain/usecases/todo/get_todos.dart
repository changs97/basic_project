import 'package:basic_project/data/db/models/todo_item.dart';
import 'package:basic_project/domain/repositories/todo_repository.dart';

class UseCaseGetTodos {
  final TodoRepository repository;
  UseCaseGetTodos(this.repository);

  Future<List<TodoItem>> call() => repository.getAll();
}


