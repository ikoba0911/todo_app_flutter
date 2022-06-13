import 'package:rxdart/rxdart.dart';
import '../../enum/task_state.dart';
import '../../model/todo.dart';
import '../../repository/todo_repository.dart';

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
  final _editTaskSubject = PublishSubject<int>();

  void fetchAllTodo() async {
    List<Todo> todoList = await _repository.fetchAllProvider();
    _todoFetcher.sink.add(todoList);
  }

  void updateTaskState(int index) {
    _updateCheckSubject.sink.add(index);
  }

  void addTask(Todo todo) {
    _addTaskSubject.sink.add(todo);
  }

  void deleteTask(int index) {
    _deleteTaskSubject.sink.add(index);
  }

  void editTask(int index) {
    _editTaskSubject.sink.add(index);
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
      listDataSource.sink.add(currentTodoList);
    });

    // add
    _addTaskSubject.stream.listen((todo) {
      List<Todo> currentTodoList = listDataSource.value;
      currentTodoList.add(todo);
      listDataSource.sink.add(currentTodoList);
    });

    // delete
    _deleteTaskSubject.stream.listen((index) {
      List<Todo> currentTodoList = listDataSource.value;
      currentTodoList.removeAt(index);
      listDataSource.sink.add(currentTodoList);
    });
  }

  dispose() {
    _todoFetcher.close();
    listDataSource.close();
  }
}
