import 'package:flutter/material.dart';
import 'package:todist/screens/bin/create_task_page.dart';
import 'package:todist/screens/searching_page.dart';
import 'package:todist/screens/bin/task_add_page.dart';
import 'package:todist/screens/upComePage.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 200,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // CircleAvatar(
                          //   child: Image.asset(
                          //       'asset/Screenshot 2023-11-15 151801.png'),
                          //   radius: 20,
                          // ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text(
                                'Welcome,',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Task pareto',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          SizedBox(width: 100),
                          Icon(Icons.notifications)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: SizedBox(
                        height: 40,
                        width: 250,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>const  CreateTaskPage()),
                              );
                            },
                            child: const Text(
                              '+  Add Task',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ))),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchingPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [Icon(Icons.search), Text('Search')],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateTaskPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            children: [Icon(Icons.inbox), Text('Inbox')],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TaskAddPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [Icon(Icons.today), Text('Today')],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CalendarPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [Icon(Icons.upcoming), Text('Upcoming')],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [Icon(Icons.label), Text('Lable')],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Favorites',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Work space',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue),
                      child: const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Row(
                          children: [
                            Icon(Icons.work_sharp),
                            Text('Work space')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
