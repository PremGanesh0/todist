import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/Widgets/bottom_sheet.dart';
import 'package:todist/model/task_model.dart';
import 'package:todist/widgets/undo_task_card.dart';

enum ToggleOption {
  completed,
  notCompleted,
  allTasks,
}

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  ToggleOption toggleOption = ToggleOption.allTasks;

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
            List<DateTime> relevantDates = groupedTasks.keys.toList();
            if (toggleOption == ToggleOption.completed) {
              relevantDates = relevantDates.where((date) {
                return groupedTasks[date]!.any((task) => task.completed);
              }).toList();
            } else if (toggleOption == ToggleOption.notCompleted) {
              relevantDates = relevantDates.where((date) {
                return groupedTasks[date]!.any((task) => !task.completed);
              }).toList();
            }

            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ToggleButtons(
                      isSelected: [
                        toggleOption == ToggleOption.completed,
                        toggleOption == ToggleOption.notCompleted,
                        toggleOption == ToggleOption.allTasks,
                      ],
                      onPressed: (index) {
                        setState(() {
                          toggleOption = ToggleOption.values[index];
                        });
                      },
                      selectedColor: Colors.blue,
                      fillColor: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Completed'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Not Completed'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('All Tasks'),
                        ),
                      ],
                    ),
                  ],
                ),
                ...relevantDates.map((date) {
                  List<Task> tasks = groupedTasks[date]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 30.0),
                          child: Text(
                            DateFormat('dd-MMMM').format(date),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      ...tasks
                          .map((task) => Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20),
                                child: UndoTaskCard(task: task),
                              ))
                          .toList(),
                    ],
                  );
                }),
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
    tasks.sort((a, b) => a.date.compareTo(b.date));

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
