import 'package:todo_app_flutter/constants/constants.dart';

import '../enum/task_state.dart';
import '../model/todo.dart';

class TodoProvider {
  // Layer to retrieve data from Local and the Web.

  Future<List<Todo>> fetchTodoList() async {
    return mockTodoData();
  }
}

extension MockTodoData on TodoProvider {
  List<Todo> mockTodoData() {
    return [
      Todo(00, demoTaskMessage1, TaskState.todo),
      Todo(01, demoTaskMessage2, TaskState.done),
      Todo(02, demoTaskMessage3, TaskState.todo),
      Todo(03, demoTaskMessage4, TaskState.todo),
    ];
  }
}
