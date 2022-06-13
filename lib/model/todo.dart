import '../enum/task_state.dart';

class Todo {
  int id;
  String title;
  TaskState state;
  Todo(this.id, this.title, this.state);
}
