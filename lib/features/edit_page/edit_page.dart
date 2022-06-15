import 'package:flutter/material.dart';
import 'package:todo_app_flutter/constants/constants.dart';
import 'package:todo_app_flutter/enum/task_edit_type.dart';
import 'package:todo_app_flutter/features/edit_page/edit_bloc.dart';

class EditPage extends StatelessWidget {
  final TaskEditType? type;
  EditBloc bloc = EditBloc();

  EditPage(this.type, String? taskTitle) {
    if (taskTitle != null) {
      bloc = EditBloc(taskTitle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type?.pageTitle ?? ''),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: bloc.taskController,
                decoration: const InputDecoration(
                  hintText: placeholdersForInputFields,
                ),
                onChanged: (text) {
                  bloc.sendTaskTitle(text);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(bloc.getFinalTaskTitle());
                },
                child: Text(type?.buttonTitle ?? ''),
              )
            ],
          ),
        ),
      ),
    );
  }
}
