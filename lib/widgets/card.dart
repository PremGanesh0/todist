import 'package:flutter/material.dart';

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
