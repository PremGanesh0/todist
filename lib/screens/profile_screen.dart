import 'package:flutter/material.dart';
import 'package:todist/Bloc/repo/local_storage.dart';
import 'package:todist/api/updateUserProfile_api.dart';
import 'package:todist/model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user.username);
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController();
  }

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
              backgroundColor: Colors.blue,
              // You can use an image here or any other widget to represent the user's profile picture
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Username: '),
                Container(
                  width: 200,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Email: '),
                Container(
                  width: 200,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Password: '),
                Container(
                  width: 200,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              //  updateUserProfile(
              //    username: usernameController.text,
              //   email: emailController.text,
              //    password: passwordController.text,
              //    // Add the profileImage parameter if needed
              //  );
              },
              child: Text('Edit'),
            )
          ],
        ),
      ),
    );
  }
}

