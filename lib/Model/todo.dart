import 'package:todo_app_flutter/Enum/task_state.dart';

class Todo {
  int id;
  String title;
  TaskState state;
  Todo(this.id, this.title, this.state);
}
