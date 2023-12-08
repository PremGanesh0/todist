import 'package:flutter/material.dart';
import 'package:todist/Bloc/task/database_provider.dart';
import 'package:todist/model/task_model.dart';

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet({Key? key}) : super(key: key);
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: TextField(
                  controller: title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Task Name',
                    hintStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: TextField(
                  controller: description,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description',
                    hintStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Row(
                children: [
                  buildCard('Today', Icons.today_outlined),
                  buildCard('Priority', Icons.flag_outlined),
                  buildCard('Reminder', Icons.alarm_on_outlined),
                  IconButton(
                      onPressed: () async {
                         DatabaseProvider databaseProvider =
                            DatabaseProvider.instance;

                        Task newTask = Task(
                          title: title.text,
                          description: description.text,
                          date: DateTime.now(),
                          priority: 'High',
                          label: 'Work',
                          remember: true,
                        );

                        await databaseProvider.insertTask(newTask);
                      },
                      icon: Icon(Icons.save))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String label, IconData icon) {
    return Card(
      child: SizedBox(
        height: 40,
        width: 70,
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
    );
  }
}
