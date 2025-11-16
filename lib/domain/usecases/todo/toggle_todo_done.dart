import 'package:basic_project/domain/repositories/todo_repository.dart';

class UseCaseToggleTodoDone {
  final TodoRepository repository;
  UseCaseToggleTodoDone(this.repository);

  Future<int> call(int id, bool done) => repository.toggleDone(id, done);
}


