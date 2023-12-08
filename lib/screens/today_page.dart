import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todist/widgets/bottom_sheet.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('d MMM. EEEE').format(currentDate);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.linear_scale,
                        color: Colors.blue,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  ' Today ',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' $formattedDate',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return   CustomBottomSheet();
                  },
                );
              },
              child: const Card(
                child: SizedBox(
                  height: 40,
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(children: [
                      Text(
                        '+',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Add Task',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
