import 'package:flutter/material.dart';
import 'package:todo_app_flutter/features/edit_page/edit_bloc.dart';

class EditPage extends StatelessWidget {
  final _bloc = EditBloc();

  EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EditTask"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _bloc.taskController,
                decoration: const InputDecoration(
                  hintText: 'Input task',
                ),
                onChanged: (text) {},
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
