import 'package:todo_app_flutter/constants/constants.dart';
import 'package:todo_app_flutter/enum/task_state.dart';
import 'package:todo_app_flutter/model/todo.dart';

class TodoProvider {
  // Layer to retrieve data from Local and the Web.

  Future<List<Todo>> fetchTodoList() async {
    return mockTodoData();
  }
}

extension MockTodoData on TodoProvider {
  List<Todo> mockTodoData() {
    return [
      Todo(id: 00, title: demoTaskMessage1, state: TaskState.todo),
      Todo(id: 01, title: demoTaskMessage2, state: TaskState.done),
      Todo(id: 02, title: demoTaskMessage3, state: TaskState.todo),
      Todo(id: 03, title: demoTaskMessage4, state: TaskState.todo),
    ];
  }
}
