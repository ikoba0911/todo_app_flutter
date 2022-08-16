import 'package:flutter/material.dart';
import 'package:todo_app_flutter/constants/constants.dart';
import 'package:todo_app_flutter/enum/task_edit_type.dart';
import 'package:todo_app_flutter/features/edit_page/edit_bloc.dart';

class EditPage extends StatefulWidget {
  final TaskEditType? _type;
  final String? _taskTitle;

  EditPage({required TaskEditType? type, required String? taskTitle})
      : this._type = type,
        this._taskTitle = taskTitle;

  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  EditBloc _bloc = EditBloc();

  @override
  void initState() {
    super.initState();
    _bloc = EditBloc(widget._taskTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._type?.pageTitle ?? ''),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _bloc.taskController,
                decoration: const InputDecoration(
                  hintText: placeholdersForInputFields,
                ),
                onChanged: (text) {
                  _bloc.sendTaskTitle(text);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_bloc.getFinalTaskTitle());
                },
                child: Text(widget._type?.buttonTitle ?? ''),
              )
            ],
          ),
        ),
      ),
    );
  }
}
