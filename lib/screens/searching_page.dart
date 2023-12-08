import 'package:flutter/material.dart';

class SearchingPage extends StatelessWidget {
  const SearchingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search for task',
          style: TextStyle(fontSize: 20  ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: 70,
          width: double.infinity, // Adjust the width as needed
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
