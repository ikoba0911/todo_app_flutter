import 'package:flutter/material.dart';
import '../../Enum/task_state.dart';
import '../../Model/todo.dart';

class TodoList extends StatelessWidget {
  final Function(int) onPressedCallback;
  final AsyncSnapshot<List<Todo>> snapshot;

  const TodoList(this.snapshot, this.onPressedCallback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return ListTile(
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
        );
      },
    );
  }
}
