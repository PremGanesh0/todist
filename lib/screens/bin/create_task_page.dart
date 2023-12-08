import 'package:flutter/material.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create task',
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 40),
                child: Text(
                  'Title',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Expanded(
                  flex: 1,
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: () {},
                      child: const Text('cancle')),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Add Task')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
