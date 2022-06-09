import 'package:todo_app_flutter/Enum/task_state.dart';
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
      Todo(01, 'Task１', TaskState.done),
      Todo(02, 'Task2', TaskState.todo),
      Todo(03, 'Task3', TaskState.done),
    ];
  }
}
