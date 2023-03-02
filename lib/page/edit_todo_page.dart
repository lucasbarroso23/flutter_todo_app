import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo_form_widget.dart';

import '../models/todo.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({super.key, required this.todo});

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Todo'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);

                provider.removeTodo(widget.todo);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: description,
              onChangeTitle: (title) => setState(
                () {
                  this.title = title;
                },
              ),
              onChangeDescription: (description) => setState(() {
                this.description = description;
              }),
              onSaveTodo: saveTodo,
            ),
          ),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);

      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
    }
  }
}
