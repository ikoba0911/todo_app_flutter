import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:todo_app_flutter/Model/todo.dart';
import 'package:todo_app_flutter/Repository/todo_repository.dart';

class HomeBloc {
  // Todo fetch from repository.
  // Value retrieval is done asynchronously.

  final _repository = TodoRepository();
  final _todoFetcher = PublishSubject<List<Todo>>();

  // Bind values with StreamBuilder
  Stream<List<Todo>> get allTodo => _todoFetcher.stream;

  void fetchAllTodo() async {
    List<Todo> todoList = await _repository.fetchAllProvider();
    _todoFetcher.sink.add(todoList);
  }

  dispose() {
    _todoFetcher.close();
  }
}
