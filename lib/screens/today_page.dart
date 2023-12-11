import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Bloc/task/database_provider.dart';
import 'package:todist/Bloc/task/repo.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/widgets/bottom_sheet.dart';

class Todaypage1 extends StatelessWidget {
  const Todaypage1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        TaskRepository(context.read<DatabaseProvider>()),
      ),
      child: TodayPage(),
    );
  }
}

class TodayPage extends StatelessWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('d MMM. EEEE').format(currentDate);
    BlocProvider.of<TaskBloc>(context).add(LoadTasksEvent());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.linear_scale,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    ' Today ',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ' $formattedDate',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is TaskSuccessState) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];

                          // Check if the task date is today
                          bool isToday = task.date.day == DateTime.now().day &&
                              task.date.month == DateTime.now().month &&
                              task.date.year == DateTime.now().year;

                          // Display only today's tasks
                          if (isToday) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                  task.title,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(task.description),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${task.date.day} - ${task.date.month} - ${task.date.year}',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),

                      // child: ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemCount: state.tasks.length,
                      //   itemBuilder: (context, index) {
                      //     final task = state.tasks[index];

                      //     return Card(
                      //       child: ListTile(
                      //         title: Text(
                      //           task.title,
                      //           style: TextStyle(fontWeight: FontWeight.w600),
                      //         ),
                      //         subtitle: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceAround,
                      //           children: [
                      //             Text(task.description),
                      //             SizedBox(
                      //               width: 10,
                      //             ),
                      //             Text(
                      //               task.date.day.toString() +
                      //                   ' - ' +
                      //                   task.date.month.toString() +
                      //                   ' - ' +
                      //                   task.date.year.toString(),
                      //               style: TextStyle(fontSize: 10),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    );
                  } else if (state is TaskErrorState) {
                    return Text('Error: ${state.errorMessage}');
                  } else {
                    return Text('Unknown state');
                  }
                },
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return CustomBottomSheet();
                    },
                  );
                },
                child: const Card(
                  child: SizedBox(
                    height: 40,
                    width: 300,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Row(children: [
                        Text(
                          '+',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Add Task',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
