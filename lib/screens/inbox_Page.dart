import 'package:flutter/material.dart';
import 'package:todist/widgets/bottom_sheet.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.linear_scale,
                      color: Colors.blue,
                    ))),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Inbox',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return   CustomBottomSheet();
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
