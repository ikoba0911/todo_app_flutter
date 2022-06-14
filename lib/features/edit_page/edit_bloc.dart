import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EditBloc {
  // MARK: Output
  TextEditingController taskController = TextEditingController();

  // MARK: Input
  final _submitSubject = PublishSubject<void>();
  final _taskTitleSubject = PublishSubject<String>();

  void submit() {
    _submitSubject.sink;
  }

  void editTask(String task) {
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
