import 'package:flutter/material.dart';
import 'package:todist/screens/lable_page.dart';
import 'package:todist/screens/up_coming_page.dart';
import 'package:todist/widgets/bottom_sheet.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.settings))
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalendarPage()),
                  );
                },
                child: const SizedBox(
                  height: 60,
                  child: Card(
                    child: Row(
                      children: [Icon(Icons.calendar_month), Text('Upcoming')],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LableScreen()),
                  );
                },
                child: const SizedBox(
                  height: 60,
                  child: Card(
                    child: Row(
                      children: [
                        Icon(Icons.bookmark),
                        Text('Filters & Lables')
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'WorkSpace',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          color: Colors.red,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.expand_more),
                            color: Colors.red),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const CustomBottomSheet();
                },
              );
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          )),
    );
  }
}
