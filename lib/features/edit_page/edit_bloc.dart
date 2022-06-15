import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EditBloc {
  // MARK: Output
  TextEditingController taskController = TextEditingController();

  // MARK: Input
  final _taskTitleSubject = BehaviorSubject<String>.seeded('');

  // By not requiring the argument, null is returned if it is not set
  EditBloc([String? taskTitle]) {
    if (taskTitle != null) {
      taskController.text = taskTitle;
    }
  }

  String getFinalTaskTitle() {
    return _taskTitleSubject.value;
  }

  void sendTaskTitle(String task) {
    _taskTitleSubject.sink.add(task);
  }

  dispose() {
    _taskTitleSubject.close();
  }
}
