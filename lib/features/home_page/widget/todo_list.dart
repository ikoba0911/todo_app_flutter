import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_flutter/constants/constants.dart';
import 'package:todo_app_flutter/enum/task_edit_type.dart';
import 'package:todo_app_flutter/enum/task_state.dart';
import 'package:todo_app_flutter/features/edit_page/edit_page.dart';
import 'package:todo_app_flutter/model/todo.dart';


class TodoList extends StatelessWidget {
  final AsyncSnapshot<List<Todo>> snapshot;
  final Function(int) onPressedCallback;
  final Function(int) deleteTaskCallback;
  final Function(int, String, Todo) editTaskCallback;
  final Function(String, Color) snackBarCallback;

  const TodoList(this.snapshot, this.onPressedCallback, this.deleteTaskCallback,
      this.editTaskCallback, this.snackBarCallback,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.50,
            children: [
              Builder(builder: (context) {
                return SlidableAction(
                  label: sliderMenuTitleForEditing,
                  backgroundColor: Colors.blue,
                  icon: Icons.edit,
                  onPressed: (context) async {
                    final String? taskTitle = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPage(
                          type: TaskEditType.edit,
                          taskTitle: snapshot.data![index].title,
                        ),
                      ),
                    );

                    if (taskTitle != null) {
                      editTaskCallback(index, taskTitle, snapshot.data![index]);
                      snackBarCallback(snackBarMessageForEditing, Colors.green);
                    }
                  },
                );
              }),
              SlidableAction(
                label: sliderMenuTitleForDeletion,
                backgroundColor: Colors.red,
                icon: Icons.delete,
                onPressed: (context) {
                  deleteTaskCallback(index);
                  snackBarCallback(snackBarMessageForDeletion, Colors.red);
                },
              ),
            ],
          ),
          child: ListTile(
            leading: Checkbox(
              value: snapshot.data![index].state == TaskState.done,
              onChanged: (_) {},
            ),
            title: Text(
              snapshot.data![index].title,
              style: snapshot.data![index].state == TaskState.done
                  ? const TextStyle(
                      decoration: TextDecoration.lineThrough,
                    )
                  : null,
            ),
            onTap: () {
              onPressedCallback(index);
            },
          ),
        );
      },
    );
  }
}
