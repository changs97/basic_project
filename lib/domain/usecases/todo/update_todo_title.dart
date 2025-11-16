import 'package:basic_project/domain/repositories/todo_repository.dart';

class UseCaseUpdateTodoTitle {
  final TodoRepository repository;
  UseCaseUpdateTodoTitle(this.repository);

  Future<int> call(int id, String title) => repository.updateTitle(id, title);
}


