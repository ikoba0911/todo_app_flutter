import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EditBloc {
  // MARK: Output
  TextEditingController taskController = TextEditingController();

  // MARK: Input
  final _submitSubject = PublishSubject<void>();
  final _taskTitleSubject = BehaviorSubject<String>();

  String getFinalTaskTitle() {
    return _taskTitleSubject.value;
  }

  void sendTaskTitle(String task) {
    _taskTitleSubject.sink.add(task);
  }

  EditBloc() {
    // data binding
    _bind();
  }

  void _bind() {}

  dispose() {
    _submitSubject.close();
    _taskTitleSubject.close();
  }
}
