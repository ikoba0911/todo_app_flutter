import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app_flutter/enum/task_state.dart';
import 'package:todo_app_flutter/model/todo.dart';
import 'package:todo_app_flutter/repository/todo_repository.dart';


@immutable
class TaskEditModel {
  final int taskIndex;
  final Todo todo;

  const TaskEditModel(this.taskIndex, this.todo);
}

class HomeBloc {
  // Todo fetch from repository.
  // Value retrieval is done asynchronously.
  final _repository = TodoRepository();
  final _todoFetcher = PublishSubject<List<Todo>>();

  // MARK: Output
  BehaviorSubject<List<Todo>> listDataSource =
      BehaviorSubject<List<Todo>>.seeded([]);

  // MARK: Input
  final _updateCheckSubject = PublishSubject<int>();
  final _addTaskSubject = PublishSubject<Todo>();
  final _deleteTaskSubject = PublishSubject<int>();
  final _editTaskSubject = PublishSubject<TaskEditModel>();

  void fetchAllTodo() async {
    List<Todo> todoList = await _repository.fetchAllProvider();
    _todoFetcher.add(todoList);
  }

  void updateTaskState(int index) {
    _updateCheckSubject.add(index);
  }

  void addTask(Todo todo) {
    _addTaskSubject.add(todo);
  }

  void deleteTask(int index) {
    _deleteTaskSubject.add(index);
  }

  void editTask(int index, String taskTitle, Todo selectedTodo) {
    Todo currentTodo = selectedTodo;
    currentTodo.title = taskTitle;
    _editTaskSubject.add(TaskEditModel(index, currentTodo));
  }

  HomeBloc() {
    // data binding
    _bind();
  }

  void _bind() {
    // fetch
    _todoFetcher.stream.listen((todoList) {
      listDataSource.sink.add(todoList);
    });

    // update
    _updateCheckSubject.stream.listen((index) {
      List<Todo> currentTodoList = listDataSource.value;
      final isDone = currentTodoList[index].state == TaskState.done;
      currentTodoList[index].state = isDone ? TaskState.todo : TaskState.done;
      listDataSource.add(currentTodoList);
    });

    // add
    _addTaskSubject.stream.listen((todo) {
      List<Todo> currentTodoList = listDataSource.value;
      currentTodoList.add(todo);
      listDataSource.add(currentTodoList);
    });

    // delete
    _deleteTaskSubject.stream.listen((index) {
      List<Todo> currentTodoList = listDataSource.value;
      currentTodoList.removeAt(index);
      listDataSource.add(currentTodoList);
    });

    // edit
    _editTaskSubject.stream.listen((editModel) {
      List<Todo> currentTodoList = listDataSource.value;
      currentTodoList[editModel.taskIndex] = editModel.todo;
      listDataSource.add(currentTodoList);
    });
  }

  dispose() {
    listDataSource.close();
    _todoFetcher.close();
    _updateCheckSubject.close();
    _addTaskSubject.close();
    _deleteTaskSubject.close();
    _editTaskSubject.close();
  }
}
