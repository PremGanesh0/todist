import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/Widgets/bottom_sheet.dart';
import 'package:todist/model/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final int index;
  const TaskCard({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return CustomBottomSheet(
              task: task,
            );
          },
        );
      },
      child: Dismissible(
        key: Key(task.id.toString()),
        background: Container(
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20.0),
          child: const Icon(Icons.check, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart ||
              direction == DismissDirection.startToEnd) {
            return showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm'),
                  content: Text(direction == DismissDirection.endToStart
                      ? 'Do you want to delete this task?'
                      : 'Mark this task as done?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          }
          return null;
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
          } else if (direction == DismissDirection.endToStart) {
            BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(task.id!));
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('${task.title} task is deleted'),
            //   ),
            // );
          }
          // Remove the task from the list
          // setState(() {
          //   state.tasks.removeAt(index);
          // });
        },
        child: Card(
          child: ListTile(
            title: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    task.description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${task.date.day} - ${task.date.month} - ${task.date.year}',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
