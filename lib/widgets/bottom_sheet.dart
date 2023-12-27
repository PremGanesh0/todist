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

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      title.text = widget.task!.title;
      description.text = widget.task!.description;
      selectedDate = widget.task!.date;
    } else {
      updatecheck = true;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Task Name',
                      hintStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    controller: description,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
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
                    GestureDetector(
                      onTap: () {
                        final RenderBox overlay = Overlay.of(context)
                            .context
                            .findRenderObject() as RenderBox;
                        final RelativeRect position = RelativeRect.fromRect(
                          Rect.fromPoints(
                            overlay.localToGlobal(
                              overlay.size.bottomRight(Offset.zero),
                              ancestor: overlay,
                            ),
                            overlay.localToGlobal(
                                    overlay.size.bottomRight(Offset.zero),
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
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.flag, color: Colors.blue),
                                  Text('Priority 3'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<int>(
                              value: 1,
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
                              // Handle Priority 1
                            } else if (value == 1) {
                              // Handle Priority 2
                            }
                          }
                        });
                      },
                      child: buildCard(
                          'Priority', Icons.flag_outlined, Colors.green),
                    ),
                    buildCard(
                        'Reminder', Icons.alarm_on_outlined, Colors.orange),
                    IconButton(
                      onPressed: () async {
                        if (widget.task != null) {
                          Task updatetask = Task(
                            id: widget.task!.id,
                            title: title.text,
                            description: description.text,
                            date: selectedDate,
                            priority: 'High',
                            label: 'Work',
                            remember: true,
                            completed: false,
                          );
                          BlocProvider.of<TaskBloc>(context)
                              .add(UpdateTaskEvent(updatetask));
                        } else {
                          Task createtask = Task(
                            title: title.text,
                            description: description.text,
                            date: selectedDate,
                            priority: 'High',
                            label: 'Work',
                            remember: true,
                            completed: false,
                          );
                          BlocProvider.of<TaskBloc>(context)
                              .add(CreateTaskEvent(createtask));
                        }

                        Navigator.pop(context);
                        title.clear();
                        description.clear();
                      },
                      icon: const Icon(Icons.save),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
