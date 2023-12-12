import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart'; // Import the table_calendar package
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/Widgets/bottom_sheet.dart';
import 'package:todist/Widgets/task_card.dart';
import 'package:todist/model/task_model.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbox"),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskSuccessState) {
            Map<DateTime, List<Task>> groupedTasks = groupTasksByDate(state.tasks);

            return ListView(
              children: [
                TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  // Configure other properties as needed
                ),
                ...groupedTasks.entries
                    .map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(DateFormat('dd-MMMM').format(entry.key)),
                          ),
                          ...entry.value
                              .map((task) => TaskCard(
                                    task: task,
                                  ))
                              .toList(),
                        ],
                      );
                    })
                    .toList()
                    .reversed,
              ],
            );
          } else if (state is TaskErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const Center(child: Text('No tasks found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const CustomBottomSheet();
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Map<DateTime, List<Task>> groupTasksByDate(List<Task> tasks) {
    Map<DateTime, List<Task>> groupedTasks = {};
    for (var task in tasks) {
      DateTime date = DateTime(task.date.year, task.date.month, task.date.day);
      if (groupedTasks.containsKey(date)) {
        groupedTasks[date]!.add(task);
      } else {
        groupedTasks[date] = [task];
      }
    }
    return groupedTasks;
  }
}
