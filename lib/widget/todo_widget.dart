import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/utils.dart';

import '../models/todo.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  // final Function(BuildContext?, Todo?) deleteTodo;

  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scrollable(
        viewportBuilder: (BuildContext context, ViewportOffset position) =>
            ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Slidable(
            key: Key(todo.id),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                SlidableAction(
                  onPressed: (_) {},
                  backgroundColor: Colors.green,
                  label: 'Edit',
                  icon: Icons.edit,
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context) =>
                      deleteTodo(context, todo),
                  backgroundColor: Colors.red,
                  label: 'Delete',
                  icon: Icons.delete,
                ),
              ],
            ),
            child: buildTodo(context),
          ),
        ),
      );

  Widget buildTodo(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (_) {},
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  if (todo.description.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        todo.description,
                        style: const TextStyle(fontSize: 20, height: 1.5),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  VoidCallback? deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }
}
