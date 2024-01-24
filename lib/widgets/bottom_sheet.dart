import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Widgets/card.dart';
import 'package:todist/model/task_model.dart';

import '../Bloc/task/task_bloc.dart';

class CustomBottomSheet extends StatefulWidget {
  final Task? task;
  const CustomBottomSheet({Key? key, this.task}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool updatecheck = false;
  String priority = 'priority 1';
  Color flagColor = Colors.red;

  Flagcolor(String priority) {
    if (priority == 'priority 1') {
      return Colors.red;
    } else if (priority == 'priority 2') {
      return Colors.yellow;
    } else if (priority == 'priority 3') {
      return Colors.blue;
    } else {
      return Colors.black;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      title.text = widget.task!.title;
      description.text = widget.task!.description;
      selectedDate = widget.task!.date;
      priority = widget.task!.priority;
      flagColor = Flagcolor(widget.task!.priority);
    } else {
      updatecheck = true;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: widget.task!.date ?? DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String getButtonText() {
    return widget.task != null ? 'Modify Task' : 'Add Task';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    controller: title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Task Name',
                      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    controller: description,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: updatecheck == false
                            ? buildCard(
                                ' ${widget.task!.date.day}/${widget.task!.date.month}/${widget.task!.date.year}',
                                Icons.today_outlined,
                                Colors.blue, // Pass the desired color
                              )
                            : buildCard('Today', Icons.today, Colors.blue),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            final RenderBox overlay =
                                Overlay.of(context).context.findRenderObject() as RenderBox;
                            final RelativeRect position = RelativeRect.fromRect(
                              Rect.fromPoints(
                                overlay.localToGlobal(
                                  overlay.size.bottomRight(Offset.zero),
                                  ancestor: overlay,
                                ),
                                overlay.localToGlobal(overlay.size.bottomRight(Offset.zero),
                                        ancestor: overlay) +
                                    const Offset(200.0, 0.0),
                              ),
                              Offset.zero & overlay.size,
                            );
                            showMenu(
                              context: context,
                              position: position,
                              items: <PopupMenuEntry<int>>[
                                const PopupMenuItem<int>(
                                  value: 0,
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag, color: Colors.red),
                                      Text('Priority 1'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<int>(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag, color: Colors.yellow),
                                      Text('Priority 2'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<int>(
                                  value: 2,
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag, color: Colors.blue),
                                      Text('Priority 3'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<int>(
                                  value: 3,
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag),
                                      Text('Priority 4'),
                                    ],
                                  ),
                                ),
                              ],
                              elevation: 8.0,
                            ).then((value) {
                              if (value != null) {
                                if (value == 0) {
                                  setState(() {
                                    priority = 'priority 1';
                                    flagColor = Colors.red;
                                  });
                                } else if (value == 1) {
                                  setState(() {
                                    priority = 'priority 2';
                                    flagColor = Colors.yellow;
                                  });
                                } else if (value == 2) {
                                  setState(() {
                                    priority = 'priority 3';
                                    flagColor = Colors.blue;
                                  });
                                } else {
                                  setState(() {
                                    priority = 'priority 4';
                                    flagColor = Colors.black;
                                  });
                                }
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.flag,
                                color: flagColor,
                              ),
                              Text(priority),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const Divider(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [Icon(Icons.inbox), Text('inbox'), Icon(Icons.expand_more)],
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            title.clear();
                            description.clear();
                          },
                          child: const Text('Cancle')),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {
                          if (widget.task != null) {
                            Task updatetask = Task(
                              id: widget.task!.id,
                              serverid: widget.task!.serverid,
                              title: title.text,
                              description: description.text,
                              date: selectedDate,
                              priority: priority,
                              label: 'Work',
                              remember: widget.task!.remember,
                              completed: widget.task!.completed,
                            );
                            // print("modify task button pressed");
                            // print(updatetask.title);
                            BlocProvider.of<TaskBloc>(context).add(UpdateTaskEvent(updatetask));
                          } else {
                            Task createtask = Task(
                              title: title.text,
                              description: description.text,
                              date: selectedDate,
                              priority: priority,
                              label: 'Work',
                              remember: false,
                              completed: false,
                            );

                            BlocProvider.of<TaskBloc>(context).add(CreateTaskEvent(createtask));
                          }
                          Navigator.pop(context);
                          title.clear();
                          description.clear();
                        },
                        child: title.text.isEmpty ? const Text('Add Task') : Text(getButtonText()),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
