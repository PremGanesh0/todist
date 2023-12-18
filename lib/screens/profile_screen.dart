import 'package:flutter/material.dart';
import 'package:todist/Bloc/repo/local_storage.dart';
import 'package:todist/model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  User user;
  ProfileScreen({Key? key, required this.user}) : super(key: key);
  // Fetch user data from local storage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              // You can use an image here or any other widget to represent the user's profile picture
              backgroundColor: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              user.username,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              user.email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
