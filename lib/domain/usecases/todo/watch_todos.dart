import 'package:basic_project/data/db/models/todo_item.dart';
import 'package:basic_project/domain/repositories/todo_repository.dart';

class UseCaseWatchTodos {
  final TodoRepository repository;
  UseCaseWatchTodos(this.repository);

  Stream<List<TodoItem>> call() => repository.watchAll();
}


