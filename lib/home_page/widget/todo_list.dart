import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../Enum/task_state.dart';
import '../../Model/todo.dart';

class TodoList extends StatelessWidget {
  final Function(int) onPressedCallback;
  final Function(int) deleteTaskCallback;
  final Function(int) editTaskCallback;
  final AsyncSnapshot<List<Todo>> snapshot;

  const TodoList(
      this.snapshot,
      this.onPressedCallback,
      this.deleteTaskCallback,
      this.editTaskCallback,
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
                  label: 'Edit',
                  backgroundColor: Colors.blue,
                  icon: Icons.edit,
                  onPressed: (context) {
                    editTaskCallback(index);
                  },
                );
              }),
              SlidableAction(
                label: 'Delete',
                backgroundColor: Colors.red,
                icon: Icons.delete,
                onPressed: (context) {
                  deleteTaskCallback(index);
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
