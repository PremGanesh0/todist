import 'package:flutter/material.dart';

class LableScreen extends StatelessWidget {
  const LableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'New Label',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Done',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        body: Column(children: [
          Card(
            child: Column(
              children: [
                TextField(
                    decoration: InputDecoration(hintText: 'Name your lable')),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.color_lens),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'color',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
