import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todist/Bloc/task/database_provider.dart';
import 'package:todist/Bloc/task/repo.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/Widgets/popup_button.dart';
import 'package:todist/Widgets/task_card.dart';
import 'package:todist/model/task_model.dart';
import 'package:todist/widgets/bottom_sheet.dart';

class Todaypage extends StatelessWidget {
  const Todaypage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        TaskRepository(context.read<DatabaseProvider>()),
      ),
      child: const TodayPage(),
    );
  }
}

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  String? formattedDate;
  DateTime currentDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('d MMM. EEEE').format(currentDate);
    _getTasks();
  }

  _getTasks() async {
    BlocProvider.of<TaskBloc>(context).add(ReadTasksEvent());
  }

  Future<void> _refreshTasks() async {
    _getTasks();
  }

  bool check = false;
  gettaskcompleted(List<Task> tasks) {
    int count = 0;
    for (var task in tasks) {
      if (task.completed == true) {
        count++;
      }
    }
    return count == tasks.length ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: RefreshIndicator(
          onRefresh: _refreshTasks,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: popupMenuButtonCustom(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      ' Today ',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' $formattedDate',
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomBottomSheet();
                            },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Row(mainAxisSize: MainAxisSize.min, children: [
                                  Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Create Task',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // add message when there is no task for today
                check == true
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('No Task for Today'),
                      )
                    : Container(),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoadingState) {
                      return const CircularProgressIndicator();
                    } else if (state is TaskSuccessState) {
                      check = gettaskcompleted(state.tasks);
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            bool isToday = task.date.day == DateTime.now().day &&
                                task.date.month == DateTime.now().month &&
                                task.date.year == DateTime.now().year;
                            if (isToday && task.completed == false) {
                              return TaskCard(
                                task: task,
                                index: index,
                              );
                            }
                            return Container();
                          },
                        ),
                      );
                    } else if (state is TaskErrorState) {
                      return Text('Error: ${state.errorMessage}');
                    } else {
                      return const Text('Unknown state');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
