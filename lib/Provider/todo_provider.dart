import 'package:todo_app_flutter/Model/todo.dart';

class TodoProvider {
  // Layer to retrieve data from Local and the Web.

  Future<List<Todo>> fetchTodoList() async {
    return mockTodoData();
  }
}

extension MockTodoData on TodoProvider {
  List<Todo> mockTodoData() {
    return [
      Todo(01, 'Task１'),
      Todo(02, 'Task2'),
      Todo(03, 'Task3'),
    ];
  }
}
