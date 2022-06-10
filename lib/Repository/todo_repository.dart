import 'package:todo_app_flutter/Provider/todo_provider.dart';
import '../Model/todo.dart';

class TodoRepository {
  // Create this class with Dependency injection in mind.
  // The structure of the Bloc is such that it is unaware of whether it is accessing local data or data on the Web by accessing the repository.
  // Dependencies shall always be injectable and platform independent.
  final provider = TodoProvider();

  Future<List<Todo>> fetchAllProvider() => provider.fetchTodoList();
}
