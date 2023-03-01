import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({super.key});

  @override
  State<AddTodoDialogWidget> createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              TodoFormWidget(
                  onChangeTitle: (title) => setState(() => this.title = title),
                  onChangeDescription: (description) =>
                      setState(() => this.description = description),
                  onSaveTodo: addTodo),
            ],
          ),
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        createdTime: DateTime.now(),
        description: description,
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }
}
