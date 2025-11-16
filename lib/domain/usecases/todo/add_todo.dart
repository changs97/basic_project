import 'package:basic_project/domain/repositories/todo_repository.dart';

class UseCaseAddTodo {
  final TodoRepository repository;
  UseCaseAddTodo(this.repository);

  Future<int> call(String title) => repository.add(title);
}


