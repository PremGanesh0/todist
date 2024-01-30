import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/Widgets/bottom_sheet.dart';
import 'package:todist/model/task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final int? index;
  const TaskCard({Key? key, required this.task, this.index}) : super(key: key);

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
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              BlocProvider.of<TaskBloc>(context).add(CompleteTaskEvent(task));
            },
          ),
          children: [
            SlidableAction(
              onPressed: (context) {
                BlocProvider.of<TaskBloc>(context).add(CompleteTaskEvent(task));
              },
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              spacing: 1,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(task));
            },
          ),
          children: [
            SlidableAction(
              onPressed: (Context) {
                BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(task));
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Card(
          child: ListTile(
            title: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            trailing: task.completed
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
