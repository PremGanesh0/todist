import 'package:flutter/material.dart';
import 'package:todist/screens/bin/drawer_page.dart';
import 'package:todist/screens/bin/create_task_page.dart';

class TaskAddPage extends StatelessWidget {
  const TaskAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      drawer: const SizedBox(
          child: Drawer(
        backgroundColor: Colors.grey,
        child: DrawerPage(),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateTaskPage()),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '+  Add Task',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Image.asset('assert/Screenshot 2023-11-23 152940.png')
          ],
        ),
      ),
    );
  }
}
