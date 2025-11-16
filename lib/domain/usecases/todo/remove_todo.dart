import 'package:basic_project/domain/repositories/todo_repository.dart';

class UseCaseRemoveTodo {
  final TodoRepository repository;
  UseCaseRemoveTodo(this.repository);

  Future<int> call(int id) => repository.remove(id);
}


