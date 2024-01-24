import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/Widgets/bottom_sheet.dart';
import 'package:todist/model/task_model.dart';

class UndoTaskCard extends StatefulWidget {
  final Task task;
  final int? index;

  const UndoTaskCard({Key? key, required this.task, this.index}) : super(key: key);

  @override
  _UndoTaskCardState createState() => _UndoTaskCardState();
}

class _UndoTaskCardState extends State<UndoTaskCard> {
  bool deleteVisible = false;
  int swipeCounter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Check the direction of the swipe
        if (details.primaryDelta! > 0) {
          // Increment the swipe counter
          setState(() {
            swipeCounter++;
            // Show delete icon when swiped at least 20%
            deleteVisible = swipeCounter >= 20;
          });
        }
      },
      onTap: () {
        if (deleteVisible) {
          // If delete icon is visible, delete the task
          BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(widget.task));
        } else {
          // If not, open the bottom sheet for editing the task
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return CustomBottomSheet(
                task: widget.task,
              );
            },
          );
        }
      },
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          setState(() {
            swipeCounter = 0;
          });
        },
        background: Container(
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20.0),
          child: const Row(
            children: [
              Text(
                'Undo Task',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.check, color: Colors.white),
            ],
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: const Row(
            children: [
              Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.delete, color: Colors.white),
            ],
          ),
        ),
        confirmDismiss: (direction) async {
          // Allow dismiss when swiped at least 20%
          return deleteVisible;
        },
        child: Card(
          child: ListTile(
            title: Text(
              widget.task.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.task.description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${widget.task.date.day} - ${widget.task.date.month} - ${widget.task.date.year}',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            trailing: IconButton(
              icon: widget.task.completed
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.radio_button_unchecked,
                      color: Colors.red,
                    ),
              onPressed: () {
                if (widget.task.completed) {
                  BlocProvider.of<TaskBloc>(context).add(UndoTaskEvent(widget.task));
                } else {
                  BlocProvider.of<TaskBloc>(context).add(CompleteTaskEvent(widget.task));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
