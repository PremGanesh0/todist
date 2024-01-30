import 'package:flutter/material.dart';
import 'package:todist/api/update_user_profile_api.dart';
import 'package:todist/model/user_model.dart';

class ChangePassword extends StatefulWidget {
  User user;
  ChangePassword({required this.user}) : super();

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  bool passwordObscureText = true;
  bool conformPasswordObscureText = true;

  bool passwordsMatch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(passwordObscureText
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordObscureText = !passwordObscureText;
                      });
                    },
                  )),
              obscureText: passwordObscureText,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Confirm New Password',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: confirmNewPasswordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(conformPasswordObscureText
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        conformPasswordObscureText =
                            !conformPasswordObscureText;
                      });
                    },
                  )),
              obscureText: conformPasswordObscureText,
              onChanged: (value) {
                setState(() {
                  passwordsMatch = newPasswordController.text ==
                      confirmNewPasswordController.text;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (passwordsMatch) {
                  updateUserProfileApi(
                      password: confirmNewPasswordController.text,
                      username: widget.user.username,
                      email: widget.user.email,
                      profileImage: widget.user.profileImage);
                  FocusScope.of(context).unfocus();
                  newPasswordController.clear();
                  confirmNewPasswordController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords do not match'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Center(child: Text('Update Password')),
            ),
          ],
        ),
      ),
    );
  }
}
