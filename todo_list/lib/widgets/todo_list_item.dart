import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/todo.dart';


class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key,
    required this.todos,
    required this.onDelete
  }) : super(key: key);

  final Todo todos;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Slidable(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[200],
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(todos.dateTime),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  todos.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actionExtentRatio: 0.20,
          actionPane: const SlidableDrawerActionPane(),
        actions: [
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: 'Deletar',
            onTap: () {
              onDelete(todos);
            },
          ),
        ],
      ),
    );
  }


}
