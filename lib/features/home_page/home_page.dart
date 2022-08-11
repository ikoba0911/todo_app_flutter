import 'package:flutter/material.dart';
import 'package:todo_app_flutter/constants/constants.dart';
import 'package:todo_app_flutter/enum/task_edit_type.dart';
import 'package:todo_app_flutter/enum/task_state.dart';
import 'package:todo_app_flutter/features/edit_page/edit_page.dart';
import 'package:todo_app_flutter/features/home_page/home_bloc.dart';
import 'package:todo_app_flutter/features/home_page/widget/todo_list.dart';
import 'package:todo_app_flutter/model/todo.dart';
import 'dart:math' as math;



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeBloc();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _bloc.fetchAllTodo(); // acquire the values to be displayed in the list
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePageTitle),
        ),
        body: StreamBuilder<List<Todo>>(
          initialData: _bloc.listDataSource.value,
          stream: _bloc.listDataSource.stream,
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.hasData) {
              return TodoList(snapshot, _bloc.updateTaskState, _bloc.deleteTask,
                  _bloc.editTask, _showSnackBar);
            } else if (snapshot.hasError) {
              return Text("An error has occurred. Message:${snapshot.error}");
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final String? taskTitle = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPage(
                  type: TaskEditType.add,
                  taskTitle: null,
                ),
                fullscreenDialog: true,
              ),
            );

            if (taskTitle != null) {
              final randomId = math.Random().nextInt(1000);
              _bloc.addTask(
                  Todo(id: randomId, title: taskTitle, state: TaskState.todo));
              _showSnackBar(snackBarMessageForAdditions, Colors.green);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showSnackBar(String text, Color color) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(text),
    );
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }
}
