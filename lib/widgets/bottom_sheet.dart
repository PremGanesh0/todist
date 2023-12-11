import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/model/task_model.dart';

import '../Bloc/task/task_bloc.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final TextEditingController title = TextEditingController();

  final TextEditingController description = TextEditingController();

  DateTime selectedDate = DateTime.now();

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
                        child: buildCard(
                            ' ${selectedDate.toLocal().month}/${selectedDate.toLocal().day}/${selectedDate.toLocal().year}',
                            Icons.today_outlined)),
                    buildCard('Priority', Icons.flag_outlined),
                    buildCard('Reminder', Icons.alarm_on_outlined),
                    IconButton(
                        onPressed: () async {
                          Task newTask = Task(
                            title: title.text,
                            description: description.text,
                            date: selectedDate,
                            priority: 'High',
                            label: 'Work',
                            remember: true,
                          );

                          // Access the TaskBloc and add the CreateTaskEvent
                          context
                              .read<TaskBloc>()
                              .add(CreateTaskEvent(newTask));
                          Navigator.pop(context);
                          title.clear();
                          description.clear();
                        },
                        icon: const Icon(Icons.save))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(String label, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
