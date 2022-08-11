import 'package:todo_app_flutter/enum/task_state.dart';

class Todo {
  int id;
  String title;
  TaskState state;

  Todo({required int id, required String title, required TaskState state})
      : this.id = id,
        this.title = title,
        this.state = state;
}
